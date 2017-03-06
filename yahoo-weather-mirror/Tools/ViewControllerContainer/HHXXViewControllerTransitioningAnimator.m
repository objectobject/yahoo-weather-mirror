//
//  HHXXViewControllerTransitioningAnimator.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/5.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXViewControllerTransitioningAnimator.h"

static const NSTimeInterval kHHXXViewControllerTransitionDuration = 1.0f;

@implementation HHXXViewControllerTransitioningAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kHHXXViewControllerTransitionDuration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* fromView = fromVC.view;
    CGRect initFrame = [transitionContext initialFrameForViewController:UITransitionContextToViewKey];
    UIView* toView = toVC.view;
    
    
    [[transitionContext containerView] addSubview:toVC.view];
//    NSLog(@"from:%@ to:%@", NSStringFromCGRect(fromView.bounds), NSStringFromCGRect(toVC.view.bounds));
//    
//    NSLog(@"from: %@-->%@", NSStringFromCGRect( [transitionContext initialFrameForViewController:UITransitionContextFromViewKey]), NSStringFromCGRect([transitionContext finalFrameForViewController:UITransitionContextFromViewKey]));
//    NSLog(@"to: %@-->%@", NSStringFromCGRect([transitionContext initialFrameForViewController:UITransitionContextToViewKey]), NSStringFromCGRect([transitionContext finalFrameForViewController:UITransitionContextToViewKey]));
    
    BOOL toRight = [transitionContext finalFrameForViewController:fromVC].origin.x - [transitionContext initialFrameForViewController:fromVC].origin.x;
    
    fromView.transform = CGAffineTransformIdentity;
    UIView* containView = [transitionContext containerView];
    toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -containView.bounds.size.width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = CGAffineTransformMakeTranslation(containView.bounds.size.width, 0);
        toView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
