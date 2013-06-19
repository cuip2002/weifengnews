//
//  MessageManager.h
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageViewDelegate.h"
#import "TFHpple.h"
#import "IphoneManager.h"
#import "IpadManager.h"
#import "AppleManaher.h"

@interface MessageManager : NSObject<IphoneManagerDelegate,IpadManagerDelegate,AppleManagerdelegate>
{
    NSConditionLock * conditionLock;
}
@property (assign, nonatomic)id<MessageViewDelegate>delegate;
@property (copy, nonatomic) NSString * typeName;
@property (assign, nonatomic) int index;
@property (retain, nonatomic) NSMutableArray * listArr;

- (void) loadNews:(int)page;

@end
