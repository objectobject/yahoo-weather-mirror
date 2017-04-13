//
//  HHXXCity.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCity.h"

NSString *const kHHXXCurrentCity = @"目前位置";

@implementation HHXXCity


- (BOOL)isEqual:(id)object
{
    if ([self class] != [object class])
    {
        return NO;
    }
    
    HHXXCity* newCity = (HHXXCity*)object;
    
    if(![self.cnCityName isEqualToString:newCity.cnCityName])
    {
        return NO;
    }
    
    if(![self.enCityName isEqualToString:newCity.enCityName])
    {
        return NO;
    }
    
    return [self.woeid isEqualToString:newCity.woeid];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self && aDecoder != nil)
    {
        _zipCode = [aDecoder decodeObjectForKey:@"zipCode"];
        _enCityName = [aDecoder decodeObjectForKey:@"enCityName"];
        _cnCityName = [aDecoder decodeObjectForKey:@"cnCityName"];
        _woeid = [aDecoder decodeObjectForKey:@"woeid"];
        _isLocation = [aDecoder decodeIntegerForKey:@"isLocation"];
    }
    
    return self;
}

// TODO: 实现一个hash

- (NSUInteger)hash
{
    return rand() % 100;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cnCityName forKey:@"cnCityName"];
    [aCoder encodeObject:self.enCityName forKey:@"enCityName"];
    [aCoder encodeObject:self.woeid forKey:@"woeid"];
    [aCoder encodeInteger:self.isLocation forKey:@"isLocation"];
    [aCoder encodeObject:self.zipCode forKey:@"zipCode"];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"city: %@", self.cnCityName];
}
@end
