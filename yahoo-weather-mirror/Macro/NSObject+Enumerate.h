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



typedef NS_ENUM(NSUInteger, HHXXWeatherInformationType)
{
    DailyAndWeekInformation,
    DetailInformation,
    RainfallInformation,
    SpeedInformation,
    SunAndMoonInformation,
    MapInformation,
    Ad
};


/**
 *  定义视图边框类型枚举
 */
typedef NS_OPTIONS(NSInteger, HHXXBorderStyle) {
    /**
     *  无边框
     */
    HHXXBorderStyleNone,
    /**
     *  上边框
     */
    HHXXBorderStyleLeft = 1 << 0,
    /**
     *  左边框
     */
    HHXXBorderStyleTop = 1 << 1,
    /**
     *  下边框
     */
    HHXXBorderStyleRight = 1 << 2,
    /**
     *  右边框
     */
    HHXXBorderStyleBottom = 1 << 3,
    /**
     *  虚线边框
     */
    HHXXBorderStyleDashed = 1 << 4,
    /**
     *  全边框
     */
    HHXXBorderStyleAll = HHXXBorderStyleTop | HHXXBorderStyleBottom | HHXXBorderStyleLeft | HHXXBorderStyleRight
};

@interface NSObject (Enumerate)

@end
