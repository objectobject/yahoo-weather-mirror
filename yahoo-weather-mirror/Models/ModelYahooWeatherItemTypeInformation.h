//
//  ModelInfomationType.h
//  yahoo_weather_mirror
//
//  Created by as4 on 16/9/8.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YahooWeatherForecastModelHead.h"

@interface ModelYahooWeatherItemTypeInformation : NSObject<NSCoding>
@property (nonatomic, assign) HHXXWeatherForecastType type;
@property (nonatomic, assign) BOOL canSorted;
@property (nonatomic, assign) BOOL isNib;
@end
