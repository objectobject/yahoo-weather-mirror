//
//  YahooWeatherInformationView.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHXXAutoLayoutView.h"


@interface YahooWeatherInformationView : HHXXAutoLayoutView


- (instancetype)initWithFrame:(CGRect)frame;
- (void)configureWithModel:(id)model;
@end