//
//  ModelWeatherForecast.m
//  yahoo_weather_mirror
//
//  Created by as4 on 16/9/5.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import "ModelWeatherForecast.h"
#import "ModelUnits.h"
#import "ModelWeatherItem.h"
#import "YahooWeatherItemKey.h"
#import "ModelWind.h"
#import "ModelAstronomy.h"
#import "ModelAtmosphere.h"

NSString* const kHHXXTemperatureUnit = @"°";

@implementation ModelWeatherForecast

+ (NSDictionary*)modelCustomPropertyMapper
{
    return @{
             @"units": @"query.results.channel.units",
             @"title": @"query.results.channel.title",
             @"link": @"query.results.channel.link",
             @"lastBuildDate": @"query.results.channel.lastBuildDate",
             @"ttl": @"query.results.channel.ttl",
             @"location": @"query.results.channel.location",
             @"wind": @"query.results.channel.wind",
             @"atmosphere": @"query.results.channel.atmosphere",
             @"astronomy": @"query.results.channel.astronomy",
             @"item": @"query.results.channel.item"
             };
}

- (id)hhxxWeatherFiltrator:(HHXXWeatherForecastType)type
{
    id configureModel = [[NSMutableDictionary alloc] init];
    switch (type) {
            
        //TODO: 广告内容暂时写死，后续接入广告SDK
        case HHXXWeatherForecastTypeAd:
        {
            [configureModel setObject:@"我是广告"forKey:kHHXXYahooWeatherItemKey_AdTitle];
            [configureModel setObject:@"这是广告,来打我呀...." forKey:kHHXXYahooWeatherItemKey_AdContent];
            [configureModel setObject:@"adContent" forKey:kHHXXYahooWeatherItemKey_AdImage];
            [configureModel setObject:@"zhangzheyang.today" forKey:kHHXXYahooWeatherItemKey_AdURL];
        }
            break;
        
            
        // 日出，日落，月亮
        case HHXXWeatherForecastTypeSunAndMoon:
        {
            [configureModel setObject:self.astronomy.sunset forKey:kHHXXYahooWeatherItemKey_SunSetTime];
            [configureModel setObject:self.astronomy.sunrise forKey:kHHXXYahooWeatherItemKey_SunRaiseTime];
        }
            break;
            
        case HHXXWeatherForecastTypeMap:
            break;
            
        case HHXXWeatherForecastTypeNone:
            break;
        
        // 风速和气压(接口方向数据不知道如何转换, 暂时用随机数据)
        case HHXXWeatherForecastTypeWind:
        {
            NSArray* directions = @[@" 东 ", @" 西 ", @" 南 ", @" 北 ", @" 东南 ", @" 东北 ", @" 西南 ", @" 西北 "];
            
            [configureModel setObject:self.wind.speed forKey:kHHXXYahooWeatherItemKey_WindSpeed];
            [configureModel setObject:[self.units.speed stringByAppendingString:directions[arc4random() % 8]] forKey:kHHXXYahooWeatherItemKey_WindDirection];
            [configureModel setObject:[NSString stringWithFormat:@"%@ %@", self.atmosphere.pressure, self.units.pressure] forKey:kHHXXYahooWeatherItemKey_PressureValue];
        }
            break;
        
        // 其他天气信息, 当前接口没有找到紫外线和体感温度值
        case HHXXWeatherForecastTypeDetail:
        {
            [configureModel setObject:[self.item.condition formatterWeatherIcon] forKey:kHHXXYahooWeatherItemKey_HeadImage];
            [configureModel setObject:[self.atmosphere.humidity stringByAppendingString:@"%"] forKey:kHHXXYahooWeatherItemKey_DetailHumidity];
            [configureModel setObject:[self.atmosphere.visibility stringByAppendingString:self.units.distance] forKey:kHHXXYahooWeatherItemKey_DetailVisibility];
            [configureModel setObject:[self.item.condition.temp stringByAppendingString:kHHXXTemperatureUnit] forKey:kHHXXYahooWeatherItemKey_HeadTemp];
        }
            break;
            
        case HHXXWeatherForecastTypeForecast:
            break;
            
        // 降雨量信息(服务端没有降雨量信息暂时用随机数据)
        case HHXXWeatherForecastTypeRainfall:
        {
            NSArray* timeString = @[@"下午", @"傍晚", @"夜晚", @"夜间", @"清晨", @"早上"];
            NSUInteger randIndex = arc4random() % [timeString count];
            
            [configureModel setObject:[timeString objectAtIndex:randIndex] forKey:kHHXXYahooWeatherItemKey_RainFallTitle0];
            [configureModel setObject:[timeString objectAtIndex:(randIndex + 1) % [timeString count]] forKey:kHHXXYahooWeatherItemKey_RainFallTitle1];
            [configureModel setObject:[timeString objectAtIndex:(randIndex + 2) % [timeString count]] forKey:kHHXXYahooWeatherItemKey_RainFallTitle2];
            [configureModel setObject:[timeString objectAtIndex:(randIndex + 3) % [timeString count]] forKey:kHHXXYahooWeatherItemKey_RainFallTitle3];
            
            [configureModel setObject:@(arc4random() % 11 * 10) forKey:kHHXXYahooWeatherItemKey_RainFallValue0];
            [configureModel setObject:@(arc4random() % 11 * 10) forKey:kHHXXYahooWeatherItemKey_RainFallValue1];
            [configureModel setObject:@(arc4random() % 11 * 10) forKey:kHHXXYahooWeatherItemKey_RainFallValue2];
            [configureModel setObject:@(arc4random() % 11 * 10) forKey:kHHXXYahooWeatherItemKey_RainFallValue3];
        }
            break;
        
            
        // 头部信息
        case HHXXWeatherForecastTypeTodayCondition:
        {
            ModelCondition* condition = self.item.condition;
            // 处理最高和最低温度
            //            weatherForecast.units
            if ([self.item.forecast count] > 0)
            {
                [configureModel setObject:[self.item.forecast[0].high stringByAppendingString:kHHXXTemperatureUnit] forKey:kHHXXYahooWeatherItemKey_HeadTopTemp];
                [configureModel setObject:[self.item.forecast[0].low stringByAppendingString:kHHXXTemperatureUnit] forKey:kHHXXYahooWeatherItemKey_HeadLowTemp];
            }
            [configureModel setObject:[condition formatterWeatherIcon] forKey:kHHXXYahooWeatherItemKey_HeadImage];
            [configureModel setObject:condition.code forKey:kHHXXYahooWeatherItemKey_HeadCode];
            [configureModel setObject:condition.date forKey:kHHXXYahooWeatherItemKey_HeadDate];
            [configureModel setObject:condition.text forKey:kHHXXYahooWeatherItemKey_HeadText];
            [configureModel setObject:[condition.temp stringByAppendingString:kHHXXTemperatureUnit] forKey:kHHXXYahooWeatherItemKey_HeadTemp];
        }
            break;
            
            
        default:
            break;
    }
    
    return configureModel;
}
@end
