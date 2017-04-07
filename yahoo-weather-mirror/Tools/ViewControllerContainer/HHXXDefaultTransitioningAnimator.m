//
//  HHXXDefaultTransitioningAnimator.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXDefaultTransitioningAnimator.h"

static const NSTimeInterval kHHXXViewControllerTransitionDuration = 5.0f;

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
    
    
//
//    //    NSLog(@"from:%@ to:%@", NSStringFromCGRect(fromView.bounds), NSStringFromCGRect(toVC.view.bounds));
//    //
//    //    NSLog(@"from: %@-->%@", NSStringFromCGRect( [transitionContext initialFrameForViewController:UITransitionContextFromViewKey]), NSStringFromCGRect([transitionContext finalFrameForViewController:UITransitionContextFromViewKey]));
//    //    NSLog(@"to: %@-->%@", NSStringFromCGRect([transitionContext initialFrameForViewController:UITransitionContextToViewKey]), NSStringFromCGRect([transitionContext finalFrameForViewController:UITransitionContextToViewKey]));

    
    fromVC.view.transform = CGAffineTransformIdentity;
////    BOOL toRight = [transitionContext finalFrameForViewController:fromVC].origin.x > [transitionContext initialFrameForViewController:fromVC].origin.x;
//    [fromVC.view addSubview:({
//        UIView* view = [UIView new];
//        view.frame = CGRectMake(100, 100, 64, 64);
//        view.backgroundColor = [UIColor redColor];
//        view;
//    })];
//    
//    [toVC.view addSubview:({
//        UIView* view = [UIView new];
//        view.frame = CGRectMake(100, 100, 64, 64);
//        view.backgroundColor = [UIColor greenColor];
//        view;
//    })];
    
    toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -containView.bounds.size.width, 0);
    
    
    NSLog(@"from bound %@", NSStringFromCGRect(fromVC.view.frame));
    NSLog(@"to bound %@", NSStringFromCGRect(toVC.view.frame));
    
    NSLog(@"from %@", NSStringFromCGRect([transitionContext initialFrameForViewController:fromVC]));
    NSLog(@"from %@", NSStringFromCGRect([transitionContext finalFrameForViewController:fromVC]));
    NSLog(@"to %@", NSStringFromCGRect([transitionContext initialFrameForViewController:toVC]));
    NSLog(@"to %@", NSStringFromCGRect([transitionContext finalFrameForViewController:toVC]));
    
    [[transitionContext containerView] addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(containView.bounds.size.width, 0);
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
