//
//  ImageScrollView.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-28.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView * first = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 156*VIEW_FRAME_HEIGHT)];
        self.firstImage = first;
        [self addSubview:first];
        [first release];
        
        UIImageView * second = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320*VIEW_FRAME_WIDTH, 156*VIEW_FRAME_WIDTH)];
        self.secondImage = second;
        [self addSubview:second];
        [second release];
        
        UIImageView * three = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320*VIEW_FRAME_WIDTH, 156*VIEW_FRAME_HEIGHT)];
        self.threeImage = three;
        [self addSubview:three];
        [three release];
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
