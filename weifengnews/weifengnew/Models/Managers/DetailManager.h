//
//  DetailManager.h
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"
#import "DetailManagerDelegate.h"

@interface DetailManager : NSObject<SeviceDelegate>

@property (assign, nonatomic) id<DetailManagerDelegate>delegate;
@property (copy, nonatomic) NSString * string;//子标题
@property (retain, nonatomic) NSMutableString * contextString;
- (void)loadDetailMessage:(NSString *)urlString;

@end
