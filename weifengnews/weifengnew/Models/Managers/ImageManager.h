//
//  ImageManager.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeviceDelegate.h"
#import "ImageManagerDelegate.h"

@interface ImageManager : NSObject<SeviceDelegate>

@property (assign, nonatomic) id<ImageManagerDelegate>delegate;

- (void)loadImage:(NSString *)string;

@end
