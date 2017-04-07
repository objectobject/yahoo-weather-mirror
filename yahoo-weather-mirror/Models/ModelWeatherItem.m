//
//  ModelWeatherItem.m
//  oc_like_yahoo_weather
//
//  Created by as4 on 16/6/9.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import "ModelWeatherItem.h"

@implementation ModelWeatherItem

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{@"longitude": @"long"};
}

+ (NSDictionary*)modelContainerPropertyGenericClass
{
    return @{@"forecast": [ModelForecast class]};
}

@end


@implementation ModelCondition


- (NSString*)formatterWeatherIcon
{
    return self.code.length == 1? [@"0" stringByAppendingString:self.code]: self.code;
}
@end



@implementation ModelForecast

- (NSString*)formatterWeatherIcon
{
    return self.code.length == 1? [@"0" stringByAppendingString:self.code]: self.code;
}

- (NSString*)formatterWeatherHightTemperature
{
    return [NSString stringWithFormat:@"%@°", self.high];
}

- (NSString*)formatterWeatherLowTemperature
{
    return [NSString stringWithFormat:@"%@°", self.low];
}
@end


