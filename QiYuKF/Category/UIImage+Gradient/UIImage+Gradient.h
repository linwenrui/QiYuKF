//
//  UIImage+Gradient.h
//  YuanMingYuan
//
//  Created by 林文锐 on 2017/8/3.
//  Copyright © 2017年 benbun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gradient)

+ (void)drwaLinerGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor;

@end
