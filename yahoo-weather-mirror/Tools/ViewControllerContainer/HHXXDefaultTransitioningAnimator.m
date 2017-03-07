//
//  HHXXDefaultTransitioningAnimator.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXDefaultTransitioningAnimator.h"

static const NSTimeInterval kHHXXViewControllerTransitionDuration = .5f;

@interface HHXXDefaultTransitioningAnimator()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation HHXXDefaultTransitioningAnimator


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kHHXXViewControllerTransitionDuration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* containView = [transitionContext containerView];
    
    [[transitionContext containerView] addSubview:toVC.view];
    //    NSLog(@"from:%@ to:%@", NSStringFromCGRect(fromView.bounds), NSStringFromCGRect(toVC.view.bounds));
    //
    //    NSLog(@"from: %@-->%@", NSStringFromCGRect( [transitionContext initialFrameForViewController:UITransitionContextFromViewKey]), NSStringFromCGRect([transitionContext finalFrameForViewController:UITransitionContextFromViewKey]));
    //    NSLog(@"to: %@-->%@", NSStringFromCGRect([transitionContext initialFrameForViewController:UITransitionContextToViewKey]), NSStringFromCGRect([transitionContext finalFrameForViewController:UITransitionContextToViewKey]));
    
    fromVC.view.transform = CGAffineTransformIdentity;
    BOOL toRight = [transitionContext finalFrameForViewController:fromVC].origin.x > [transitionContext initialFrameForViewController:fromVC].origin.x;
    
    if (toRight) {
        toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -containView.bounds.size.width, 0);
    }
    else
    {
        toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, containView.bounds.size.width, 0);
    }
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(toRight? containView.bounds.size.width: -containView.bounds.size.width, 0);
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


#pragma mark - interactive transition
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    [self animateTransition:self.transitionContext];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    [self.transitionContext updateInteractiveTransition:percentComplete * [self transitionDuration:_transitionContext]];
}

- (void)finishInteractiveTransition
{
    [self.transitionContext finishInteractiveTransition];
}

- (void)cancelInteractiveTransition
{
    [self.transitionContext cancelInteractiveTransition];
}


@end