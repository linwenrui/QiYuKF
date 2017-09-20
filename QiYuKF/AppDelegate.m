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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 自定义聊天组件UI效果
    [self customSessionUI];
    [[QYSDK sharedSDK] registerAppId:@"faf58ac0204f491676739f4de14eba97" appName:@"QiYuKF"];
    
    return YES;
}

#pragma mark - 自定义聊天组件

- (void)customSessionUI {
    
    /**
     *  访客文本消息字体颜色
     */
    [[QYSDK sharedSDK] customUIConfig].customMessageTextColor = [UIColor redColor];
}

@end
