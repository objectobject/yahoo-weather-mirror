//
//  HHXXViewControllerTransitioningAnimator.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/5.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHXXViewControllerTransitioningAnimator : NSObject<UIViewControllerAnimatedTransitioning>


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
