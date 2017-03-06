//
//  HHXXAutoLayoutTableViewCell.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const CGFloat kHHXXHPadding;
extern const CGFloat kHHXXVPadding;
extern const CGFloat kHHXX2DivPadding;

typedef void (^HHXXCellTouchBlock)();

@interface HHXXAutoLayoutTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UIView* contentViewInstead;
@property (nonatomic, assign) BOOL layoutConstraintsIsCreated;
@property (nonatomic, copy) HHXXCellTouchBlock touchBlock;

+ (BOOL)requiresConstraintBasedLayout;
- (void)configureWithModel:(id)model;
- (void)commonInit;

- (void)updateConstraints;
- (void)hhxx_createLayoutConstraintsIfNeed;
- (void)hhxx_createLayoutConstraints;
@end
