//
//  IphoneManager.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "IphoneManager.h"
#import "TFHpple.h"
#import "Message.h"
#import "Sevice.h"

@implementation IphoneManager
//根据传进来的页数，请求iphone的数据信息
- (void)loadiPhone:(int)pageIndex
{
    self.typeName = @"iPhone";
    Sevice * sevicer = [[Sevice alloc] init];
    sevicer.delegate = self;
    NSString * urlString = [NSString stringWithFormat:@"http://www.weiphone.com/iPhone/news/index_%d.shtml",pageIndex];
    [sevicer loadDataWith:urlString];
    [sevicer release];
}
//解析请求的结果
- (void)getResolvingData:(NSMutableData *)webData
{
    TFHpple * htmlHpple = [TFHpple hppleWithHTMLData:webData];
    //在html结果中，获取//div [@class='item']节点下的数组
    NSArray * webArray = [htmlHpple searchWithXPathQuery:@"//div [@class='item']"];
    //初始化一个数组
    NSMutableArray * entityArr = [[NSMutableArray alloc] init];
    //循环数组webArray
    for(int i=0;i<webArray.count;i++)
    {
        //定义一个实体
        Message * message = [[Message alloc] init];
        //取数组webArray的子节点
        TFHppleElement * elementFirst = [webArray objectAtIndex:i];
        NSArray * firstArr = [elementFirst children];
        for(int j=0;j<firstArr.count;j++)
        {
            TFHppleElement * elementSecond = [firstArr objectAtIndex:j];
            NSArray * secondArr = [elementSecond children];
            for(int n=0;n<secondArr.count;n++)
            {
                TFHppleElement * elementThree = [secondArr objectAtIndex:n];
                
                NSDictionary * threeDic = [elementThree attributes];
                for(NSString * htmlURL in threeDic.allKeys)
                {
                    if([htmlURL isEqualToString:@"href"])
                    {
                        message.urlString = [NSString stringWithFormat:@"%@",[threeDic objectForKey:htmlURL]];
                        //                        NSLog(me.urlString,nil);
                    }
                }
                
                NSString * strThree = [elementThree text];
                if([elementThree.tagName isEqualToString:@"p"])
                {
                    message.mess = strThree;
                    //                    NSLog(me.mess,nil);
                }
                
                NSArray * threeArr = [elementThree children];
                for(int m=0;m<threeArr.count;m++)
                {
                    TFHppleElement * elementForth = [threeArr objectAtIndex:m];
                    NSArray * forthArr = [elementForth children];
                    NSString * strForth = [elementForth text];
                    if(strForth&&![strForth isEqualToString:@"|"])
                    {
                        if([elementThree.tagName isEqualToString:@"h3"])
                        {
                            message.title = strForth;
                            //                           NSLog(me.title,nil);
                        }
                        if([elementForth.tagName isEqualToString:@"span"])
                        {
                            message.date = strForth;
                            //                         NSLog(me.date,nil);
                        }
                    }
                    NSDictionary * forthDic = [elementForth attributes];
                    for(NSString * title in forthDic.allKeys)
                    {
                        if([title isEqualToString:@"src"])
                        {
                            message.image = [NSString stringWithFormat:@"%@",[forthDic objectForKey:title]];
                            //                           NSLog(me.image,nil);
                        }
                    }
                    for(int x=0;x<forthArr.count;x++)
                    {
                        TFHppleElement * elementFive = [forthArr objectAtIndex:x];
                        NSString * strFive = [elementFive text];
                        if([elementFive.tagName isEqualToString:@"span"]&&![strFive isEqualToString:@"|"])
                        {
                            message.browseTiger = strFive;
                            //                            NSLog(me.browseTiger,nil);
                        }
                        if([elementFive.tagName isEqualToString:@"a"])
                        {
                            message.discussTime = strFive;
                            //                            NSLog(me.discussTime,nil);
                        }
                    }
                }
            }
        }
        message.typeName = self.typeName;
        [entityArr addObject:message];
        [message release];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(getIphoneMessage:)])
    {
        [self.delegate getIphoneMessage:entityArr];
    }
    [entityArr release];
}

@end
