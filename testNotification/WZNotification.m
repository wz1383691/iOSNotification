//
//  WZNotification.m
//  testNotification
//
//  Created by james on 2017/4/26.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import "WZNotification.h"

@implementation WZNotification

-(instancetype)initWithName:(NSString *)name  object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo{
    if(self = [super init]){
        _name=name;
        _object=object;
        _userInfo=userInfo;
    }
    return self;
}

+(instancetype)notificationWithName:(NSString*)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo{
    return [[self alloc]initWithName:aName object:anObject userInfo:aUserInfo];
}

@end
