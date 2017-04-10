//
//  HHXXSettings.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSUInteger kHHHXXCityNumberLimit;

typedef NS_ENUM(NSInteger, ModelSettingType) {
    ModelSettingNormal = 0,
    ModelSettingShare,
    ModelSettingAddPosition,
    ModelSettingPosition,
    ModelSettingAppleShop,
    ModelSettingSuggest,
    ModelSettingAbout,
    ModelSettingEmpty,
    ModelSettingLoadMore,
    ModelSettingShowFewer
};


@interface HHXXSetting : NSObject<NSCoding>

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, assign) ModelSettingType type;


- (instancetype)initWithDictionary:(NSDictionary*)dataDictionary;
- (instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName type:(ModelSettingType)type;
- (instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName;
- (instancetype)initWithTitle:(NSString*)title;

+ (instancetype)settingWithTitle:(NSString*)title imageName:(NSString*)imageName type:(ModelSettingType)type;
+ (instancetype)settingWithTitle:(NSString*)title imageName:(NSString*)imageName;
+ (instancetype)settingWithTitle:(NSString*)title;
+ (instancetype)settingWithLocationName:(NSString*)locationName;

+ (instancetype)loadMoreSetting;
+ (instancetype)loadFewerSetting;

@end

