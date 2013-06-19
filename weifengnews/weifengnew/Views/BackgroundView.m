//
//  BackgroundView.m
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "BackgroundView.h"
#define TABLE_COLOR  [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
        bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_top_title_bg.png"]];
        [self addSubview:bgView];
        
        //self.alpha = 0.7;
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(28, 6, 260, 12)];
        self.titleLab = lab;
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTextColor:TABLE_COLOR];
        [bgView addSubview:lab];
        [lab release];
        [bgView release];
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
