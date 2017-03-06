//
//  HHXXViewControllerTransitioningContext.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/5.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXViewControllerTransitioningContext.h"

@interface HHXXViewControllerTransitioningContext()

@property (nonatomic, copy) NSDictionary* childrenViewControllers;
@property (nonatomic, assign) BOOL transitionWasCancelled;

@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@property (nonatomic, weak) UIView* containerView;

@property (nonatomic, assign) CGRect appearFromRect;
@property (nonatomic, assign) CGRect appearToRect;
@property (nonatomic, assign) CGRect disappearFromRect;
@property (nonatomic, assign) CGRect disappearToRect;
@property (nonatomic, assign) HHXXDirection animatedDirection;
@end

@implementation HHXXViewControllerTransitioningContext

- (instancetype)initWithFromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController slideDirection:(HHXXDirection)slideDirection
{
    NSAssert([fromViewController isViewLoaded] && fromViewController.view.superview, @"转场上下文无法完成初始化!");
    
    self = [super init];
    
    if (self)
    {
        self.childrenViewControllers = @{
            UITransitionContextFromViewControllerKey: fromViewController,
            UITransitionContextToViewControllerKey: toViewController
        };
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.animatedDirection = slideDirection;
        
        CGFloat travelDistance = (self.animatedDirection ==  ToRight? self.containerView.bounds.size.width : -self.containerView.bounds.size.width);
        
        self.appearToRect = self.disappearFromRect = self.containerView.bounds;
        self.appearFromRect = CGRectOffset(self.containerView.bounds, -travelDistance, 0);
        self.disappearToRect = CGRectOffset(self.containerView.bounds, travelDistance, 0);
    }
    
    return self;
}

- (UIView *)containerView
{
    return _containerView;
}

- (void)setIsInteractive:(BOOL)isInteractive
{
    _isInteractive = isInteractive;
}




- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    if (vc == [self viewControllerForKey:UITransitionContextFromViewControllerKey])
    {
        return self.appearFromRect;
    }
    return self.disappearFromRect;
}


- (CGRect)finalFrameForViewController:(UIViewController *)vc
{
    if (vc == [self viewControllerForKey:UITransitionContextToViewControllerKey])
    {
        return self.appearToRect;
    }
    
    return self.disappearToRect;
}

- (BOOL)transitionWasCancelled
{
    if (!_isInteractive) {
        return YES;
    }
    
    return _transitionWasCancelled;
}


- (void)completeTransition:(BOOL)didComplete
{
    if (self.completeBlock) {
        self.completeBlock(didComplete);
    }
}


- (UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key
{
    return self.childrenViewControllers[key];
}


- (UIView *)viewForKey:(UITransitionContextViewKey)key
{
    UIViewController* vc = [self viewControllerForKey:key];
    
    return vc.view;
}


#pragma mark - interactive
- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    
}

- (void)pauseInteractiveTransition
{
    
}

- (void)cancelInteractiveTransition
{
    
}

- (void)finishInteractiveTransition
{
    
}
@end
