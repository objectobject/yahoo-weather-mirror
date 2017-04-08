//
//  UIColor+HHXXProvider.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "UIColor+Provider.h"

@implementation UIColor (Provider)


+ (UIColor*)hhxxRandomColor
{
    float red = arc4random_uniform(256) / 256.0;
    float green = arc4random_uniform(256) / 256.0;
    float blue = arc4random_uniform(256) / 256.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


+ (UIColor*)hhxxColorWithHexString:(NSString*)hexValue withOpacity:(float)opacity
{
    return [self hhxxColorWithHex:(long)[hexValue longLongValue] withOpacity:opacity];
}


+ (UIColor*)hhxxColorWithHex:(long)hexValue
{
    return [self hhxxColorWithHex:hexValue withOpacity:1.0];
}


+ (UIColor*)hhxxColorWithHex:(long)hexValue withOpacity:(float)opacity
{
    float red = ((hexValue & 0xFF0000) >> 16) / 255.0;
    float green = ((hexValue & 0x00FF00) >> 8) / 255.0;
    float blue = ((hexValue & 0x0000FF) >> 0) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


// 默认的颜色池
+ (NSArray*)hhxxColors
{
    NSArray* colorPool = @[
                           [UIColor hhxxColorWithHex:0x5F8CE1],
                           [UIColor hhxxColorWithHex:0x66C7F0],
                           [UIColor hhxxColorWithHex:0xEAF5FE],
                           
                           [UIColor hhxxColorWithHex:0x4F45A3],
                           [UIColor hhxxColorWithHex:0x504D7B],
                           [UIColor hhxxColorWithHex:0xFAD381],
                           
                           [UIColor hhxxColorWithHex:0xEAA1B9],
                           [UIColor hhxxColorWithHex:0xD8E0E8],
                           ];
    
    return colorPool;
}


// 从颜色池中随机出一个颜色
+ (UIColor*)hhxxPickColor
{
    NSArray * colorPool = [self hhxxColors];
    if (colorPool.count) {
        return colorPool[arc4random() % colorPool.count];
    }
    return [UIColor blueColor];
}


+ (UIColor*)hhxxPickColorWithIndex:(NSInteger)index
{
    NSArray * colorPool = [self hhxxColors];
    if (colorPool.count) {
        return colorPool[index % colorPool.count];
    }
    
    return [UIColor blueColor];
}
@end
