//
//  DiscussManager.h
//  WeiFengPriject
//
//  Created by ibokan on 13-5-2.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"
#import "DiscussManagerDelegate.h"

@interface DiscussManager : NSObject<SeviceDelegate>

@property (assign, nonatomic) id<DiscussManagerDelegate>delegate;

- (void)loadDiscuss:(NSString *)bodyString;

@end
