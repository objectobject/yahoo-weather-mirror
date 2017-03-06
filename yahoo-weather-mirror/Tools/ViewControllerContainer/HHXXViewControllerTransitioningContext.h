//
//  HHXXViewControllerTransitioningContext.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/5.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HHXXViewControllerTranstitionCompleteBlock)(BOOL);


// 手指滑动和动画效果方向相反
typedef NS_ENUM(NSUInteger, HHXXDirection)
{
    ToLeft = 0,
    ToRight,
    ToTop,
    ToBottom
};

@interface HHXXViewControllerTransitioningContext : NSObject<UIViewControllerContextTransitioning>

@property (nonatomic, assign) BOOL isInteractive;
@property (nonatomic, copy) HHXXViewControllerTranstitionCompleteBlock completeBlock;

- (instancetype)initWithFromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController slideDirection:(HHXXDirection)slideDirection;

@end
