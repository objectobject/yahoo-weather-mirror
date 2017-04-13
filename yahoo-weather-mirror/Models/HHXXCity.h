//
//  HHXXCity.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kHHXXCurrentCity;

@interface HHXXCity : NSObject<NSCoding>
@property (nonatomic, copy) NSString* cnCityName;
@property (nonatomic, copy) NSString* enCityName;
@property (nonatomic, copy) NSString* zipCode;

@property (nonatomic, copy) NSString* woeid;
@property (nonatomic, assign) BOOL isLocation;
@end
