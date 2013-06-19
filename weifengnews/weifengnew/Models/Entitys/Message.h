//
//  Message.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * date;
@property (copy, nonatomic) NSString * browseTiger;
@property (copy, nonatomic) NSString * typeName;
@property (copy, nonatomic) NSString * discussTime;
@property (copy, nonatomic) NSString * urlString;
@property (copy, nonatomic) NSString * image;
@property (copy, nonatomic) NSString * mess;

- (id)initWithTitle:(NSString *)title
               date:(NSString *)date
        browseTiger:(NSString *)browseTiger
               type:(NSString *)type
        discussTime:(NSString *)discussTime
          urlString:(NSString *)urlString
              image:(NSString *)image
               mess:(NSString *)mess;

@end
