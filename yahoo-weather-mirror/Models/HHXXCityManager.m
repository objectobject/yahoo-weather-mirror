//
//  HHXXCityManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCityManager.h"
#import "HHXXCity.h"
//#import "HHXXViewControllerContainerHead.h"
#import "YahooWeatherInformationViewController.h"


NSString *const kHHXXAllCitys = @"kHHXXAllCitys";

@interface HHXXCityManager()

@property (nonatomic, copy, readwrite) NSMutableArray<HHXXCity*>* allCitys;
@end

@implementation HHXXCityManager



+ (instancetype)sharedCityManager
{
    static HHXXCityManager* _cm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cm = [HHXXCityManager new];
        [_cm addCity:({
            HHXXCity* city = [HHXXCity new];
            city.cnCityName = @"厦门";
            city.enCityName = @"XiaMen";
            city.isLocation = YES;
            city.zipCode = @"361000";
            city.woeid = @"12712963";
            city;
        })];
    });
    
    return _cm;
}


- (NSMutableArray<HHXXCity *> *)allCitys
{
    if (!_allCitys) {
        NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
        NSData* data = [userDefault objectForKey:kHHXXAllCitys];
        if (data) {
            _allCitys = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    
    if (!_allCitys) {
        _allCitys = [NSMutableArray array];
    }
    
    return _allCitys;
}


- (void)addCity:(HHXXCity*)city
{
    if ([self.allCitys containsObject:city]) {
        
        return;
    }
    [self.allCitys addObject:city];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHHXXPostMessage_AddVC" object:([YahooWeatherInformationViewController new])];
    [self _hhxxSave];
}


- (void)removeCity:(HHXXCity*)city
{
    if ([self.allCitys containsObject:city]) {
        NSUInteger index = [self.allCitys indexOfObject:city];
        [self.allCitys removeObject:city];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kHHXXPostMessage_DeleteVC" object:@(index)];
        [self _hhxxSave];
    }
}


- (void)_hhxxSave
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.allCitys] forKey:kHHXXAllCitys];
    NSLog(@"%@", self.allCitys);
    [userDefaults synchronize];
}


- (void)switchCityWithIndex:(NSUInteger)index1 index2:(NSUInteger)index2
{
    NSParameterAssert(index1 < [self.allCitys count] && index2 < [self.allCitys count]);
    
    [self.allCitys exchangeObjectAtIndex:index2 withObjectAtIndex:index1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kHHXXPostMessage_SwapVC" object:@{@"kHHXXPostMessage_OldIndex": @(index1), @"kHHXXPostMessage_NewIndex": @(index2)}];
    [self _hhxxSave];
}

@end
