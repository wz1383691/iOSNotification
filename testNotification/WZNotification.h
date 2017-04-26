//
//  WZNotification.h
//  testNotification
//
//  Created by james on 2017/4/26.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZNotification : NSObject

@property (nullable, readonly ,copy)NSString *name;
@property (nullable,readonly,retain)id object;
@property (nullable,readonly,copy)NSDictionary *userInfo;

+(instancetype)notificationWithName:(NSString*)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;
@end
