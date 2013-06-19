//
//  ImageManager.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ImageManager.h"
#import "Sevice.h"

@implementation ImageManager

- (void)loadImage:(NSString *)string
{
    Sevice * seciver = [[Sevice alloc] init];
    seciver.delegate = self;
    NSLog(@"imgStr=%@",string);
    [seciver loadDataWith:string];
}

- (void)getResolvingData:(NSMutableData *)webData
{
    UIImage * image = [UIImage imageWithData:webData];
    if(self.delegate && [self.delegate respondsToSelector:@selector(postImage:)])
    {
        [self.delegate postImage:image];
    }
}

@end
