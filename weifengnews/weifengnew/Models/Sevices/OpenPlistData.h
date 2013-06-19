//
//  OpenPlistData.h
//  WeiPhoneProject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 h. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenPlistData : NSObject

+(NSMutableSet *)readFromFile;
+(void)saveToFile:(NSMutableSet *)dic;

@end
