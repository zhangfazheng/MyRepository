//
//  CoreJPush.m
//  CoreJPush
//
//  Created by 冯成林 on 15/9/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreJPush.h"
#import <JPUSHService.h>
#import <UIKit/UIKit.h>
#import <NotificationCenter/NotificationCenter.h>
#import <UserNotifications/UserNotifications.h>
#import <Foundation/Foundation.h>


#define JPushAppKey @"6a15b4582c16a64d02a69bac"
#define JPushChannel @"AppStore"
#define JPushIsProduction NO

@interface CoreJPush ()<JPUSHRegisterDelegate> 

@property (nonatomic,strong) NSMutableArray *listenerM;

@property (nonatomic,copy) void(^ResBlock)(BOOL res, NSSet *tags,NSString *alias);

@end



@implementation CoreJPush
HMSingletonM(CoreJPush)


/** 注册JPush */
+ (void)registerJPush:(NSDictionary *)launchOptions andListener:(id<JPUSHRegisterDelegate>)listener{
    
    // 注册apns通知
    if (IOS_10) // iOS10
    {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
        //如果监听者不为空
        if (listener) {
            [JPUSHService registerForRemoteNotificationConfig:entity delegate:listener];
        }else{
            [JPUSHService registerForRemoteNotificationConfig:entity delegate:[CoreJPush sharedCoreJPush]];
        }
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) // iOS8, iOS9
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }
    else // iOS7
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey channel:JPushChannel apsForProduction:JPushIsProduction];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0)
        {
            // iOS10获取registrationID放到这里了, 可以存到缓存里, 用来标识用户单独发送推送
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

    
    
    
}


/** 注册JPush */
+ (void)registerJPush:(NSDictionary *)launchOptions{
    
    [CoreJPush registerJPush:launchOptions andListener:nil];
    
}



/** 添加监听者 */
+(void)addJPushListener:(id<CoreJPushProtocol>)listener{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    if([jpush.listenerM containsObject:listener]) return;
    
    [jpush.listenerM addObject:listener];
}

/** 创建一个通知监听管理者 */
+ (instancetype)sharedJPushWithListener:(id<CoreJPushProtocol,JPUSHRegisterDelegate>)listener{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    if(![jpush.listenerM containsObject:listener])
    [jpush.listenerM addObject:listener];
    
    return jpush;
}


/** 移除监听者 */
+(void)removeJPushListener:(id<CoreJPushProtocol>)listener{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    if(![jpush.listenerM containsObject:listener]) return;
    
    [jpush.listenerM removeObject:listener];
}


-(NSMutableArray *)listenerM{
    
    if(_listenerM==nil){
        _listenerM = [NSMutableArray array];
    }
    
    return _listenerM;
}


-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [self handleBadge:[userInfo[@"aps"][@"badge"] integerValue]];
    
    if(self.listenerM.count==0) return;
    
    [self.listenerM enumerateObjectsUsingBlock:^(id<CoreJPushProtocol> listener, NSUInteger idx, BOOL *stop) {
        
        if([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) [listener didReceiveRemoteNotification:userInfo];
    }];
}



/** 处理badge */
-(void)handleBadge:(NSInteger)badge{
    
    NSInteger now = badge-1;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [UIApplication sharedApplication].applicationIconBadgeNumber=now;
    [JPUSHService setBadge:now];
}



+(void)setTags:(NSSet *)tags alias:(NSString *)alias resBlock:(void(^)(BOOL res, NSSet *tags,NSString *alias))resBlock{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];

    [JPUSHService setTags:tags alias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:jpush];
    
    jpush.ResBlock=resBlock;
}


-(void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias{

    if(self.ResBlock != nil) self.ResBlock(iResCode==0,tags,alias);
}

#pragma mark-ios10注册代理方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;

    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        //NSString *message = [NSString stringWithFormat:@"will%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        //NSLog(@"iOS10程序在前台时收到的推送: %@", message);
        
        if(self.listenerM.count==0) return;
        
        [self.listenerM enumerateObjectsUsingBlock:^(id<CoreJPushProtocol> listener, NSUInteger idx, BOOL *stop) {
            
            if([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) [listener didReceiveRemoteNotification:userInfo];
        }];

        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
//        }];
//        
//        [alert addAction:action];
//        
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
//            
//        }];
    }
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        NSLog(@"iOS10程序关闭后通过点击推送进入程序弹出的通知: %@", message);
        
        if(self.listenerM.count==0) return;
        
        [self.listenerM enumerateObjectsUsingBlock:^(id<CoreJPushProtocol> listener, NSUInteger idx, BOOL *stop) {
            
            if([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) [listener didReceiveRemoteNotification:userInfo];
        }];

//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
//        }];
//        
//        [alert addAction:action];
//        
//        
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
//            
//        }];

    }
    
    completionHandler();  // 系统要求执行这个方法
}

@end
