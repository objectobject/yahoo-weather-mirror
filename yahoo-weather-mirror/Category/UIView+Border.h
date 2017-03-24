//
//  UIView+Border.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/9.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Enumerate.h"

@interface UIView (Border)

- (void)hhxxAddBorderWithColor:(UIColor*)borderColor borderWidth:(NSInteger)borderWidth borderStyle:(HHXXBorderStyle)borderStyle;
- (void)hhxxAddBorderWithColor:(UIColor*)borderColor borderWidth:(NSInteger)borderWidth;
@end
