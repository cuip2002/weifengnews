//
//  WebManager.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "WebManager.h"
#import "Sevice.h"

@implementation WebManager

- (void)loadWeb:(NSString *)urlString
{
    Sevice * seciver = [[Sevice alloc] init];
    seciver.delegate = self;
    [seciver loadDataWith:urlString];
}

- (void)getResolvingData:(NSMutableData *)webData
{
    
}

@end
