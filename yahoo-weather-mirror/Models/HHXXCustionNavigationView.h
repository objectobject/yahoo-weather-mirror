//
//  HHXXCustionNavigationView.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHXXAutoLayoutView.h"

@interface HHXXCustionNavigationView  : HHXXAutoLayoutView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIButton* leftButton;
@property (nonatomic, strong) UIButton* rightButton;
@property (nonatomic, strong) CAGradientLayer* gradientLayer;


- (void)setTitle:(NSString*)title;
- (void)hhxxAlpha:(CGFloat)alpha;
@end
