//
//  UIColor+Extension.m
//  manager
//
//  Created by Benbun on 15/11/6.
//  Copyright © 2015年 niu. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIColor *)colorWithHex:(NSInteger)hex
{
    return [UIColor colorWithRed : ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hex & 0xFF)) / 255.0 alpha : 1.0];
}

+(UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed : ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hex & 0xFF)) / 255.0 alpha : alpha];
}

@end
