//
//  HHXXSliderAnimator.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/12.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXSliderAnimator.h"
#import "UIView+Border.h"

@implementation HHXXSliderAnimator


- (instancetype)initWithDismiss:(BOOL)isDismiss
{
    self = [super init];
    
    if (self) {
        self.isDismiss = isDismiss;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* fromView = fromViewController.view;
    UIView* toView = toViewController.view;
    
    UIView* containerView = [transitionContext containerView];
    
    if (self.isDismiss) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else{
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        fromView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.transform = CGAffineTransformMakeTranslation(containerView.bounds.size.width * 0.66, 0);
            
            fromView.layer.shadowOffset = CGSizeMake(-1.6, 0);
            fromView.layer.shadowColor = [UIColor blackColor].CGColor;
            fromView.layer.shadowOpacity = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
@end
