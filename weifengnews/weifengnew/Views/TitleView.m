//
//  TitleView.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-28.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "TitleView.h"
#define TEXT_COLOR         [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
#define TEXE_SHADOWCOLOR   [UIColor colorWithRed:25.0/255.0 green:87.0/255.0 blue:126.0/255.0 alpha:1.0]
@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 44*VIEW_FRAME_HEIGHT)];
        bgView.image = [UIImage imageNamed:@"nav_bg.png"];
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        
        UILabel * titleText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 44*VIEW_FRAME_HEIGHT)];
        titleText.backgroundColor = [UIColor clearColor];
        titleText.text = @"威锋新闻";
        titleText.font = [UIFont systemFontOfSize:19*VIEW_FRAME_HEIGHT];
        titleText.textAlignment = 1;
        [titleText setTextColor:TEXT_COLOR];
        [titleText setShadowColor:TEXE_SHADOWCOLOR];
        [titleText setShadowOffset:CGSizeMake(0, -1)];
        [bgView addSubview:titleText];
        
        [bgView release];
        [titleText release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    bgView.image = [UIImage imageNamed:@"nav_bg.png"];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    UILabel * titleText = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 120, 20)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.text = @"威锋新闻";
    titleText.font = [UIFont systemFontOfSize:19];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setTextColor:TEXT_COLOR];
    [titleText setShadowColor:TEXE_SHADOWCOLOR];
    [titleText setShadowOffset:CGSizeMake(0, -1)];
    [bgView addSubview:titleText];
    
}
*/
@end
