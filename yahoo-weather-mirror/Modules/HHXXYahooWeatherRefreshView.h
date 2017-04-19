//
//  HHXXYahooWeatherRefreshView.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/18.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HHXXUIScrollViewPredefine.h>

@interface HHXXYahooWeatherRefreshView : UIView<HHXXRefreshViewProtocol>

- (void)configureModel:(id)model;
@end
