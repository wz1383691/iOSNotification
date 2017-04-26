//
//  WZNotificationCenter.h
//  testNotification
//
//  Created by james on 2017/4/26.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WZNotification;

@interface WZNotificationCenter : NSObject

@property (nonatomic,copy)NSMutableArray *observers;
//获取通知中心
+(instancetype)defaultWZCenter;

-(void)postNotification:(WZNotification*)notification;
-(void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(nullable id)anObject;


//移除观察者
- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;
@end
