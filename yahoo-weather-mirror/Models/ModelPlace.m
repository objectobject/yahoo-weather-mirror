//
//  ModelPlace.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "ModelPlace.h"

@implementation ModelPlaceTypeName : NSObject

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"code": @"code",
             @"content":@"content"
             };
}
@end

@implementation ModelAreaInformation : NSObject

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"code": @"code",
             @"content":@"content",
             @"type": @"type",
             @"woeid": @"woeid"
             };
}
@end

@implementation ModelLocality : NSObject

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"content":@"content",
             @"type": @"type",
             @"woeid": @"woeid"
             };
}
@end

@implementation ModelCentroid : NSObject

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"latitude":@"latitude",
             @"longitude": @"longitude"
             };
}
@end

@implementation ModelBoundingBox : NSObject

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"southWest":@"southWest",
             @"northEast": @"northEast"
             };
}
@end

@implementation ModelPlace

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"woeid": @"woeid",
             @"name": @"name",
             @"placeTypeName":@"placeTypeName",
             @"country": @"country",
             @"admin1": @"admin1",
             @"admin2": @"admin2",
             @"admin3": @"admin3",
             @"locality1": @"locality1",
             @"locality2": @"locality2",
             @"postal": @"postal",
             @"centroid": @"centroid",
             @"boundingBox": @"boundingBox",
             @"areaRank": @"areaRank",
             @"popRank": @"popRank",
             @"timezone": @"timezone"
             };
}

//- (NSDictionary<NSString*, id>*)modelContainerPropertyGenericClass
//{
//    return @{@"placeTypeName": ModelPlaceTypeName.class,
//             @"country": ModelAreaInformation.class,
//             @"admin1": ModelAreaInformation.class,
//             @"admin2": ModelAreaInformation.class,
//             @"admin3": ModelAreaInformation.class,
//             @"locality1": ModelLocality.class,
//             @"locality2": ModelLocality.class,
//             @"postal": ModelLocality.class,
//             @"centroid": ModelCentroid.class,
//             @"boundingBox": ModelBoundingBox.class,
//             @"timezone": ModelLocality.class
//             };
//}


- (NSString*)description
{
    NSMutableString* showTitle = [NSMutableString new];
    [showTitle appendFormat:@"%@", self.name];
    if (self.admin3) {
        [showTitle appendFormat:@", %@", self.admin3.content];
    }
    if (self.admin2) {
        [showTitle appendFormat:@", %@", self.admin2.content];
    }
    if (self.admin1) {
        [showTitle appendFormat:@", %@", self.admin1.content];
    }
    if (self.country) {
        [showTitle appendFormat:@", (%@, %@)", self.country.content, self.country.code];
    }
    
    return showTitle;
}
@end
