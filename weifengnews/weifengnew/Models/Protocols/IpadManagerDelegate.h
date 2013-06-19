//
//  IpadManagerDelegate.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IpadManagerDelegate <NSObject>

- (void)getIpadMessageArray:(NSArray *)iPadArr;//返回Ipad的新闻信息

@end
