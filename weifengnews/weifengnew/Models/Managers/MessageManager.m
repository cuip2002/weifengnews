//
//  MessageManager.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "MessageManager.h"
#import "Message.h"
#import "Sevice.h"

@implementation MessageManager

- (void)loadNews:(int)page
{
    NSMutableArray * entityArr = [[NSMutableArray alloc] init];
    self.listArr = entityArr;
    [entityArr release];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //请求iphone 的数据
    IphoneManager * iphone = [[IphoneManager alloc] init];
    iphone.delegate = self;
    [iphone loadiPhone:page];
    
    //请求Ipad 的数据
    IpadManager * ipad = [[IpadManager alloc] init];
    ipad.delegate = self;
    [ipad loadiPad:page];
    
    //请求apple 的数据
    AppleManaher * apple = [[AppleManaher alloc] init];
    apple.delegate = self;
    [apple loadApple:page];
    
}
//获取iphone请求结果的值
- (void)getIphoneMessage:(NSArray *)iPhoneArray
{
    //获取iphone 的值存入listArr的数组
    [self.listArr addObjectsFromArray:iPhoneArray];
    if(self.listArr.count %75 == 0)
    {
        [self listTime:self.listArr];
    }
//    NSLog(@"%d",self.listArr.count);
}
//获取ipad请求结果的值
- (void)getIpadMessageArray:(NSArray *)iPadArr
{
    //获取ipad 的值存入listArr的数组
    [self.listArr addObjectsFromArray:iPadArr];
    if(self.listArr.count %75 == 0)
    {
        [self listTime:self.listArr];
    }
//    NSLog(@"%d",self.listArr.count);
}
- (void)getAppleMessageArray:(NSArray *)appleArr
{
    //获取Apple 的值存入listArr的数组
    [self.listArr addObjectsFromArray:appleArr];
    if(self.listArr.count %75 == 0)
    {
        [self listTime:self.listArr];
    }
//    NSLog(@"%d",self.listArr.count);
}
//如果数组listArr的个数为75 时，根据时间排序数组
- (void)listTime:(NSMutableArray *)array
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //获取每条信息的时间
    NSSortDescriptor * sort = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:1];
    //根据时间对数组排序
    NSArray * tempArr = [self.listArr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    //清空数组
    [self.listArr removeAllObjects];
    //按排好的顺序，进行反序排列
    for(int i=74;i>=0;i--)
    {
        [self.listArr addObject:[tempArr objectAtIndex:i]];
    }
    //调用代理，传出数组ListArr
    if(self.delegate && [self.delegate respondsToSelector:@selector(getNewsArray:)])
    {
        [self.delegate getNewsArray:self.listArr];
    }
    //内存管理
    [sort release];
}

@end
