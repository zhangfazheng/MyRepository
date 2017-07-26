//
//  CoreJPush.h
//  CoreJPush
//
//  Created by 冯成林 on 15/9/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate+JPush.h"
#import "CoreJPushSingleton.h"
#import "CoreJPushProtocol.h"
#import <JPUSHService.h>
@interface CoreJPush : NSObject<CoreJPushProtocol>
HMSingletonH(CoreJPush)

/** 创建一个通知ios10时有用，创建一个新的监听管理者 */
+ (instancetype)sharedJPushWithListener:(id<JPUSHRegisterDelegate>)listener;

/** 注册JPush */
+ (void)registerJPush:(NSDictionary *)launchOptions;

/** 注册JPush，并添加监听者 */
+ (void)registerJPush:(NSDictionary *)launchOptions andListener:(id<CoreJPushProtocol,JPUSHRegisterDelegate>)listener;

/** 添加监听者 */
+(void)addJPushListener:(id<CoreJPushProtocol>)listener;

/** 移除监听者 */
+(void)removeJPushListener:(id<CoreJPushProtocol>)listener;


/** 注册alias、tags */
+(void)setTags:(NSSet *)tags alias:(NSString *)alias resBlock:(void(^)(BOOL res, NSSet *tags,NSString *alias))resBlock;


@end
