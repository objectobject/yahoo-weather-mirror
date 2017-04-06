//
//  HHXXNetworkingServiceForWeatherInformation.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingServiceForWeatherInformation.h"
#import "HHXXNetworkingHead.h"

#define QUERY_PREFIX @"https://query.yahooapis.com/v1/public/yql?q="
#define QUERY_SUFFIX @"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="

@implementation HHXXNetworkingServiceForWeatherInformation

HHXX_AUTO_REGIST_NETWORKING_SERVICE(HHXXNetworkingServiceForWeatherInformation)

- (NSString*)hhxxBaseURLForService
{
    return @"https://query.yahooapis.com/v1/public/";
}
@end
