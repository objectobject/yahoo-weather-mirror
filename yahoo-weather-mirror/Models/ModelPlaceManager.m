//
//  ModelPlaceManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "ModelPlaceManager.h"
#import "ModelPlace.h"

@interface ModelPlaceManager()

@end

@implementation ModelPlaceManager

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"place": @"query.results.place",
             @"created":@"query.created",
             @"count": @"query.count"
             };
}

+ (NSDictionary<NSString*, id>*)modelContainerPropertyGenericClass
{
    return @{@"place": ModelPlace.class,
             };
}

@end
