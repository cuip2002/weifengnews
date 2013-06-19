//
//  MessageViewDelegate.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageViewDelegate <NSObject>

- (void)getNewsArray:(NSArray *)allMessage;

@end
