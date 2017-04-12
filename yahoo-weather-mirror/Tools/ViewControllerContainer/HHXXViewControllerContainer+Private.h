//
//  HHXXViewControllerContainer+Private.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//


#import "NSObject+Enumerate.h"
#import "HHXXCustionNavigationView.h"

@interface HHXXViewControllerContainer()

@property (nonatomic, copy, readwrite) NSMutableArray<UIViewController*>* children;
@property (nonatomic, strong) UIViewController* selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) UIViewController* preSelectedViewController;

// 装饰视图
@property (nonatomic, strong) NSArray<UIButton*>* switchButtons;
@property (nonatomic, strong) UIView* decorateView;
@property (nonatomic, strong) UIView* rootView;

// 布局约束
@property (nonatomic, strong) NSLayoutConstraint* topConstraintForDecorateView;
@property (nonatomic, strong) NSLayoutConstraint* widthConstraintForDecorateView;


// 交互式转场
@property (nonatomic, strong) id animator;
@property (nonatomic, assign) HHXXDirection directionForAnimation;
@property (nonatomic, assign) CGFloat xDistance;

@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer* leftSwipeGestureRecognizer, *rightSwipeGestureRecognizer;
@end
