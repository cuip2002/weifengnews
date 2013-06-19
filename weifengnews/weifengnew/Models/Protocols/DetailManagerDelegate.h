//
//  DetailManagerDelegate.h
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DetailManagerDelegate <NSObject>

- (void)getContext:(NSString *)context comeString:(NSString *)comeString title:(NSString *)title;

@end
