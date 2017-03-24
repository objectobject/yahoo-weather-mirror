//
//  HHXXCity.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHXXCity : NSObject
@property (nonatomic, readonly, copy) NSString* cnCityName;
@property (nonatomic, readonly, copy) NSString* enCityName;
@property (nonatomic, readonly, copy) NSString* zipCode;
@property (nonatomic, readonly, copy) NSArray<NSString*>* keyWords;
@end
