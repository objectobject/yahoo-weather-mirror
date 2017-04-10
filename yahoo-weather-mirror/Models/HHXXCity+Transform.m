//
//  HHXXCity+Transform.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCity+Transform.h"
#import "HHXXSetting.h"

@implementation HHXXCity (Transform)

- (HHXXSetting*)hhxxToSetting
{
    HHXXSetting* citySetting = [HHXXSetting new];
    citySetting.imageName = @"icon-location";
    if (self.isLocation) {
        citySetting.title = kHHXXCurrentCity;
    }else{
        citySetting.title = self.cnCityName;
    }
    
    citySetting.type = ModelSettingPosition;
    
    
    return citySetting;
}
@end
