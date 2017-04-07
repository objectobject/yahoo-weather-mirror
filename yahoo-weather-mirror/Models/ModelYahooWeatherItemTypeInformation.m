//
//  ModelInfomationType.m
//  yahoo_weather_mirror
//
//  Created by as4 on 16/9/8.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import "ModelYahooWeatherItemTypeInformation.h"

@implementation ModelYahooWeatherItemTypeInformation


- (BOOL)canSorted
{
    return !(self.type == HHXXWeatherForecastTypeAd || self.type == HHXXWeatherForecastTypeForecast);
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.isNib = [aDecoder decodeIntegerForKey:@"isNib"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeInteger:self.isNib forKey:@"isNib"];
}


- (BOOL)isEqual:(id)object
{
    if ([self class] != [object class]) {
        return NO;
    }
    
    ModelYahooWeatherItemTypeInformation* type = (ModelYahooWeatherItemTypeInformation*)object;
    
    return type.type == self.type;
}


- (NSUInteger)hash
{
    return self.type;
}

@end
