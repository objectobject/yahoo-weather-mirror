//
//  HHXXCityManager+Transform.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCityManager+Transform.h"
#import "HHXXSetting.h"
#import "HHXXCity+Transform.h"

@implementation HHXXCityManager (Transform)


- (NSArray<HHXXSetting*>*)hhxxAllCityToSetings:(BOOL)isExpand
{
    NSMutableArray* allSettings = [NSMutableArray array];
    
    NSUInteger countOfCity = [self.allCitys count];
    if (countOfCity <= kHHHXXCityNumberLimit) {
        [self.allCitys enumerateObjectsUsingBlock:^(HHXXCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [allSettings addObject:[obj hhxxToSetting]];
        }];
        return [allSettings copy];
    }
    
    if (isExpand) {
        [self.allCitys enumerateObjectsUsingBlock:^(HHXXCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [allSettings addObject:[obj hhxxToSetting]];
        }];
        [allSettings addObject:({
            HHXXSetting* loadlessSetting = [HHXXSetting new];
            loadlessSetting.title = @"显示更少内容";
            loadlessSetting.imageName = @"icon-more";
            loadlessSetting.type = ModelSettingShowFewer;
            loadlessSetting;
        })];
    }else{
        [self.allCitys enumerateObjectsUsingBlock:^(HHXXCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx >= kHHHXXCityNumberLimit - 1) {
                *stop = YES;
            }
            [allSettings addObject:[obj hhxxToSetting]];
        }];
        [allSettings addObject:({
            HHXXSetting* loadlessSetting = [HHXXSetting new];
            loadlessSetting.title = [NSString stringWithFormat:@"显示其他%ld项目", countOfCity - kHHHXXCityNumberLimit];
            loadlessSetting.imageName = @"icon-more";
            loadlessSetting.type = ModelSettingLoadMore;
            loadlessSetting;
        })];
    }
    
    return [allSettings copy];
}
@end
