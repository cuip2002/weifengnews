//
//  RefreshViewController.m
//  WeiFengPriject
//
//  Created by ibokan on 13-4-30.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "RefreshViewController.h"
#import "TitleView.h"
#import "MessageTableViewCell.h"
#import "ImageManager.h"
#import "OpenPlistData.h"
#define PHOTONUM 3

@interface RefreshViewController ()

@end

@implementation RefreshViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化3张的图片
    NSMutableArray * arrImage = [[NSMutableArray alloc] initWithCapacity:3];
    self.imageViewArr = arrImage;
    [arrImage release];
    
    //初始化图片
    NSMutableArray * image = [[NSMutableArray alloc] init];
    self.imageArr = image;
    [image release];
    
    //初始化获取的全部新闻
    NSMutableArray * array = [[NSMutableArray alloc] init];
    self.allMessageArray = array;
    [array release];
    
    //初始化显示的15条新闻
    NSMutableArray * list = [[NSMutableArray alloc] init];
    self.showMessageArr = list;
    [list release];
    
    //初始化请求数据
    MessageManager * manger = [[MessageManager alloc] init];
    manger.delegate = self;
    self.manager = manger;
    [manger loadNews:0];
    
    
    
    //加载图片的文字显示
    TitleView * title = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 44*VIEW_FRAME_HEIGHT)];
    [self.view addSubview:title];
    [title release];
    
    //初始化表格
    UITableView * table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320*VIEW_FRAME_WIDTH, 416*VIEW_FRAME_HEIGHT)];
    
    table.delegate = self;
    table.dataSource = self;
    //不显示垂直滚动条
    table.showsVerticalScrollIndicator = NO;
    self.tableView = table;
    [self.view addSubview:table];
    [table release];
    //显示内容正在加载，不允许用户交互
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(90, 150, 120, 120)];
    [self.view addSubview:loadingView];
    for (UIView * v in self.view.subviews)
    {
        v.userInteractionEnabled = NO;
    }
    
    [self setRefreshHead];
    [self setRefreshHoot];
    
    //监听网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:@"kNetworkReachabilityChangedNotification" object:nil];
    hostReach = [[Reachability reachabilityWithHostName:@"www.weiphone.com"] retain];
    [hostReach startNotifier];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(brum) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view.
}

#pragma mark---连接改变
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability * curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
#pragma mark---改变后的处理
- (void)updateInterfaceWithReachability:(Reachability*) curReach
{
    NetworkStatus status = [curReach currentReachabilityStatus];
    if(status == NotReachable)
    {
        PassNetViewController * passNet = [[PassNetViewController alloc] init];
        [self presentViewController:passNet animated:YES completion:nil];
        [passNet release];
    }
}

#pragma mark---加载下拉刷新
- (void)setRefreshHead
{
    if(self.refreshHeaderView==nil)
    {
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, 0)];
        view.delegate = self;
        [self.tableView setTableHeaderView:view];
        //下拉视图
        self.refreshHeaderView = view;
        [view release];
    }
    [self.refreshHeaderView refreshLastUpdatedDate];
}
#pragma mark---head的代理 下拉刷新的代理方法
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    reloading = YES;
    //设置定时器，设置下拉刷新的请求时间的多少
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doneLoadingTableViewHardData) userInfo:nil repeats:NO];
    //显示内容正在加载，不允许用户交互
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(90, 150, 120, 120)];
    [self.view addSubview:loadingView];
    for (UIView * v in self.view.subviews) {
        v.userInteractionEnabled = NO;
    }
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return reloading;
}
#pragma mark---结束下拉刷新
- (void)doneLoadingTableViewHardData
{
    reloading = NO;
    [self.allMessageArray removeAllObjects];
    [self.showMessageArr removeAllObjects];
    m=0;
    n=0;
    [self.manager loadNews:0];
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.delegate =self;
}

#pragma mark---delegate
#pragma mark---tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.showMessageArr.count==0)
    {
        return 15;
    }
    return self.showMessageArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIden = @"cell";
    static NSString * cellScrol = @"scro";
    MessageTableViewCell * messageCell = [tableView dequeueReusableCellWithIdentifier:@"ce"];
    //判断是否存在
    if(self.allMessageArray.count!=0)
    {
        //如果是第0行
        if(indexPath.row==0)
        {
            UITableViewCell * cell = nil;
            //如果是空
            if(cell==nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellScrol] autorelease];
                //如果图片不存在
                if(self.imageViewArr.count==0)
                {
                    //初始化滚动视图
                    ImageScrollView * scroll = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 156*VIEW_FRAME_HEIGHT)];
                    self.scroll = scroll;
                    //滚动视图的背景
                    scroll.backgroundColor = [UIColor clearColor];
                    scroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
                    scroll.pagingEnabled = YES;
                    scroll.showsHorizontalScrollIndicator = NO;
                    scroll.delegate = self;
                    //滚动视图的范围大小
                    scroll.contentSize = CGSizeMake(320*PHOTONUM*VIEW_FRAME_WIDTH, 156*VIEW_FRAME_HEIGHT);
                    [cell addSubview:scroll];
                    [scroll release];
                    for(int i=0;i<3;i++)
                    {
                        Message * mess = [self.imageArr objectAtIndex:i];
                        ImageManager * magager = [[ImageManager alloc] init];
                        magager.delegate = self;
                        [magager loadImage:mess.image];
                    }
                    //在视图上加载UIPageControl对象
                    UIPageControl * pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(280, 136.5, 15, 12)];
                    self.pageControl = pageControl;
                    //分页控制器的初始颜色
                    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
                    //分页控制器的个数
                    self.pageControl.numberOfPages=PHOTONUM;
                    [cell addSubview:self.pageControl];
                    [pageControl release];
                }
                else
                {
                    //如果滚动视图已存在
                    for(int i=0;i<self.imageViewArr.count;i++)
                    {
                        Message * mess = [self.imageArr objectAtIndex:i];
                        UIImageView * ima = [self.imageViewArr objectAtIndex:i];
                        [self.scroll addSubview:ima];
                        [cell addSubview:self.scroll];
                        BackgroundView * bgView = [[BackgroundView alloc] initWithFrame:CGRectMake(0, 131, 320*VIEW_FRAME_WIDTH, 25*VIEW_FRAME_HEIGHT)];
                        bgView.titleLab.text = mess.title;
                        [ima addSubview:bgView];
                        [bgView release];
                        
                        UIPageControl * pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(280, 136.5, 15, 12)];
                        self.pageControl = pageControl;
                        //分页控制器初始颜色
                        self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
                        self.pageControl.numberOfPages=PHOTONUM;
                        [cell addSubview:self.pageControl];
                        [pageControl release];
                    }
                }
            }
            return cell;
        }
        else
        {
            if(messageCell==nil)
            {
               
                //从第二行，开始加载新闻的第一个内容
                Message * mess = [self.showMessageArr objectAtIndex:indexPath.row-1];
                NSLog(@"%@",mess.image);
                //取出已经阅读过的新闻数据
                NSMutableSet * readedNews = [OpenPlistData readFromFile];
                if([readedNews containsObject:mess.urlString])
                {
                    messageCell = [[[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden]  autorelease];
                    //设置点击行的时候不变色
                    messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //每条新闻的标题信息
                    messageCell.titleLab.text = mess.title;
                    messageCell.titleLab.textColor = [UIColor colorWithRed:153/255.0 green:156/255.0 blue:178/255.0 alpha:1];
                    //每条新闻的类型，浏览次数
                    messageCell.browseAndTypeLab.text = [NSString stringWithFormat:@"%@新闻（%@次浏览）",mess.typeName,mess.browseTiger];
                    messageCell.browseAndTypeLab.textColor = [UIColor colorWithRed:183/255.0 green:186/255.0 blue:202/255.0 alpha:1];
                    
                    //设置时间
                    //设置获取的时间的长度
                    NSString * time = [mess.date substringToIndex:10];
                    //获取的时间以/分割
                    NSArray * timeArr = [time componentsSeparatedByString:@"/"];
                    //定义一个可变字符串数组（用来拼接）
                    NSMutableString * timeStr = [[NSMutableString alloc] init];
                    //循环取出时间，拼接显示
                    for (NSString * str in timeArr)
                    {
                        //如果是最后一个字符，不需要加-
                        if ([str isEqualToString:[timeArr lastObject]])
                        {
                            [timeStr appendFormat:@"%@",str];
                        }
                        else
                        {
                            [timeStr appendFormat:@"%@-",str];
                        }
                        
                    }
                    messageCell.dateLab.text = timeStr;
                    [timeStr release];
                    messageCell.dateLab.textColor = [UIColor colorWithRed:183/255.0 green:186/255.0 blue:202/255.0 alpha:1];
                    messageCell.backgroundView = nil;
                    messageCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg_press.png"]];
                    
                }
                else
                {
                    messageCell = [[[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden]  autorelease];
                    //设置点击行的时候不变色
                    messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //每条新闻的标题信息
                    messageCell.titleLab.text = mess.title;
                    //每条新闻的类型，浏览次数
                    messageCell.browseAndTypeLab.text = [NSString stringWithFormat:@"%@新闻（%@次浏览）",mess.typeName,mess.browseTiger];
                    
                    //设置时间
                    //设置获取的时间的长度
                    NSString * time = [mess.date substringToIndex:10];
                    //获取的时间以/分割
                    NSArray * timeArr = [time componentsSeparatedByString:@"/"];
                    //定义一个可变字符串数组（用来拼接）
                    NSMutableString * timeStr = [[NSMutableString alloc] init];
                    //循环取出时间，拼接显示
                    for (NSString * str in timeArr)
                    {
                        //如果是最后一个字符，不需要加-
                        if ([str isEqualToString:[timeArr lastObject]])
                        {
                            [timeStr appendFormat:@"%@",str];
                        }
                        else
                        {
                            [timeStr appendFormat:@"%@-",str];
                        }
                        
                    }
                    messageCell.dateLab.text = timeStr;
                    [timeStr release];
                }
                }
        }
        
        return messageCell;
    }
    else
    {
        UITableViewCell * cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellScrol] autorelease];
        return cell;
    }
    return nil;
}
#pragma mark 设置行高
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 156;
    }
    return 65;
}

#pragma mark---加载上拉刷新
- (void)setRefreshHoot
{
    if(self.refreshFooderView==nil)
    {
        EGORefreshTableFooterView * view = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.tableView.bounds.size.height, self.view.frame.size.width, 0)];
        view.delegate = self;
        [self.tableView setTableFooterView:view];
        self.refreshFooderView = view;
        [view release];
    }
    [self.refreshFooderView refreshLastUpdatedDate];
}
#pragma mark---结束加载
- (void)doneLoadingTableViewFootData
{
    reloading = NO;
	[self.refreshFooderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    //如果显示的新闻条数小于获取的全部条数，则直接显示在屏幕上
    if(self.showMessageArr.count<self.allMessageArray.count)
    {
        [self loadListScreen:self.allMessageArray];
    }
    else
    {
        //否则在次从网上获取新闻信息
        n++;
        [self.manager loadNews:n];
    }
}

#pragma mark---food的代理 上拉刷新的代理
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view
{
    reloading = YES;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doneLoadingTableViewFootData) userInfo:nil repeats:NO];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view
{
    return reloading;
}

- (NSDate *)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView *)view
{
    return [NSDate date];
}

#pragma mark---判断上上拉刷新 还是下拉刷新  scroll的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 200)
    {
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    if(scrollView.contentOffset.y > 200)
    {
        [self.refreshFooderView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < 200)
    {
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    if(scrollView.contentOffset.y > 200)
    {
        [self.refreshFooderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark---得到数据
- (void)getNewsArray:(NSArray *)allMessage
{
    //取消显示内容正在加载，允许用户交互
    loadingView.hidden = YES;
    for(UIView * v in self.view.subviews)
    {
        v.userInteractionEnabled = YES;
    }
    [self.allMessageArray addObjectsFromArray:allMessage];;
    NSSortDescriptor * sort = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:1];
    NSArray * tempArr = [self.allMessageArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    [self.allMessageArray removeAllObjects];
    for(int i=tempArr.count-1;i>=0;i--)
    {
        [self.allMessageArray addObject:[tempArr objectAtIndex:i]];
    }
    [self loadListScreen:self.allMessageArray];
}

#pragma mark---显示在屏幕上
- (void)loadListScreen:(NSMutableArray *)array
{
    int i;
    for(i=m;i<15+m;i++)
    {
        [self.showMessageArr addObject:[array objectAtIndex:i]];
    }
    if(self.imageArr.count==0)
    {
        for(int j=0;j<3;j++)
        {
            [self.imageArr addObject:[array objectAtIndex:j]];
        }
    }
    m=i;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

#pragma mark---加载图片
- (void)postImage:(UIImage *)image
{
    Message * mess = [self.imageArr objectAtIndex:x];
    UIImageView * ima = [[UIImageView alloc] initWithFrame:CGRectMake(320*x, 0, 320*VIEW_FRAME_WIDTH, 156*VIEW_FRAME_HEIGHT)];
    ima.image = image;
    BackgroundView * bgView = [[BackgroundView alloc] initWithFrame:CGRectMake(0, 131, 320*VIEW_FRAME_WIDTH, 25*VIEW_FRAME_HEIGHT)];
    bgView.titleLab.text = mess.title;
    [ima addSubview:bgView];
    [bgView release];
    [self.scroll addSubview:ima];
    [self.imageViewArr addObject:ima];
    [ima release];
    x++;
}

#pragma mark---滚动页面分页控制器的变化
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;//滚动内容的偏移量
    int currentPoint=point.x/320;
    self.pageControl.currentPage=currentPoint;
}
#pragma mark---
- (void)brum
{
    CGPoint pointOffset = CGPointMake((scre_x+1)%3*320, 0);
    [self.scroll setContentOffset:pointOffset animated:YES];
    CGPoint point = self.scroll.contentOffset;//滚动内容的偏移量
    int currentPoint=(point.x+320)/320;
    if(currentPoint==3)
        currentPoint = 0;
    self.pageControl.currentPage=currentPoint;
    scre_x++;
}

#pragma mark---进入详细页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row!=0)
    {
        DetailViewController * detail = [[[DetailViewController alloc] init]autorelease];
        Message * mess = [self.showMessageArr objectAtIndex:indexPath.row-1];
        detail.mess = mess;
        detail.messageArray = self.showMessageArr;
        //保存读过的新闻信息   将新闻的时间作为
        NSMutableSet * setData = [OpenPlistData readFromFile];
        [setData addObject:mess.urlString];
        [OpenPlistData saveToFile:setData];
        [self.tableView reloadData];
        [self presentViewController:detail animated:YES completion:nil];
    }
}

#pragma end

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
