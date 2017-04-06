//
//  HHXXYQLApiManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXYQLApiManager.h"
#import <UIKit/UIKit.h>

@implementation HHXXYQLApiManager
- (HHXXRequestMethod)hhxxMethodType
{
    return HHXXRequestMethodGET;
}

- (NSString*)hhxxRequestPath
{
    return @"yql";
}

- (NSString*)hhxxNetworkingServiceID
{
    return @"HHXXNetworkingServiceForWeatherInformation";
}

+ (NSString*)hhxxGetCityInformationByKeyWord:(NSString*)kw
{
    return [NSString stringWithFormat:@"select * from geo.places where text=\"%@\"", kw];
}

+ (NSString*)hhxxGetCityInformationByLatitudeValue:(CGFloat)latitudeValue
                                     longitudeValue:(CGFloat)longitudeValue
{
    return [NSString stringWithFormat:@"select * from geo.places where text=\"%.06f,%.06f\"", latitudeValue, longitudeValue];
}

+ (NSString*)hhxxGetWeatherForecastByWoeid:(NSString*)woeid
{
    //    queryString = @"select * from weather.forecast where woeid=2502265";
    return [NSString stringWithFormat:@"select * from weather.forecast where woeid=%@", woeid];
}
@end
