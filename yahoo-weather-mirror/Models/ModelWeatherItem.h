//
//  ModelWeatherItem.h
//  oc_like_yahoo_weather
//
//  Created by as4 on 16/6/9.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelCondition,ModelForecast;
@interface ModelWeatherItem : NSObject

@property (nonatomic, strong) ModelCondition *condition;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *pubDate;

@property (nonatomic, copy) NSString* lat;

@property (nonatomic, copy) NSArray<ModelForecast *> *forecast;

@property (nonatomic, copy) NSString* longitude;

@end

@interface ModelCondition : NSObject

@property (nonatomic, copy) NSString * code;

@property (nonatomic, copy) NSString * text;

@property (nonatomic, copy) NSString * temp;

@property (nonatomic, copy) NSString * date;

@property (nonatomic, copy) NSString * hightTemp;

@property (nonatomic, copy) NSString * lowTmp;

// 可以用属性代替
- (NSString*)formatterWeatherIcon;
@end


@interface ModelForecast : NSObject

@property (nonatomic, copy) NSString* code;

@property (nonatomic, copy) NSString* low;

@property (nonatomic, copy) NSString* high;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *date;

// 可以用属性代替
- (NSString*)formatterWeatherIcon;
- (NSString*)formatterWeatherHightTemperature;
- (NSString*)formatterWeatherLowTemperature;
@end

