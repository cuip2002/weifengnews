//
//  Sevice.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"

@interface Sevice : NSObject<NSURLConnectionDataDelegate>

@property (retain, nonatomic) NSMutableData * webData;
@property (assign, nonatomic) id<SeviceDelegate>delegate;

- (void) loadDataWith:(NSString *)string;

@end
