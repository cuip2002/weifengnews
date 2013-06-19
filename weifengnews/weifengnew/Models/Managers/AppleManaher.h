//
//  AppleManaher.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"
#import "AppleManagerdelegate.h"

@interface AppleManaher : NSObject<SeviceDelegate>

@property (assign, nonatomic) id<AppleManagerdelegate>delegate;
@property (copy, nonatomic) NSString * typeName;

-(void)loadApple:(int)pageIndex;

@end
