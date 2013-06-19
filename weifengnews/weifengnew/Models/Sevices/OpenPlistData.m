//
//  OpenPlistData.m
//  WeiPhoneProject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 h. All rights reserved.
//

#import "OpenPlistData.h"

@implementation OpenPlistData

//读出文件的 新闻字典信息

+(NSMutableSet *)readFromFile
{
    
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString * newsParh = [docPath stringByAppendingPathComponent:@"Property.plist"];
    
    NSString * originFilePath = [[NSBundle mainBundle]pathForResource:@"Property" ofType:@"plist"];
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if([fm fileExistsAtPath:newsParh] == 0)
    {
        NSError * err = nil;
        if([fm copyItemAtPath:originFilePath toPath:newsParh error:&err] == 0)
        {
            NSLog(@"file fial");
            return nil;
        }
    }
    NSArray * arr = [[NSArray alloc]initWithContentsOfFile:newsParh];
    //NSMutableSet * set = [[NSMutableSet alloc]initWithArray:arr];
    NSMutableSet * set = [NSMutableSet setWithArray:arr];
    [arr release];
    return set;
}

+(void)saveToFile:(NSMutableSet *)set
{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString * newsParh = [docPath stringByAppendingPathComponent:@"Property.plist"];
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if(![fm fileExistsAtPath:newsParh])
    {
        NSLog(@"creat file");
        [fm createDirectoryAtPath:newsParh withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSArray * arr = [set allObjects];
    [arr writeToFile:newsParh atomically:YES];
}

@end
