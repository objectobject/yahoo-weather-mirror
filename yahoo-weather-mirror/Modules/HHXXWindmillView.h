//
//  HHXXWindmillView.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHXXAutoLayoutView.h"

@interface HHXXWindmillView : HHXXAutoLayoutView
@property (nonatomic, assign) CGFloat scaleValue;

- (void)hhxxTick;
@end
