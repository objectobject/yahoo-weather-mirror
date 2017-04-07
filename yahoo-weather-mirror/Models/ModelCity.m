//
//  ModelCity.m
//  yahoo_weather_mirror
//
//  Created by as4 on 16/9/5.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import "ModelCity.h"

@implementation ModelCity


- (BOOL)isEqual:(id)object
{
    if ([self class] != [object class])
    {
        return NO;
    }
    
    if(![self.cityName isEqualToString:((ModelCity*)object).cityName])
    {
        return NO;
    }
    
    return self.woeid == ((ModelCity*)object).woeid;
}


- (NSUInteger)hash
{
    return self.woeid;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self && aDecoder != nil)
    {
        _cityName = [aDecoder decodeObjectForKey:@"cityName"];
        _woeid = [aDecoder decodeIntegerForKey:@"woeid"];
        _isLocation = [aDecoder decodeIntegerForKey:@"isLocation"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeInteger:self.woeid forKey:@"woeid"];
    [aCoder encodeInteger:self.isLocation forKey:@"isLocation"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"city: %@", self.cityName];
}

@end
