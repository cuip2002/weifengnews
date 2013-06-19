
//  Sevice.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "Sevice.h"

@implementation Sevice
//根据传进来的网址，请求数据
- (void) loadDataWith:(NSString *)string
{
    NSURL * url = [NSURL URLWithString:string];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
//开始请求数据
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.webData = [[[NSMutableData alloc] init]autorelease];
}
//获取请求的Data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.webData appendData:data];
}
//请求出错的时候
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.webData = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
//请求的结果
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(getResolvingData:)])
    {
        [self.delegate getResolvingData:self.webData];
    }
}
- (void)dealloc
{
    [_webData release];
    _webData = nil;
    [super dealloc];
}


@end
