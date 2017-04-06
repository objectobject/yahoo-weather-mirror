//
//  HHXXYQLApiManager.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HHXXAbstractApiManager.h"

@interface HHXXYQLApiManager : HHXXAbstractApiManager<HHXXNetworkingApiProtocol>

+ (NSString*)hhxxGetCityInformationByKeyWord:(NSString*)kw;
+ (NSString*)hhxxGetCityInformationByLatitudeValue:(CGFloat)latitudeValue
                                     longitudeValue:(CGFloat)longitudeValue;
+ (NSString*)hhxxGetWeatherForecastByWoeid:(NSString*)woeid;
@end
