//
//  ModelWeatherForecast.h
//  yahoo_weather_mirror
//
//  Created by as4 on 16/9/5.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YahooWeatherForecastModelHead.h"
@class ModelUnits;
@class ModelLocation;
@class ModelWind;
@class ModelAtmosphere;
@class ModelAstronomy;
@class ModelWeatherItem;

@interface ModelWeatherForecast : NSObject
@property (nonatomic, strong) ModelUnits* units;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* link;
@property (nonatomic, copy) NSString* lastBuildDate;
@property (nonatomic, assign) NSUInteger ttl;
@property (nonatomic, strong) ModelLocation* location;
@property (nonatomic, strong) ModelWind* wind;
@property (nonatomic, strong) ModelAtmosphere* atmosphere;
@property (nonatomic, strong) ModelAstronomy* astronomy;
@property (nonatomic, strong) ModelWeatherItem* item;


- (id)hhxxWeatherFiltrator:(HHXXWeatherForecastType)type;
@end
