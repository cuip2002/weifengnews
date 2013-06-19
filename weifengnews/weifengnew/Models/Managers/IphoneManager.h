//
//  IphoneManager.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"
#import "IphoneManagerDelegate.h"

@interface IphoneManager : NSObject<SeviceDelegate>

@property (copy, nonatomic) NSString * typeName;
@property (assign, nonatomic) id<IphoneManagerDelegate>delegate;

- (void)loadiPhone:(int)pageIndex;

@end
