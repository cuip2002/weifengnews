//
//  IpadManager.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "IpadManager.h"
#import "Sevice.h"
#import "Message.h"
#import "TFHpple.h"

@implementation IpadManager

- (void)loadiPad:(int)pageIndex
{
    self.typeName = @"iPad";
    Sevice * sevicer = [[Sevice alloc] init];
    sevicer.delegate = self;
    NSString * urlString = [NSString stringWithFormat:@"http://www.weiphone.com/iPad/news/index_%d.shtml",pageIndex];
    [sevicer loadDataWith:urlString];
    [sevicer release];
}

- (void)getResolvingData:(NSMutableData *)webData
{
    TFHpple * htmlHpple = [TFHpple hppleWithHTMLData:webData];
    NSArray * webArray = [htmlHpple searchWithXPathQuery:@"//div [@class='item']"];
    NSMutableArray * entityArr = [[NSMutableArray alloc] init];
    for(int i=0;i<webArray.count;i++)
    {
        Message * me = [[Message alloc] init];
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
                        me.urlString = [NSString stringWithFormat:@"%@",[threeDic objectForKey:htmlURL]];
                        //                        NSLog(me.urlString,nil);
                    }
                }
                
                NSString * strThree = [elementThree text];
                if([elementThree.tagName isEqualToString:@"p"])
                {
                    me.mess = strThree;
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
                            me.title = strForth;
                            //                           NSLog(me.title,nil);
                        }
                        if([elementForth.tagName isEqualToString:@"span"])
                        {
                            me.date = strForth;
                            //                         NSLog(me.date,nil);
                        }
                    }
                    NSDictionary * forthDic = [elementForth attributes];
                    for(NSString * title in forthDic.allKeys)
                    {
                        if([title isEqualToString:@"src"])
                        {
                            me.image = [NSString stringWithFormat:@"%@",[forthDic objectForKey:title]];
                            //                           NSLog(me.image,nil);
                        }
                    }
                    for(int x=0;x<forthArr.count;x++)
                    {
                        TFHppleElement * elementFive = [forthArr objectAtIndex:x];
                        NSString * strFive = [elementFive text];
                        if([elementFive.tagName isEqualToString:@"span"]&&![strFive isEqualToString:@"|"])
                        {
                            me.browseTiger = strFive;
                            //                            NSLog(me.browseTiger,nil);
                        }
                        if([elementFive.tagName isEqualToString:@"a"])
                        {
                            me.discussTime = strFive;
                            //                            NSLog(me.discussTime,nil);
                        }
                    }
                }
            }
        }
        me.typeName = self.typeName;
        [entityArr addObject:me];
        [me release];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(getIpadMessageArray:)])
    {
        [self.delegate getIpadMessageArray:entityArr];
    }
    [entityArr release];
}
@end
