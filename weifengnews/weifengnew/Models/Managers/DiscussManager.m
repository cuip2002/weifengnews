//
//  DiscussManager.m
//  WeiFengPriject
//
//  Created by ibokan on 13-5-2.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "DiscussManager.h"
#import "Sevice.h"
#import "JSON.h"
#import "Comment.h"

@implementation DiscussManager

- (void)loadDiscuss:(NSString *)bodyString
{
    NSString * urlString = [NSString stringWithFormat:@"http://www.weiphone.com/publish/comment_v3.php?article_id=%@",bodyString];
    NSLog(@"评论地址:%@",urlString);
    //评论地址:http://www.weiphone.com/publish/comment_v3.php?article_id=556436
    Sevice * sevicer = [[Sevice alloc] init];
    sevicer.delegate = self;
    [sevicer loadDataWith:urlString];
}

- (void)getResolvingData:(NSMutableData *)webData
{
    NSString * dataStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog( @"json===%@",dataStr);
    
//    NSDictionary * oneDic = [dataStr JSONValue];
//    NSArray * oneArray = [oneDic objectForKey:@"list"];
//    for(NSDictionary * comment in oneArray)
//    {
//        NSLog(@"%@",comment.allKeys);
//        NSLog(@"%@",comment.allValues);
//    }
    
    //接收解析后的评论信息
    NSMutableArray * commentsLa = [[NSMutableArray alloc] init];
    
    NSDictionary * result = [dataStr JSONValue];
    
    NSArray * commentList = [result objectForKey:@"list"];
    
    for(NSDictionary * comment in commentList)
    {
        Comment * commentLa = [[Comment alloc] init];
        NSArray * keys = [comment allKeys];
        for(NSString * key in keys)
        {
            [commentLa setValue:[comment valueForKey:key] forKey:key];
            //NSLog(@"%@-------%@",key,[comment valueForKey:key]);
        }
        commentLa.heigth = commentLa.title.length / 17 * 19 + 92.5;
        [commentsLa addObject:commentLa];
        [commentLa release];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(getDiscussArr:)])
    {
        [self.delegate getDiscussArr:commentsLa];
    }
    [dataStr release];
    [commentsLa release];
}

@end
