//
//  HHXXYahooWeatherRefreshView.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/18.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXYahooWeatherRefreshView.h"
#import <HHXXUIScrollViewPredefine.h>

@interface HHXXYahooWeatherRefreshView()<HHXXRefreshViewProtocol>

@end

@implementation HHXXYahooWeatherRefreshView
@synthesize state = _state;
@synthesize hhxxRefreshType = _hhxxRefreshType;

- (void)setState:(HHXXRefreshState)state
{
    _state = state;
}

- (HHXXRefreshState)state
{
    return _state;
}

- (void)setHhxxRefreshType:(HHXXRefreshType)hhxxRefreshType
{
    _hhxxRefreshType = hhxxRefreshType;
}

- (HHXXRefreshType)hhxxRefreshType
{
    return _hhxxRefreshType;
}


- (void)hhxxSetProgress:(CGFloat)progressValue withMaxValue:(CGFloat)maxValue
{
    
}

- (void)hhxxStopLoading
{
    
}

- (void)hhxxStartLoading
{
    
}
@end
