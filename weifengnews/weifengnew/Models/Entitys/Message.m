//
//  Message.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id) initWithTitle:(NSString *)title
                date:(NSString *)date
         browseTiger:(NSString *)browseTiger
                type:(NSString *)type
         discussTime:(NSString *)discussTime
           urlString:(NSString *)urlString
               image:(NSString *)image
                mess:(NSString *)mess
{
    self = [super init];
    if(self)
    {
        self.title = title;
        self.date = date;
        self.browseTiger = browseTiger;
        self.typeName = type;
        self.discussTime = discussTime;
        self.urlString = urlString;
        self.image = image;
        self.mess = mess;
    }
    return self;
}

- (void)dealloc
{
    _title = nil;
    _date = nil;
    _typeName = nil;
    _browseTiger = nil;
    _discussTime = nil;
    _urlString = nil;
    _image = nil;
    _mess = nil;
    [super dealloc];
}
@end
