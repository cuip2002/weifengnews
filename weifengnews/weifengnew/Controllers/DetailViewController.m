//
//  DetailViewController.m
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "DetailViewController.h"
#import "TitleView.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.delegate = self;
    self.disTitle.text = [NSString stringWithFormat:@"玩家评论（%d）",self.showDisArr.count];
    [self.showButton setTitle:[NSString stringWithFormat:@"更多评论(%d)",self.discummArray.count-self.showDisArr.count] forState:   UIControlStateNormal];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //显示的评论的条数
    self.showDisArr = [[[NSMutableArray alloc] init] autorelease];
    //实例化数据的数字  得到每一调评论的信息
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    self.discummArray = arr;
    [arr release];
    //获取选择的行的新闻的ID
    NSString * IDString = [self.mess.urlString substringWithRange:NSMakeRange(self.mess.urlString.length-12, 6)];
    self.discussID = IDString;
    
    DetailManager * manager = [[DetailManager alloc] init];
    manager.delegate = self;
    self.manager = manager;
    //上一个页面获取的网址去请求新闻的详细内容
    [manager loadDetailMessage:self.mess.urlString];
    
    
    DiscussManager * disManager = [[DiscussManager alloc] init];
    //用新闻的ID 请求评论信息
    disManager.delegate = self;
    self.disCussManager = disManager;
    [disManager loadDiscuss:self.discussID];
    
    
    
    //请求图片信息
    ImageManager * imageManager = [[ImageManager alloc] init];
    imageManager.delegate = self;
    self.imageManager = imageManager;
    [imageManager loadImage:self.mess.image];
    
    
    //设置显示导航视图
    TitleView * titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 44*VIEW_FRAME_HEIGHT)];
    [self.view addSubview:titleView];
    
    //显示新闻信息的内容
    NewsDetailView * bgView = [[NewsDetailView alloc] initWithFrame:CGRectMake(0, 44*VIEW_FRAME_HEIGHT, 320*VIEW_FRAME_WIDTH, 416*VIEW_FRAME_HEIGHT)];
    self.newsDetailView = bgView;
    [self.view addSubview:bgView];
    
    //设置返回按钮
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(6, 5, 50, 30);
    [backBtn addTarget:self action:@selector(popToLastControl) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [titleView addSubview:backBtn];
    
    //返回顶部按钮
    UIButton * headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame = CGRectMake(220, 7, 50, 30);
    [headBtn setBackgroundImage:[UIImage imageNamed:@"nav_left.png"] forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:headBtn];
    //顶部，底部按钮的分隔线
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(270, 7, 1, 29)];
    image.image = [UIImage imageNamed:@"nav_center.png"];
    [titleView addSubview:image];
    
    //跳到底部的按钮
    UIButton * foottBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    foottBtn.frame = CGRectMake(271, 7, 50, 30);
    [foottBtn addTarget:self action:@selector(footAction) forControlEvents:UIControlEventTouchDown];
    [foottBtn setBackgroundImage:[UIImage imageNamed:@"nav_right.png"] forState:UIControlStateNormal];
    [titleView addSubview:foottBtn];
    [titleView release];
    [image release];
    [bgView release];
	// Do any additional setup after loading the view.
}
#pragma mark----得到玩家评论的数据
- (void)getDiscussArr:(NSArray *)array
{
    [self.discummArray removeAllObjects];
    [self.showDisArr removeAllObjects];
    //把数据加载到数组中
    [self.discummArray addObjectsFromArray:array];
    NSLog(@"%d",array.count);
    if(self.discummArray.count>2)
    {
        for(int i=0;i<2;i++)
        {
            [self.showDisArr addObject:[self.discummArray objectAtIndex:i]];
        }
    }
    else
    {
        [self.showDisArr addObjectsFromArray:self.discummArray];
    }
    if (self.disTitle == nil) {
        //加载评论也的标题
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 14, 100, 14)];
        self.disTitle = titleLab;
        //显示文字
        titleLab.text = [NSString stringWithFormat:@"玩家点评（%d）",self.showDisArr.count];
        titleLab.textColor = [UIColor colorWithRed:66.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1.0];
        //设置字体的大小
        titleLab.font = [UIFont italicSystemFontOfSize:14];
        //清除背景颜色
        titleLab.backgroundColor = [UIColor clearColor];
        //添加
        [self.newsDetailView.commentView addSubview:titleLab];
        [titleLab release];
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(260, 0, 50, 50)];
        image.image = [UIImage imageNamed:@"ne.png"];
        [self.newsDetailView.commentView addSubview:image];
        [image release];
        
        //加载按钮
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(10, 355, 290, 45);
        self.showButton = btn;
        btn.tintColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[NSString stringWithFormat:@"更多评论(%d)",self.discummArray.count-self.showDisArr.count] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showAll) forControlEvents:UIControlEventTouchDown];
        [self.newsDetailView.commentView addSubview:btn];
    }
    
    //加载评论的tableView视图
    if (self.tableView == nil)
    {
        UITableView * table = [[[UITableView alloc] initWithFrame:CGRectMake(5, 44, 300, 300)] autorelease];
        self.tableView = table;
        table.dataSource = self;
        table.delegate = self;
        //设置背景颜色为空
        table.backgroundView = nil;
        table.backgroundColor = [UIColor clearColor];
        [self.newsDetailView.commentView addSubview:table];
    }
    else
    {
        [super viewDidAppear:YES];
        [self.tableView reloadData];
    }
    
}
-(void)showAll
{
    [self.showDisArr removeAllObjects];
    [self.showDisArr addObjectsFromArray:self.discummArray];
    [self.tableView reloadData];
    [self.showButton setTitle:@"更多评论(0)" forState:UIControlStateNormal];
    self.disTitle.text = [NSString stringWithFormat:@"玩家评论（%d）",self.showDisArr.count];

    
}
#pragma mark---返回tableView的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark---返回tableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showDisArr.count;
}
#pragma mark---
- (DiscussCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出评论的对象信息
    Comment * comment = [self.showDisArr objectAtIndex:indexPath.row];
    static NSString * cellIden = @"cell";
    //cell 的重用机制
    DiscussCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if(cell==nil)
    {
        //实例化cell
        cell = [[[DiscussCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden] autorelease];
    }

    NSString * time  = [comment.add_time substringFromIndex:5];
    //发表评论的时间
    cell.dateLab.text = time;
    //
    cell.nameLab.text = [NSString stringWithFormat:@"%@ ",comment.user_name];
    //设置评论文本框架的大小
    CGSize sizeToCon = [comment.content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(210, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    //文本内容的框架
    cell.contextLab.frame = CGRectMake(cell.contextLab.frame.origin.x,cell.contextLab.frame.origin.y,sizeToCon.width,sizeToCon.height);
    //设置评论的整体框架
    CGRect rect = cell.contextLab.frame;
    rect.size = sizeToCon;
    //设置文本内容
    [cell.contextLab setText:comment.content];
    //设置文本的框架
    [cell.contextLab setFrame:rect];
    cell.userInteractionEnabled = NO;
    //变化后调整框架
    [cell.otherImage setFrame:CGRectMake(60, cell.contextLab.frame.origin.y+cell.contextLab.frame.size.height+12.5, 100, 38)];
    //设置cell 的高度  要返回cell高度是条用
    [cell setFrame:CGRectMake(0, 0, 300, cell.otherImage.frame.size.height+cell.otherImage.frame.origin.y+15)];
    //加载评论的内容
    cell.contextLab.text = comment.content;
    cell.selectLab.text = [NSString stringWithFormat:@"顶(%@)",comment.score_1];
    cell.notSelectLab.text = [NSString stringWithFormat:@"踩(%@)",comment.score_2];
    return cell;
}
#pragma mark---每一条cell的高度
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先的到每一条评论
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //返回高度
    return cell.frame.size.height;
}
#pragma  mark 返回顶部
- (void)headAction
{
    //翻到新闻信息页
    //    [self.bgView.scrollView  setContentOffset:CGPointMake(0, 0) animated:YES];
    for(int i=0;i<self.messageArray.count;i++)
    {
        Message * message = [self.messageArray objectAtIndex:i];
        if([self.mess.urlString isEqualToString:message.urlString])
        {
            if(i>0)
            {
                message = [self.messageArray objectAtIndex:i-1];
                self.mess = message;
                [self.manager loadDetailMessage:self.mess.urlString];
                [self.imageManager loadImage:self.mess.image];
                NSString * str = [self.mess.urlString substringFromIndex:self.mess.urlString.length-12];
                NSString * IDString = [str substringToIndex:6];
                self.discussID = IDString;
                [self.disCussManager loadDiscuss:self.discussID];
                //                [self viewDidAppear:YES];
                //                self.tableView.delegate = self;
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"已经是第一条信息了！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
                [alert release];
            }
        }
    }

}
#pragma  mark 到达底部
- (void)footAction
{
    //翻到评论页
    //    [self.bgView.scrollView  setContentOffset:CGPointMake(0, self.bgView.contentView.frame.size.height+10) animated:YES];
    for(int i=0;i<self.messageArray.count-1;i++)
    {
        Message * message = [self.messageArray objectAtIndex:i];
        if([self.mess.urlString isEqualToString:message.urlString])
        {
            if(i<self.messageArray.count)
            {
                message = [self.messageArray objectAtIndex:i+1];
                self.mess = message;
                [self.manager loadDetailMessage:self.mess.urlString];
                [self.imageManager loadImage:self.mess.image];
                NSString * str = [self.mess.urlString substringFromIndex:self.mess.urlString.length-12];
                NSString * IDString = [str substringToIndex:6];
                self.discussID = IDString;
                [self.disCussManager loadDiscuss:self.discussID];
                //               [self viewDidAppear:YES];
                break;
                //                self.tableView.delegate = self;
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"已经是最后一条信息了！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
                [alert release];
            }
        }
    }

}
#pragma  mark 图片下载代理方法
- (void)postImage:(UIImage *)image
{
    self.newsDetailView.imageView.image = image;
}
#pragma mark 获取新闻的内容
- (void)getContext:(NSString *)context comeString:(NSString *)comeString title:(NSString *)title
{
    //详细信息界面的标题
    self.newsDetailView.theme.text = self.mess.title;
    //获取新闻发布的时间
    NSArray * timeArr = [self.mess.date componentsSeparatedByString:@" "];
    NSString * date = [timeArr objectAtIndex:0];
    //获取的时间以/分割
    NSArray * time = [date componentsSeparatedByString:@"/"];
    NSLog(@"%d",time.count);
    //定义一个可变字符串数组（用来拼接）
    NSMutableString * timeStr = [[NSMutableString alloc] init];
    //循环取出时间，拼接显示
    //for (int x = 0;x < time.count; x ++)
    //{
    [timeStr appendFormat:@"%@年%@月%@日",[time objectAtIndex:0],[time objectAtIndex:1],[time objectAtIndex:2]];
    //}
 
    self.newsDetailView.source.text = [NSString stringWithFormat:@"%@ %@ %@次浏览",comeString,timeStr,self.mess.browseTiger];
    
    //根据\r\n截取数组
    NSArray * arr = [title componentsSeparatedByString:@"\r\n"];
    //定义一个可变字符串
    NSMutableString * str = [[NSMutableString alloc] init];
    for(int i=0;i<arr.count;i++)
    {
        //取出数组的内容，拼接字符串
        [str appendString:[arr objectAtIndex:i]];
    }
    //取出的字符串有很多空格
    for(int i=0;i<str.length;i++)
    {
        //获取字符串的每个字符
        NSRange range = {i,1};
        //比较是否是空格
        if(![[str substringWithRange:range] isEqualToString:@" "])
        {
            //如果不是空格，取出这个字符串后面字符
            NSRange r = {i,str.length-i};
            //取出没有字符串的内容
            [str substringWithRange:r];
            break;
        }
    }
    
    //根据子标题字体的大小和内容的多少，获取子标题的大小
    CGSize sizeToCon = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(288, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    
    //得到子标题的Frame
    self.newsDetailView.subTitle.frame = CGRectMake(self.newsDetailView.subTitle.frame.origin.x, self.newsDetailView.subTitle.frame.origin.y, sizeToCon.width, sizeToCon.height);
    CGRect rect = self.newsDetailView.subTitle.frame;
    rect.size = sizeToCon;
    //设置子标题的FRMAE
    [self.newsDetailView.subTitle setFrame:rect];
    //设置子标题的内容
    [self.newsDetailView.subTitle setText:str];
    
    //根据子标题的大小，改变Image的Frame
    self.newsDetailView.imageView.frame = CGRectMake(self.newsDetailView.imageView.frame.origin.x, rect.origin.y+21+rect.size.height, 250, 174);
    
    
    //获取新闻主内容的信息
    //根据\r\n截取数组
    NSArray * conArr = [context componentsSeparatedByString:@"\r\n"];
    //定义一个可变字符串
    NSMutableString * text = [[NSMutableString alloc] init];
    for(int i=0;i<conArr.count;i++)
    {
        //取出数组的内容，拼接字符串
        [text appendString:[conArr objectAtIndex:i]];
    }
    for(int i=0;i<text.length;i++)
    {
        NSRange range = {i,1};
        //比较是否是空格
        if(![[text substringWithRange:range] isEqualToString:@" "])
        {
            NSRange r = {i,text.length-i};
            [text substringWithRange:r];
            break;
        }
    }
    
    //根据新闻内容字体的大小和内容的多少，获取子标题的大小
    CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(288, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    //设置新闻内容的Frame
    self.newsDetailView.content.frame = CGRectMake(self.newsDetailView.content.frame.origin.x, self.newsDetailView.content.frame.origin.y, sizeToFit.width, sizeToFit.height);
    
    CGRect content = CGRectMake(11, self.newsDetailView.imageView.frame.origin.y+174+27, sizeToFit.width, sizeToFit.height);
    
    content.size = sizeToFit;
    [self.newsDetailView.content setFrame:content];
    [self.newsDetailView.content setText:text];
    
    
    
    [self.newsDetailView.moreLable setFrame:CGRectMake(11, sizeToFit.height+self.newsDetailView.content.frame.origin.y+27, 288, self.newsDetailView.moreLable.frame.size.height)];
    
    
    
    [self.newsDetailView.webSite setFrame:CGRectMake(11, self.newsDetailView.moreLable.frame.size.height+self.newsDetailView.moreLable.frame.origin.y+12, self.newsDetailView.webSite.frame.size.width, self.newsDetailView.webSite.frame.size.height)];
    
    CGRect sizeOfcon = CGRectMake(self.newsDetailView.contentView.frame.origin.x, self.newsDetailView.contentView.frame.origin.y, self.newsDetailView.contentView.frame.size.width, self.newsDetailView.webSite.frame.size.height+15+self.newsDetailView.webSite.frame.origin.y);
    
    [self.newsDetailView.contentView setFrame:sizeOfcon];
    
    
    [self.newsDetailView.commentView setFrame:CGRectMake(self.newsDetailView.contentView.frame.origin.x,self.newsDetailView.contentView.frame.size.height+self.newsDetailView.contentView.frame.origin.y+5,self.newsDetailView.commentView.frame.size.width,411)];
    
    self.newsDetailView.scrollView.contentSize = CGSizeMake(self.newsDetailView.scrollView.frame.size.width, self.newsDetailView.contentView.frame.size.height+self.newsDetailView.commentView.frame.size.height+10);
    
    //内存管理
    [timeStr release];
    [str release];
    [text release];
}


- (void)popToLastControl
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
