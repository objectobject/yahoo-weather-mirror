//
//  HHXXDefaultTransitioningAnimator.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXDefaultTransitioningAnimator.h"
#import "NSObject+Enumerate.h"

static const NSTimeInterval kHHXXViewControllerTransitionDuration = .5f;

@interface HHXXDefaultTransitioningAnimator()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, assign) HHXXDirection direction;
@end

@implementation HHXXDefaultTransitioningAnimator

- (instancetype)initWithDiection:(HHXXDirection)direction
{
    self = [super init];
    
    if (self) {
        self.direction = direction;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kHHXXViewControllerTransitionDuration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView* containView = [transitionContext containerView];
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView* fromView = nil;
    UIView* toView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    }
    else
    {
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    CGFloat slideDistanceForToView = self.direction == ToRight? -containView.bounds.size.width: containView.bounds.size.width;
    
    
    [[transitionContext containerView] addSubview:toView];
    
    fromView.transform = CGAffineTransformIdentity;
    toView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -slideDistanceForToView, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromView.transform = CGAffineTransformMakeTranslation(slideDistanceForToView, 0);
        toView.transform = CGAffineTransformIdentity;
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
