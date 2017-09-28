//
//  XHNavViewController.m
//  QiYuKF
//
//  Created by XH-LWR on 2017/9/20.
//  Copyright © 2017年 linwenrui. All rights reserved.
//

#import "XHNavViewController.h"
#import "UIColor+Extension.h"
#import "UIImage+Gradient.h"

@interface XHNavViewController ()

@end

@implementation XHNavViewController // 0  160 240

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建CGContextRef
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heigth = 64.f;
    UIGraphicsBeginImageContext(CGSizeMake(width, heigth));
    CGContextRef gc = UIGraphicsGetCurrentContext();

    // 创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();

    // 绘制path
    CGRect rect = CGRectMake(0, 0, width, heigth);
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);

    // 绘制渐变
    [UIImage drwaLinerGradient:gc path:path startColor:[UIColor colorWithHex:0x00A0F0].CGColor endColor:[UIColor colorWithHex:0x1f6c94].CGColor];

    // 注意释放CGMutablePathRef
    CGPathRelease(path);

    // 从context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *titleAttDic = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = titleAttDic;
    
    NSDictionary *textAttDic = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor whiteColor]};
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:textAttDic forState:UIControlStateNormal];
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

@end
