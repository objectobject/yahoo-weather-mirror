//
//  HHXXAddNewCityViewController.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSliderHead.h"
@protocol HHXXRefreshDelegate;


@interface HHXXAddNewCityViewController : UITableViewController
@property (nonatomic, assign) HHXXFromViewController fromType;
@property (nonatomic, weak) id<HHXXRefreshDelegate> refreshDelegate;
@end
