//
//  UIView+AutoLayout.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LayoutDirection)
{
    LayoutDirectionHorizontal = 0,
    LayoutDirectionVertical
};

@interface UIView (AutoLayout)


- (void)layoutWithSubviews:(NSArray*)subViews layoutDirection:(LayoutDirection)layoutDirection;

@end
