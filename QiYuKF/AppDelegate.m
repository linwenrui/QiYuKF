//
//  AppDelegate.m
//  QiYuKF
//
//  Created by XH-LWR on 2017/9/20.
//  Copyright © 2017年 linwenrui. All rights reserved.
//

#import "AppDelegate.h"
#import "QYSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 自定义聊天组件UI效果
    [self customSessionUI];
    [[QYSDK sharedSDK] registerAppId:@"faf58ac0204f491676739f4de14eba97" appName:@"QiYuKF"];
    
    // 推送消息相关处理
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        
        UIUserNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
    
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        [application registerForRemoteNotificationTypes:types];
    }
    
    NSDictionary *remoteNotificationInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotificationInfo) {
        
        [self showChatViewController:remoteNotificationInfo];
    }
    
    return YES;
}

- (void)showChatViewController:(NSDictionary *)remoteNotificationInfo {

    id object = [remoteNotificationInfo objectForKey:@"nim"]; // 含有"nim"字段,就标示是七鱼的消息
    if (object) {
        
        NSLog(@"接收到七鱼的消息了");
    }
}

#pragma mark - 自定义聊天组件

- (void)customSessionUI {
    
    /**
     *  访客文本消息字体颜色
     */
    [[QYSDK sharedSDK] customUIConfig].customMessageTextColor = [UIColor redColor];
}

@end
