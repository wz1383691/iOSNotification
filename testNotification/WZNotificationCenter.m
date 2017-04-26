//
//  WZNotificationCenter.m
//  testNotification
//
//  Created by james on 2017/4/26.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import "WZNotificationCenter.h"
#import "WZNotification.h"
#import "WZObserverModel.h"

//消除方法警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
 } while (0)

@implementation WZNotificationCenter

//保证单例
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Cannot be involked" reason:@"Singleton" userInfo:nil];
}

+(instancetype)defaultWZCenter{
    static WZNotificationCenter *singlCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singlCenter = [[super alloc]initSingleton];
        
    });
    return  singlCenter;
}

-(instancetype)initSingleton{
    if([super init]){
        _observers = [NSMutableArray array];
    }
    return self;
}

//注册为广播听众  object 监听哪个对象
-(void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(nullable id)anObject
{
        WZObserverModel *observerModel=[[WZObserverModel alloc]init];
        observerModel.observer=observer;
        observerModel.selector=aSelector;
        observerModel.notificationName = aName;
        observerModel.object = anObject;
        [self.observers addObject:observerModel];
}

//给听众发送通知
-(void)postNotification:(WZNotification*)notification{
     [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         WZObserverModel *observerModel = obj;
         id observer = observerModel.observer;
         SEL selector = observerModel.selector;
         //按照注册的广播名称过滤,不指定名称的观察者 接受所有广播
         
         if(observerModel.object !=nil &&observerModel.notificationName !=nil ){//指定了object和name的必须符合才会接收到通知
             if(observerModel.object == notification.object &&observerModel.notificationName == notification.name ){
                 SuppressPerformSelectorLeakWarning([observer performSelector:selector withObject:notification]);
             }
        }else if(observerModel.object !=nil && observerModel.notificationName ==nil ){//只指定object没有指定name的则接受所有这个object的通知
            if(observerModel.object == notification.object ){
                SuppressPerformSelectorLeakWarning([observer performSelector:selector withObject:notification]);
            }
        }else if(observerModel.object ==nil && observerModel.notificationName !=nil){//只指定名字的没有指定object的则接受所有名称匹配的通知
            if(observerModel.notificationName == notification.name ){
                SuppressPerformSelectorLeakWarning([observer performSelector:selector withObject:notification]);
            }
        }else{//name和object都没指定接受全部通知
                SuppressPerformSelectorLeakWarning([observer performSelector:selector withObject:notification]);
        }
     }];
}

- (void)removeObserver:(id)observer
{
    [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WZObserverModel *observerModel = obj;
        if (observerModel.observer == observer ) {
            [self.observers removeObject:observerModel];
            *stop = YES;
        }
    }];
}

- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WZObserverModel *observerModel = obj;
        if (observerModel.observer == observer && [observerModel.notificationName isEqualToString:aName] && observerModel.object == anObject) {
            [self.observers removeObject:observerModel];
            *stop = YES;
        }
    }];
}
@end
