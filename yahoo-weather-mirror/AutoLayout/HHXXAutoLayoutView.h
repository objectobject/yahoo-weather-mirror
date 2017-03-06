//
//  HHXXAutoLayoutView.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHXXAutoLayoutView : UIView

@property (nonatomic, assign) BOOL layoutConstraintsIsCreated;

+ (BOOL)requiresConstraintBasedLayout;

- (void)configureWithModel:(id)model;

- (void)updateConstraints;
- (void)hhxx_createLayoutConstraintsIfNeed;
- (void)hhxx_createLayoutConstraints;
@end
