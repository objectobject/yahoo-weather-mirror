//
//  HHXXCityManager.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHXXCity;

@interface HHXXCityManager : NSObject
@property (nonatomic, readonly, copy) NSMutableArray<HHXXCity*>* allCitys;

+ (instancetype)sharedCityManager;

- (void)addCity:(HHXXCity*)city;
- (void)removeCity:(HHXXCity*)city;
- (void)switchCityWithIndex:(NSUInteger)index1 index2:(NSUInteger)index2;
@end
