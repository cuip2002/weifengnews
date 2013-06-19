//
//  DetailManager.m
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "DetailManager.h"
#import "Sevice.h"
#import "TFHpple.h"

@implementation DetailManager

- (void)loadDetailMessage:(NSString *)urlString
{
    Sevice * sevicer = [[Sevice alloc] init];
    sevicer.delegate = self;
    NSLog(@"urlStr=====%@",urlString);
    [sevicer loadDataWith:urlString];
}

- (void)getResolvingData:(NSMutableData *)webData
{
    self.contextString = [[[NSMutableString alloc] init] autorelease];
    
    TFHpple * htmlHpple = [TFHpple hppleWithHTMLData:webData];
    
    NSArray * elementfirst = [htmlHpple searchWithXPathQuery:@"//blockquote [@class='quot']"];
    TFHppleElement * elementOne = [elementfirst objectAtIndex:0];
    NSString * string = [elementOne text];
    NSLog(@"2111----%@",string);
    
    NSArray * contextArr = [htmlHpple searchWithXPathQuery:@"//span [@style='color:#333333;']"];
    NSLog(@"3111----%d++++",contextArr.count);
    if(contextArr.count!=0)
    {
        for(int i=0;i<contextArr.count;i++)
        {
            TFHppleElement * elementsecond = [contextArr objectAtIndex:i];
            NSArray * otherElement = [elementsecond children];
            TFHppleElement * teoElement = [otherElement objectAtIndex:0];
            NSString * teo = [teoElement content];
            self.string = teo;
            NSLog(@"4111----%@",teo);
            [self.contextString appendString:teo];
            NSLog(@"5111----%@",self.contextString);
        }
    }
    if(contextArr.count==0)
    {
        NSArray * conArray = [htmlHpple searchWithXPathQuery:@"//div [@class='content_text']"];
        NSLog(@"%d",conArray.count);
        NSLog(@"6611111--------%@",[[conArray objectAtIndex:0] description]);
        for(int i=0;i<conArray.count;i++)
        {
            TFHppleElement * elementsecond = [conArray objectAtIndex:i];
            NSArray * arrCenter = [elementsecond children];

           NSLog(@"6111----%d",arrCenter.count);
            for(int j=0;j<arrCenter.count;j++)
            {
                TFHppleElement * chilrElement = [arrCenter objectAtIndex:j];
                NSString * onArray = [chilrElement content];
                NSLog(@"651111------%@",onArray);
               NSLog(@"7111----%@",onArray);
                if(!(onArray==nil) && ![onArray isEqualToString:@""])
                {
                    [self.contextString appendString:onArray];
                    NSLog(@"8111----%@",onArray);
                }
            }

        }
    }
    NSArray * name = [htmlHpple searchWithXPathQuery:@"//div [@class='author']"];
    TFHppleElement * elementthree = [name objectAtIndex:0];
    NSArray * elementFor = [elementthree children];
    TFHppleElement * spanElement = [elementFor objectAtIndex:3];
    NSString * comeString = [spanElement text];
    NSLog(@"%@++++",comeString);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(getContext:comeString:title:)])
    {
        [self.delegate getContext:self.contextString comeString:comeString title:string];
    }
}

@end
