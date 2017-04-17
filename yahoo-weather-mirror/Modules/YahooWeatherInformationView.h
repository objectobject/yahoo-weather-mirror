//
//  YahooWeatherInformationView.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHXXAutoLayoutView.h"
@class HHXXCustionNavigationView;


@interface YahooWeatherInformationView : HHXXAutoLayoutView
@property (nonatomic, strong) HHXXCustionNavigationView* nav;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)configureWithModel:(id)model;
@end
