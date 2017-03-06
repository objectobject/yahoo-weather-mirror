//
//  UIColor+HHXXProvider.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Provider)

+ (UIColor*)hhxxRandomColor;
+ (UIColor*)hhxxColorWithHexString:(NSString*)hexValue withOpacity:(float)opacity;
+ (UIColor*)hhxxColorWithHex:(long)hexValue;
+ (UIColor*)hhxxColorWithHex:(long)hexValue withOpacity:(float)opacity;
// 默认的颜色池
+ (NSArray*)hhxxColors;
// 从颜色池中随机出一个颜色
+ (UIColor*)hhxxPickColor;
+ (UIColor*)hhxxPickColorWithIndex:(NSInteger)index;
@end
