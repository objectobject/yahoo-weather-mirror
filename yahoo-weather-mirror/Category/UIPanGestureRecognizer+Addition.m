//
//  UIPanGestureRecognizer+Addition.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/7.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "UIPanGestureRecognizer+Addition.h"

const CGFloat kAvalidDistance = 10;
const CGFloat kVolecityValue = 100;

const CGFloat kAvalidSwipeDistance = 22;

@implementation UIPanGestureRecognizer (Addition)


- (HHXXDirection)hhxxPanDirectionInView:(UIView*)view withoutVertical:(BOOL)withoutVertical
{
    CGPoint point = [self locationInView:view];
    double fabsXValue = fabs(point.x);
    double fabsYValue = fabs(point.y);
    
    if (fabsXValue < kAvalidDistance && fabsYValue < kAvalidDistance) {
        return NoDirection;
    }
    
    if (withoutVertical)
    {
        return point.x > 0 ? ToRight: ToLeft;
    }
    
    if (fabsXValue > fabsYValue)
    {
        return point.x > 0 ? ToRight: ToLeft;
    }
    return point.y > 0 ? ToTop: ToBottom;
}


- (HHXXDirection)hhxxSwipeDirectionInView:(UIView*)view withoutVertical:(BOOL)withoutVertical
{
    CGPoint point = [self velocityInView:view];
    double fabsXValue = fabs(point.x);
    double fabsYValue = fabs(point.y);
    
    if (fabs(fabsXValue) < kVolecityValue && fabs(fabsYValue) < kVolecityValue) {
        return NoDirection;
    }
    
    point = [self locationInView:view];
    fabsXValue = fabs(point.x);
    fabsYValue = fabs(point.y);
    
    if (fabsXValue < kAvalidSwipeDistance && fabsYValue < kAvalidSwipeDistance) {
        return NoDirection;
    }
    
    if (withoutVertical)
    {
        return point.x > 0 ? ToRight: ToLeft;
    }
    
    if (fabsXValue > fabsYValue)
    {
        return point.x > 0 ? ToRight: ToLeft;
    }
    return point.y > 0 ? ToTop: ToBottom;
}
@end
