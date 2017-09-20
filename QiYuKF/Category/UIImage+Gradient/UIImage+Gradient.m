//
//  UIImage+Gradient.m
//  YuanMingYuan
//
//  Created by 林文锐 on 2017/8/3.
//  Copyright © 2017年 benbun. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

+ (void)drwaLinerGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor {

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};

    NSArray *colors = @[(__bridge id)startColor, (__bridge id)endColor];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);

    CGRect pathRect = CGPathGetBoundingBox(path);

    // 设计渐变方向
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));

    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
