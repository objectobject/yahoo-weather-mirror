//
//  HHXXEditCityViewController.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHXXRefreshDelegate;

@interface HHXXEditCityViewController : UIViewController

@property (nonatomic, weak) id<HHXXRefreshDelegate> refreshDelegate;
@end
