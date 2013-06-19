//
//  IpadManager.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IpadManagerDelegate.h"
#import "SeviceDelegate.h"

@interface IpadManager : NSObject<SeviceDelegate>

@property (assign, nonatomic) id<IpadManagerDelegate>delegate;
@property (copy, nonatomic) NSString * typeName;

- (void)loadiPad:(int)pageIndex;

@end
