//
//  HHXXSettingManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXSettingManager.h"
#import "HHXXSetting.h"

@implementation HHXXSettingManager


+ (NSArray *)hhxxApplicationSettings
{
  return @[
            @[
              [HHXXSetting settingWithTitle:@"分享" imageName:@"icon-share" type:ModelSettingShare],
              [HHXXSetting settingWithTitle:@"编辑地点" imageName:@"edit-location" type:ModelSettingAddPosition]
              ],
            
            @[
              [HHXXSetting settingWithTitle:@"设置" imageName:@"icon-settings" type:ModelSettingAppleShop],
              [HHXXSetting settingWithTitle:@"建议与意见" imageName:@"icon-feedback" type:ModelSettingSuggest],
              [HHXXSetting settingWithTitle:@"给应用程序打分" imageName:@"icon-rate" type:ModelSettingAbout]
              ]
          ];
}
@end
