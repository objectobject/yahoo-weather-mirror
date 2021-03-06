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
@property (nonatomic, strong) UIView* containerView;

@property (nonatomic, assign) CGRect appearFromRect;
@property (nonatomic, assign) CGRect appearToRect;
@property (nonatomic, assign) CGRect disappearFromRect;
@property (nonatomic, assign) CGRect disappearToRect;
@end

@implementation HHXXViewControllerTransitioningContext

- (instancetype)initWithFromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController
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
//        self.animatedDirection = slideDirection;
//        
//        CGFloat travelDistance = (self.animatedDirection ==  ToRight)? self.containerView.bounds.size.width : -self.containerView.bounds.size.width;
//        
//        self.appearFromRect = self.disappearToRect = self.containerView.bounds;
//        self.disappearFromRect = self.appearToRect = CGRectOffset(self.containerView.bounds, travelDistance, 0);
    }
    
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    return CGRectZero;
}


- (CGRect)finalFrameForViewController:(UIViewController *)vc
{
    return vc.view.frame;
}

- (UIView *)containerView
{
    return _containerView;
}

- (void)setIsInteractive:(BOOL)isInteractive
{
    _isInteractive = isInteractive;
}

- (BOOL)transitionWasCancelled
{
    if (!_isInteractive) {
        return NO;
    }
    
    return _transitionWasCancelled;
}


- (void)completeTransition:(BOOL)didComplete
{
    if (self.completeBlock) {
        self.completeBlock(didComplete);
    }
    self.completeBlock = nil;
}


- (UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key
{
    return self.childrenViewControllers[key];
}


- (UIView *)viewForKey:(UITransitionContextViewKey)key
{
    if ([key isEqualToString:UITransitionContextFromViewKey]) {
        return [self viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    }
    
    return [self viewControllerForKey:UITransitionContextToViewControllerKey].view;
}


#pragma mark - interactive
- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    self.containerView.layer.timeOffset = percentComplete;
}

- (void)pauseInteractiveTransition
{
}

- (void)cancelInteractiveTransition
{
    _transitionWasCancelled = YES;
    CADisplayLink* displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_hhxxCancelAnimation:)];
    [displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)_hhxxCancelAnimation:(CADisplayLink*)displayLink
{
    NSTimeInterval timeOffset = self.containerView.layer.timeOffset;
    timeOffset -= displayLink.duration;
    
    if (timeOffset > 0)
    {
        self.containerView.layer.timeOffset = timeOffset;
    }
    else
    {
        [displayLink invalidate];
        self.containerView.layer.timeOffset = 0.0;
        self.containerView.layer.speed = 1.0;
    }
}


- (void)finishInteractiveTransition
{
    NSTimeInterval pauseTimeOffset = self.containerView.layer.timeOffset;
    self.containerView.layer.speed = 1.0f;
    self.containerView.layer.beginTime = 0.0;
    self.containerView.layer.timeOffset = 0.0;
    NSTimeInterval timeSincePause = [self.containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTimeOffset;
    self.containerView.layer.beginTime = timeSincePause;
}
@end
