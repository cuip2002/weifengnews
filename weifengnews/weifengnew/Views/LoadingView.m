//
//  LoadingView.m
//  BookTicketProject
//
//  Created by ibokan on 13-4-11.
//  Copyright (c) 2013年 h. All rights reserved.
//

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>
#define LoadingWeith 150
#define LoadingWeith 150

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //加载的背景 View 设置为有阴影加点透明的效果
        UIView * backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LoadingWeith, LoadingWeith)];
        backV.backgroundColor = [UIColor grayColor];
        backV.layer.shadowOffset = CGSizeMake(0, 0);
        backV.layer.shadowColor = [UIColor blackColor].CGColor;
        backV.layer.shadowOpacity = 0.8;
        backV.layer.cornerRadius = 20;
        backV.alpha = 0.3;
        [self addSubview:backV];
        //转动的活动指示器 
        UIActivityIndicatorView * indicatiorV = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatiorV.frame = CGRectMake(0, 0, 60, 60);
        indicatiorV.center = CGPointMake(LoadingWeith/2, LoadingWeith/2-20);
        [indicatiorV startAnimating];
        [self addSubview:indicatiorV];
        //标签的文字加载说明
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LoadingWeith, LoadingWeith/3)];
        lab.center = CGPointMake(LoadingWeith/2, LoadingWeith/3*2);
        lab.text = @"奋力加载...";
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        [lab release];
        [indicatiorV release];
        [backV release];
    }
    return self;
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
