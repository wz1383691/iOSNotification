//
//  WZObserverModel.h
//  testNotification
//
//  Created by james on 2017/4/26.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZObserverModel : NSObject

@property (nonatomic,weak) id observer;
@property (nonatomic,assign) SEL selector;
@property (nonatomic,copy) NSString *notificationName;
@property (nonatomic,strong) id object;

@end
