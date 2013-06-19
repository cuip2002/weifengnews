//
//  WebManager.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"

@interface WebManager : NSObject<SeviceDelegate>

- (void)loadWeb:(NSString *)urlString;

@end
