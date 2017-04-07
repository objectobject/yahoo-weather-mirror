//
//  ModelCity.h
//  yahoo_weather_mirror
//
//  Created by as4 on 16/9/5.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelCity : NSObject<NSCoding>
@property (nonatomic, copy) NSString* cityName;
@property (nonatomic, assign) NSInteger woeid;
@property (nonatomic, assign) BOOL isLocation;

@end
