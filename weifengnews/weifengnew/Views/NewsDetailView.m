//
//  NewsDetailView.m
//  WeiFeng
//
//  Created by ibokan on 13-4-28.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "NewsDetailView.h"
#import <QuartzCore/QuartzCore.h>
#define TITLE_FONT 17//主题字体大小
#define VICETITLE_FONT 12//副标题字体大小
#define BODYTITLE_FONT 13//正文字体大小
#define VIEW_COLOR   [UIColor colorWithRed:209.0/255.0 green:215.0/255.0 blue:223.0/255.0 alpha:1.0]

@implementation NewsDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //实例化uiscrollView
        self.scrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 411*VIEW_FRAME_HEIGHT)] autorelease];
        //设置滚动视图的背景色
        self.scrollView.backgroundColor = [UIColor colorWithRed:220.0/255.0f green:220.0/255.0f blue:220.0/255.0f alpha:1.0];
        self.scrollView.contentSize = CGSizeMake(320, 545+416);
        //        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        //滑动页面的分页设置
        //        self.scrollView.contentSize = CGSizeMake(320, 1500);
        
        //实例化内容页面框架
        self.contentView = [[[UIView alloc]initWithFrame:CGRectMake(5, 5, 310, 545)] autorelease];
        [self.scrollView addSubview:self.contentView];
        //内容页面的边角幅度
        self.contentView.layer.cornerRadius = 10.0;
        //背景颜色
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        //实例化评论视图
        self.commentView = [[[UIView alloc] initWithFrame:CGRectMake(5, 555, 310, 405)] autorelease];
        [self.scrollView addSubview:self.commentView];
        self.commentView.layer.cornerRadius = 10.0;
        [self.commentView setBackgroundColor:[UIColor whiteColor]];
        
        //主标题
        UILabel * theme = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 280, 39)];
        //
        self.theme = theme;
        //标题的背景
        theme.backgroundColor = [UIColor clearColor];
        //标题文字的颜色
        [theme setTextColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
        //标题内容居中显示
        theme.textAlignment = 1;
        //设置换行
        theme.lineBreakMode = 0;
        //设置显示两行
        theme.numberOfLines = 2;
        [self.contentView addSubview:theme];
        [theme release];
        //来源
        UILabel * source = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 250, 18)];
        self.source = source;
        source.backgroundColor = [UIColor clearColor];
        [source setTextColor:[UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0]];
        source.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:source];
        [source release];
        
        //子标题
        UILabel * subTitle = [[UILabel alloc] initWithFrame:CGRectMake(11, 92, 288, 72)];
        self.subTitle = subTitle;
        subTitle.backgroundColor = [UIColor clearColor];
        subTitle.font = [UIFont systemFontOfSize:14];
        subTitle.lineBreakMode = NSLineBreakByCharWrapping;
        subTitle.numberOfLines = 0;
        subTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:subTitle];
        [subTitle release];
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 183, 250, 174)];
        self.imageView = image;
        image.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:image];
        [image release];
        
        //新闻的内容
        UILabel * content = [[UILabel alloc] initWithFrame:CGRectMake(11, 378, 288, 99)];
        self.content = content;
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:14];
        content.lineBreakMode = NSLineBreakByCharWrapping;
        content.numberOfLines = 0;
        [self.contentView addSubview:content];
        [content release];
        
        //更多内容
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(11, 495, 288, 18)];
        self.moreLable = lab;
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"更多精彩资讯，请访问";
        [self.contentView addSubview:lab];
        [lab release];
        
        //网址
        UIButton * URLString = [UIButton buttonWithType:UIButtonTypeCustom];
        URLString.frame = CGRectMake(11, 517, 220, 18);
        self.webSite = URLString;
        [URLString setTitle: @"http://news.tongbu.com/" forState:UIControlStateNormal];
        
        URLString.titleLabel.textAlignment = NSTextAlignmentLeft;
        URLString.titleLabel.textColor = [UIColor colorWithRed:1.0f/255.0f green:150.0f/255.0f blue:227.0f/255.0f alpha:1.0];
        [URLString addTarget:self action:@selector(openSafari:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:URLString];
        //实例化标题视图
        
    }
    return self;
}
-(void)openSafari:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sender.titleLabel.text]];
}
- (void)dealloc
{
    self.contentView = nil;
    [super dealloc];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end
