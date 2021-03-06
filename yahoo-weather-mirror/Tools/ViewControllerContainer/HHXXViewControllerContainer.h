//
//  HHXXViewControllerContainer.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HHXXTransitioningDelegate;

@interface HHXXViewControllerContainer : UIViewController
@property (nonatomic, strong, readonly) NSMutableArray<UIViewController*>* children;
@property (nonatomic, copy) id<HHXXTransitioningDelegate> hhxxTransitioningDelegate;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (instancetype)initWithViewControllers:(NSMutableArray<UIViewController*>*)viewControllers;

- (void)hhxxInsertViewController:(UIViewController*)viewController atIndex:(NSUInteger)index;
- (UIViewController*)hhxxRemoveViewControllerAtIndex:(NSUInteger)index;
- (void)containerSwitchViewController:(UIViewController*)vc1 viewController2:(UIViewController*)vc2;


// 侧边栏情况
@property (nonatomic, strong) UIViewController* leftSliderViewController;
@end


// 转场相关的自定义协议
@protocol HHXXTransitioningDelegate <NSObject>
- (id <UIViewControllerAnimatedTransitioning>)hhxxContainerViewController:(HHXXViewControllerContainer*)containerViewController fromViewController:(UIViewController*)fromVC toViewController:(UIViewController*)toVC;

- (id <UIViewControllerAnimatedTransitioning>)hhxxContainerViewController:(HHXXViewControllerContainer*)containerViewController toViewController:(UIViewController*)toVC;

@optional
// TODO:后面需要添加交互相关的协议

- (id <UIViewControllerInteractiveTransitioning>)hhxxInteractiveContainerViewController:(HHXXViewControllerContainer*)containerViewController fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController;
@end

