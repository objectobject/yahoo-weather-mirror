//
//  HHXXViewControllerContainer.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXViewControllerContainer.h"
#import "HHXXViewControllerTransitioningContext.h"
//#import <Masonry.h>
#import "HHXXDefaultTransitioningAnimator.h"
#import "UIPanGestureRecognizer+Addition.h"
#import "NSObject+Enumerate.h"
#import "YahooWeatherInformationViewController.h"
#import "HHXXViewControllerContainer+Private.h"
#import "HHXXSliderAnimator.h"

const NSTimeInterval kHHXXDefaultTransitionDuring = 1.0f;
const NSUInteger kHHXXDefaultSwitcherButtonWidth = 32;


//@interface HHXXViewControllerContainer()
//
//@end

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
//    NSNumber* height = @(kHHXXDefaultSwitcherButtonWidth);
//    self.widthConstraintForDecorateView = [NSLayoutConstraint constraintWithItem:self.decorateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:kHHXXDefaultSwitcherButtonWidth * [self.children count]];
//    [self.rootView addConstraint:self.widthConstraintForDecorateView];
//    [self.rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.decorateView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

    
    // TODO:暂时不考虑装饰视图
//    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_decorateView(==height)]" options:0 metrics:NSDictionaryOfVariableBindings(height) views:NSDictionaryOfVariableBindings(_decorateView)]];
//    self.topConstraintForDecorateView = [NSLayoutConstraint constraintWithItem:self.decorateView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeTop multiplier:1.0 constant:22 + [self.topLayoutGuide length]];
//    [self.rootView addConstraint:self.topConstraintForDecorateView];
    
    
//    self.nav.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_nav]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nav)]];
//    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_nav(==64)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nav)]];
}


- (instancetype)init
{
    return [self initWithViewControllers:nil];
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
        [self _hhxxUpdateUI];
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
    _preSelectedViewController = _selectedViewController;
    [self _transitionToViewController:selectedViewController];
    _selectedViewController = selectedViewController;
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
    return [_children mutableCopy];
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

- (void)hhxxAddViewController:(UIViewController*)viewController
{
    if (self.children) {
        [self.children insertObject:viewController atIndex:[self.children count]];
        self.selectedViewController = viewController;
    }
}

- (void)containerSwitchViewController:(UIViewController *)vc1 viewController2:(UIViewController *)vc2
{
}


#pragma mark - private method
- (void)_hhxxUpdateUI
{
//    self.title = [NSString stringWithFormat:@"Title_%ld", self.selectedIndex];
}


- (void)_transitionToViewController:(UIViewController*)toViewController
{
    //    NSLog(@"BEFORE = %ld\r\n", [self.view.subviews count]);
    UIViewController* fromViewController = self.preSelectedViewController;
    if (![self isViewLoaded] || toViewController == nil || fromViewController == toViewController) {
        return;
    }
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    if(!fromViewController)
    {
        [self.rootView addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        
        [fromViewController removeFromParentViewController];
        [self _hhxxUpdateUI];
        return;
    }
    
    
    self.animator = [[HHXXDefaultTransitioningAnimator alloc] initWithDiection:self.directionForAnimation];
    
    if (!self.withInteractive && [self.hhxxTransitioningDelegate respondsToSelector:@selector(hhxxContainerViewController:fromViewController:toViewController:)]) {
        self.animator = [self.hhxxTransitioningDelegate hhxxContainerViewController:self fromViewController:fromViewController toViewController:toViewController];
    }
    
    // 交互式转场
    if (self.withInteractive && [self.hhxxTransitioningDelegate respondsToSelector:@selector(hhxxInteractiveContainerViewController:fromViewController:toViewController:)]) {
        self.animator = [self.hhxxTransitioningDelegate hhxxInteractiveContainerViewController:self fromViewController:fromViewController toViewController:toViewController];
    }
    
    id<UIViewControllerContextTransitioning> transitioningContext = ({
        HHXXViewControllerTransitioningContext* context = [[HHXXViewControllerTransitioningContext alloc] initWithFromViewController:fromViewController toViewController:toViewController];
        __weak typeof(context) weakContext = context;
        context.isInteractive = self.withInteractive;
        context.completeBlock = ^(BOOL didComplete){
            // 取消转场动画逻辑
            if ([weakContext transitionWasCancelled]) {
                _selectedViewController = self.preSelectedViewController;
            }
            else
            {
                [self.rootView addSubview:toViewController.view];
                [toViewController didMoveToParentViewController:self];
                
                [fromViewController.view removeFromSuperview];
                [fromViewController removeFromParentViewController];
            }
            
            if ([self.animator respondsToSelector:@selector(animationEnded:)]) {
                [self.animator animationEnded:didComplete];
            }
            
            self.withInteractive = NO;
            [self _hhxxUpdateUI];
        };
        context;
    });
    

    if(self.withInteractive)
    {
        [self.animator startInteractiveTransition:transitioningContext];
    }
    else
    {
        [self.animator animateTransition:transitioningContext];
    }
}


- (void)_hideLeftSliderViewController:(UIViewController*)oldSliderViewController
{
    if (!oldSliderViewController) {
        return;
    }
    
    [oldSliderViewController willMoveToParentViewController:nil];
    [self addChildViewController:self.selectedViewController];
    [self.rootView addSubview:self.selectedViewController.view];
    [self.selectedViewController didMoveToParentViewController:self];
    
    self.animator = [[HHXXSliderAnimator alloc] initWithDismiss:YES];
    id<UIViewControllerContextTransitioning> transitioningContext = ({
        HHXXViewControllerTransitioningContext* context = [[HHXXViewControllerTransitioningContext alloc] initWithFromViewController:oldSliderViewController toViewController:self.selectedViewController];
        
        context.isInteractive = NO;
        context.completeBlock = ^(BOOL didComplete){
            [oldSliderViewController.view removeFromSuperview];
            [oldSliderViewController removeFromParentViewController];
            
            [self.rootView addGestureRecognizer:self.panGestureRecognizer];
            
            if ([self.animator respondsToSelector:@selector(animationEnded:)]) {
                [self.animator animationEnded:didComplete];
            }
        };
        context;
    });
    [self.animator animateTransition:transitioningContext];
}

- (void)_showLeftSliderViewController:(UIViewController*)newSliderViewController
{
    if (!newSliderViewController) {
        return;
    }
    
    [self.selectedViewController willMoveToParentViewController:nil];
    [self addChildViewController:newSliderViewController];
    
    self.animator = [HHXXSliderAnimator new];
    id<UIViewControllerContextTransitioning> transitioningContext = ({
        HHXXViewControllerTransitioningContext* context = [[HHXXViewControllerTransitioningContext alloc] initWithFromViewController:self.selectedViewController toViewController:newSliderViewController];
        
        [self.rootView addSubview:newSliderViewController.view];
        [newSliderViewController didMoveToParentViewController:self];
        [self.selectedViewController.view removeFromSuperview];
        [self.selectedViewController removeFromParentViewController];
        
        context.isInteractive = NO;
        context.completeBlock = ^(BOOL didComplete){
            
            [self.selectedViewController.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxTapWhenLeftExpend:)]];
            [self.rootView removeGestureRecognizer:self.panGestureRecognizer];
            
            if ([self.animator respondsToSelector:@selector(animationEnded:)]) {
                [self.animator animationEnded:didComplete];
            }
        };
        context;
    });
    [self.animator animateTransition:transitioningContext];
}


- (void)_hhxxTapWhenLeftExpend:(id)sender
{
    self.leftSliderViewController = nil;
}

- (void)_hhxxInitView
{
    self.navigationItem.rightBarButtonItems = @[
                                                ({
                                                    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStyleDone target:self action:@selector(_switcher:)];
                                                    item.tag = HHXXViewControllerContainerActionToRight;
                                                    item;
                                                }),
                                                
                                                ({
                                                    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStyleDone target:self action:@selector(_switcher:)];
                                                    item.tag = HHXXViewControllerContainerActionToLeft;
                                                    item;
                                                }),
                                                ({
                                                    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(_switcher:)];
                                                    item.tag = HHXXViewControllerContainerActionAddVC;
                                                    item;
                                                }),
                                                ({
                                                    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStyleDone target:self action:@selector(_switcher:)];
                                                    item.tag = HHXXViewControllerContainerActionRemoveVC;
                                                    item;
                                                })
                                                ];
    
    [self.rootView addSubview:self.decorateView];
    [self.rootView addGestureRecognizer:self.panGestureRecognizer];
    
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
}


- (void)_switcher:(id)sender
{
    UIBarButtonItem* item = (UIBarButtonItem*)sender;
    
    NSInteger index = self.selectedIndex;
    
    
    switch (item.tag) {
        case HHXXViewControllerContainerActionToLeft:
            index += 1;
            break;
            
        case HHXXViewControllerContainerActionToRight:
            index -= 1;
            break;
            
        case HHXXViewControllerContainerActionAddVC:
        {
            [self hhxxAddViewController:[YahooWeatherInformationViewController new]];
        }
            break;
            
        case HHXXViewControllerContainerActionRemoveVC:
            break;
            
        default:
            break;
    }
    
    if (index <= 0) {
        index = 0;
    }
    if (index >= [self.children count]) {
        index -= 1;
    }
    self.directionForAnimation = item.tag > 0 ? ToRight: ToLeft;
    self.selectedViewController = [self.children objectAtIndex:index % [self.children count]];
}


- (void)_hhxxPanGesture:(UIPanGestureRecognizer*)gestureRecognizer
{
    NSInteger selectedIndex = [self.children indexOfObject:self.selectedViewController];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.withInteractive = true;
            self.view.layer.speed = 0;
            HHXXDirection panDirection = [gestureRecognizer velocityInView:self.view].x > 0? ToRight: ToLeft;
            if (panDirection == ToRight) {
                selectedIndex -= 1;
                self.directionForAnimation = ToRight;
            }
            if (panDirection == ToLeft) {
                selectedIndex += 1;
                self.directionForAnimation = ToLeft;
            }
            if (selectedIndex <= 0) {
                selectedIndex = 0;
            }
            if (selectedIndex >= [self.children count]) {
                selectedIndex -= 1;
            }
            self.selectedViewController = [self.children objectAtIndex:selectedIndex];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percentValue = fabs([gestureRecognizer translationInView:self.view].x) / self.view.bounds.size.width;
            [self.animator updateInteractiveTransition:percentValue];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        UIGestureRecognizerStateRecognized:
        {
            if (fabs([gestureRecognizer translationInView:self.view].x) - self.view.bounds.size.width * 0.5 > 0)
            {
                [self.animator finishInteractiveTransition];
            }
            else
            {
                [self.animator cancelInteractiveTransition];
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        UIGestureRecognizerStateFailed:
        {
            [self.animator cancelInteractiveTransition];
        }
            break;
            
        case UIGestureRecognizerStatePossible:
            break;
            
        default:
            self.xDistance = 0;
            break;
    }
}

#pragma mark - setter and getter
- (UIPanGestureRecognizer*)panGestureRecognizer
{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxPanGesture:)];
    }
    
    return _panGestureRecognizer;
}

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
        
        //TODO暂时不考虑这个装饰视图
        _decorateView.backgroundColor = [UIColor clearColor];
        _decorateView.hidden = YES;
//        [_decorateView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        _decorateView.backgroundColor = [UIColor greenColor];
    }
    
    return _decorateView;
}

- (void)setLeftSliderViewController:(UIViewController *)leftSliderViewController
{
    if (leftSliderViewController) {
        [self _showLeftSliderViewController:leftSliderViewController];
    }else{
        [self _hideLeftSliderViewController:_leftSliderViewController];
    }
    _leftSliderViewController = leftSliderViewController;
}
@end
