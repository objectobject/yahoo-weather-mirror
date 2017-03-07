//
//  UIPanGestureRecognizer+Addition.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/7.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Enumerate.h"

extern const CGFloat kAvalidDistance;
extern const CGFloat kVolecityValue;

@interface UIPanGestureRecognizer (Addition)


- (HHXXDirection)hhxxPanDirectionInView:(UIView*)view withoutVertical:(BOOL)withoutVertical;
- (HHXXDirection)hhxxSwipeDirectionInView:(UIView*)view withoutVertical:(BOOL)withoutVertical;
@end
