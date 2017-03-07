//
//  HHXXDefaultTransitioningAnimator.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHXXDefaultTransitioningAnimator : NSObject<UIViewControllerInteractiveTransitioning, UIViewControllerAnimatedTransitioning>


- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)finishInteractiveTransition;
- (void)cancelInteractiveTransition;
@end
