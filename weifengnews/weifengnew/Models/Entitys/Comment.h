//
//  Comment.h
//  WeiPhoneNews
//
//  Created by ibokan on 13-5-2.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (copy,nonatomic)NSString *comment_id;//评论id

@property (copy,nonatomic)NSString *user_name;//评论用户名

@property (copy,nonatomic)NSString *email;

@property (copy,nonatomic)NSString *homepage;

@property (copy,nonatomic)NSString *title;

@property (copy,nonatomic)NSString *content;

@property (copy,nonatomic)NSString *add_time;

@property (copy,nonatomic)NSString *status;

@property (copy,nonatomic)NSString *parent_id;

@property (copy,nonatomic)NSString *depth;

@property (copy,nonatomic)NSString *children_ids;

@property (copy,nonatomic)NSString *children_list;

@property (copy,nonatomic)NSString *score_1;

@property (copy,nonatomic)NSString *score_2;

@property (copy,nonatomic)NSString *rank;

@property (assign,nonatomic)CGFloat heigth;

@end
