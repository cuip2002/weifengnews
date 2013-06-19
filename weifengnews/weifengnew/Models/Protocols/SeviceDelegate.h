//
//  SeviceDelegate.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SeviceDelegate <NSObject>

- (void)getResolvingData:(NSMutableData *)webData;

@end
