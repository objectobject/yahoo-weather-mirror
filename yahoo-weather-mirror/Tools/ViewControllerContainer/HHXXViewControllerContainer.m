//
//  HHXXViewControllerContainer.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXViewControllerContainer.h"
#import "HHXXViewControllerTransitioningAnimator.h"
#import "HHXXViewControllerTransitioningContext.h"
#import <Masonry.h>

const NSTimeInterval kHHXXDefaultTransitionDuring = 1.0f;
const NSUInteger kHHXXDefaultSwitcherButtonWidth = 32;

@interface HHXXViewControllerContainer()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>
@property (nonatomic, copy, readwrite) NSMutableArray<UIViewController*>* children;
@property (nonatomic, strong) UIViewController* selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) NSUInteger preSelectedIndex;

// 装饰视图
@property (nonatomic, strong) NSArray<UIButton*>* switchButtons;
@property (nonatomic, strong) UIView* decorateView;
@property (nonatomic, strong) UIView* rootView;

// 布局约束
@property (nonatomic, strong) NSLayoutConstraint* topConstraintForDecorateView;
@property (nonatomic, strong) NSLayoutConstraint* widthConstraintForDecorateView;
@end

@implementation HHXXViewControllerContainer
#pragma mark - logic for UI

- (void)loadView
{
    [super loadView];
    [self _hhxxInitView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Layout decorateView  (使用VFL正确的居中方法!!!)
    NSNumber* height = @(kHHXXDefaultSwitcherButtonWidth);
    self.widthConstraintForDecorateView = [NSLayoutConstraint constraintWithItem:self.decorateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:kHHXXDefaultSwitcherButtonWidth * [self.children count]];
    [self.rootView addConstraint:self.widthConstraintForDecorateView];
    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.decorateView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_decorateView(==height)]" options:0 metrics:NSDictionaryOfVariableBindings(height) views:NSDictionaryOfVariableBindings(_decorateView)]];
    self.topConstraintForDecorateView = [NSLayoutConstraint constraintWithItem:self.decorateView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeTop multiplier:1.0 constant:22 + [self.topLayoutGuide length]];
    [self.rootView addConstraint:self.topConstraintForDecorateView];
}


- (instancetype)init
{
    return [self initWithViewControllers:nil];
}


- (void)test:(id)sender
{
    self.selectedViewController = [self.children objectAtIndex:(self.selectedIndex + 1) % [self.children count]];
}


- (instancetype)initWithViewControllers:(NSMutableArray<UIViewController*>*)viewControllers
{
    self = [super init];
    if (self)
    {
        NSAssert(viewControllers != nil && [viewControllers count] > 0, @"ViewController Container must container ViewController!");
        self.children = [NSMutableArray arrayWithArray:[viewControllers copy]];
        self.selectedViewController = [_children objectAtIndex:0];
        self.selectedIndex = 0;
        self.preSelectedIndex = 0;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}


- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    [self _transitionToViewController:selectedViewController];
    _selectedViewController = selectedViewController;
    [self _updateUI];
}

- (NSUInteger)selectedIndex
{
    return [self.children indexOfObject:_selectedViewController];
}

- (NSMutableArray<UIViewController *> *)children
{
    if (!_children) {
        _children = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return [_children copy];
}



- (UIViewController *)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index > [self.children count]) {
        return nil;
    }
    
    UIViewController* oldVC = [self.children objectAtIndex:index];
    [self.children removeObjectAtIndex:index];
    self.selectedIndex = self.selectedIndex == index? 0: self.selectedIndex;
    return oldVC;
}


- (void)insertViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    if (index > [self.children count] || viewController == nil) {
        return ;
    }
    self.selectedIndex += (self.selectedIndex == index? 1: 0);
    [self.children insertObject:viewController atIndex:index];
}

- (void)containerSwitchViewController:(UIViewController *)vc1 viewController2:(UIViewController *)vc2
{
}


#pragma mark - private method
- (void)_updateUI
{
    
}


- (void)_transitionToViewController:(UIViewController*)toViewController
{
    //    NSLog(@"BEFORE = %ld\r\n", [self.view.subviews count]);
    UIViewController* fromViewController = self.selectedViewController;
    if (![self isViewLoaded] || toViewController == nil || fromViewController == toViewController) {
        return;
    }
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    if(!fromViewController)
    {
        [self.view addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        
        [fromViewController removeFromParentViewController];
        return;
    }
    
    
    id<UIViewControllerAnimatedTransitioning> animator = nil;
    if ([self.hhxxTransitioningDelegate respondsToSelector:@selector(hhxxContainerViewController:fromViewController:toViewController:)]) {
        animator = [self.hhxxTransitioningDelegate hhxxContainerViewController:self fromViewController:fromViewController toViewController:toViewController];
    }
    animator = animator? animator: [HHXXViewControllerTransitioningAnimator new];
    
    id<UIViewControllerContextTransitioning> transitioningContext = ({
        HHXXViewControllerTransitioningContext* context = [[HHXXViewControllerTransitioningContext alloc] initWithFromViewController:fromViewController toViewController:toViewController slideDirection:ToLeft];
        context.isInteractive = NO;
        context.completeBlock = ^(BOOL didComplete){
            [self.view addSubview:toViewController.view];
            [toViewController didMoveToParentViewController:self];
            
            [fromViewController.view removeFromSuperview];
            [fromViewController didMoveToParentViewController:nil];
            
            if ([animator respondsToSelector:@selector(animationEnded:)]) {
                [animator animationEnded:didComplete];
            }
            
            //            NSLog(@"After = %ld\r\n", [self.view.subviews count]);
        };
        context;
    });
    
    [animator animateTransition:transitioningContext];
}

- (void)_hhxxInitView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"这是测试" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    [self.rootView addSubview:self.decorateView];
    if (!self.selectedViewController) {
        return;
    }
    
    // 主控制器布局
    [self addChildViewController:self.selectedViewController];
    [self.rootView insertSubview:self.selectedViewController.view belowSubview:self.decorateView];
    UIView* mainView = self.selectedViewController.view;
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[mainView]-0-|" options:0 metrics:NULL views:NSDictionaryOfVariableBindings(mainView)]];
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[mainView]-0-|" options:0 metrics:NULL views:NSDictionaryOfVariableBindings(mainView)]];
    
    [self.selectedViewController didMoveToParentViewController:self];
    
    if (!self.transitioningDelegate)
    {
        self.transitioningDelegate = self;
    }
}
#pragma mark - setter and getter
- (UIView*)rootView
{
    if (!_rootView) {
        _rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];;
        _rootView.backgroundColor = [UIColor whiteColor];
        self.view = _rootView;
    }
    
    return _rootView;
}

- (UIView*)decorateView
{
    if (!_decorateView) {
        _decorateView = [UIView new];
        [_decorateView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _decorateView.backgroundColor = [UIColor greenColor];
    }
    
    return _decorateView;
}
@end
