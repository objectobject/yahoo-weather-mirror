//
//  HHXXCityManager+Transform.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCityManager.h"
@class HHXXSetting;

@interface HHXXCityManager (Transform)

- (NSArray<HHXXSetting*>*)hhxxAllCityToSetings:(BOOL)isExpand;
@end
