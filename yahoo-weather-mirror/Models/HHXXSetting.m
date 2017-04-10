//
//  HHXXSettings.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXSetting.h"


const NSUInteger kHHHXXCityNumberLimit = 7;
static NSString * const kLocationIcon = @"location";


@implementation HHXXSetting

- (instancetype)initWithDictionary:(NSDictionary*)dataDictionary
{
    self = [super init];
    
    if (self)
    {
        _title = dataDictionary[@"title"];
        _imageName = dataDictionary[@"imageName"];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName type:(ModelSettingType)type
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _imageName = [imageName copy];
        _type = type;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName
{
    return [self initWithTitle:title imageName:imageName type:ModelSettingNormal];
}

- (instancetype)initWithTitle:(NSString*)title
{
    return [self initWithTitle:title imageName:@""];
}

+ (instancetype)settingWithTitle:(NSString*)title imageName:(NSString*)imageName type:(ModelSettingType)type
{
    return [[self alloc] initWithTitle:title imageName:imageName type:type];
}

+ (instancetype)settingWithTitle:(NSString*)title imageName:(NSString*)imageName
{
    return [[self alloc] initWithTitle:title imageName:imageName];
}

+ (instancetype)settingWithTitle:(NSString*)title
{
    return [[self alloc] settingWithTitle:title imageName:@""];
}

+ (instancetype)settingWithLocationName:(NSString*)locationName
{
    return [[self alloc] settingWithTitle:locationName imageName:kLocationIcon];
}

+ (instancetype)loadMoreSetting
{
    return [[self alloc] initWithTitle:@"Show More" imageName:@"icon-more" type:ModelSettingLoadMore];
}

+ (instancetype)loadFewerSetting
{
    return [[self alloc] initWithTitle:@"Show Fewer" imageName:@"icon-more" type:ModelSettingShowFewer];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"setting %@", self.title];
}

@end


