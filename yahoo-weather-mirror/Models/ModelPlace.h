//
//  ModelPlace.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelPlaceTypeName : NSObject
@property (nonatomic, copy) NSString* code;
@property (nonatomic, copy) NSString* content;
@end

@interface ModelAreaInformation : NSObject
@property (nonatomic, copy) NSString* code;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* woeid;
@property (nonatomic, copy) NSString* content;
@end

@interface ModelLocality : NSObject
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* woeid;
@property (nonatomic, copy) NSString* content;
@end

@interface ModelCentroid : NSObject
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* longitude;
@end

@interface ModelBoundingBox : NSObject
@property (nonatomic, strong) ModelCentroid* southWest;
@property (nonatomic, strong) ModelCentroid* northEast;
@end

@interface ModelPlace : NSObject
@property (nonatomic, copy) NSString* woeid;
@property (nonatomic, strong) ModelPlaceTypeName* placeTypeName;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) ModelAreaInformation* country;
@property (nonatomic, strong) ModelAreaInformation* admin1;
@property (nonatomic, strong) ModelAreaInformation* admin2;
@property (nonatomic, strong) ModelAreaInformation* admin3;
@property (nonatomic, strong) ModelLocality* locality1;
@property (nonatomic, strong) ModelLocality* locality2;
@property (nonatomic, strong) ModelLocality* postal;
@property (nonatomic, strong) ModelCentroid* centroid;
@property (nonatomic, strong) ModelBoundingBox* boundingBox;
@property (nonatomic, copy) NSString* areaRank;
@property (nonatomic, copy) NSString* popRank;
@property (nonatomic, strong) ModelLocality* timezone;

- (NSString*)description;
@end

