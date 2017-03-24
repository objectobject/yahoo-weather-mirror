//
//  HHXXCityManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCityManager.h"

@implementation HHXXCityManager



+ (instancetype)sharedCityManager
{
    static HHXXCityManager* _cm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cm = [HHXXCityManager new];
    });
    
    return _cm;
}

- (BOOL)addCity:(HHXXCity*)city
{
    return YES;
}


- (BOOL)removeCity:(HHXXCity*)city
{
    return YES;
}


- (BOOL)switchCityWithIndex:(NSUInteger)index1 index2:(NSUInteger)index2
{
    return YES;
}



- (void)_hhxxSave
{
   dispatch_async(dispatch_get_main_queue(), ^{
       
   });
}
@end
