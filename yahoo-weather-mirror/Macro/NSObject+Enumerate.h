//
//  NSObject+Enumerate.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/7.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>


// 手指滑动和动画效果方向相反
typedef NS_ENUM(NSUInteger, HHXXDirection)
{
    ToLeft = 0,
    ToRight,
    ToTop,
    ToBottom,
    NoDirection
};

@interface NSObject (Enumerate)

@end
