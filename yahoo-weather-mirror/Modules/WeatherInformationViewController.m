//
//  WeatherInformationViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/24.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "WeatherInformationViewController.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "YahooWeatherInformationView.h"

const NSUInteger kHHXXNumberOfTab = 3;

@interface WeatherInformationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView* mainView;

@property (nonatomic, strong) UITableView* preView;
@property (nonatomic, strong) UITableView* currentView;
@property (nonatomic, strong) UITableView* nextView;
@property (nonatomic, strong) UIView* containerView;
@end

@implementation WeatherInformationViewController


#pragma mark - setter and getter

- (UIView*)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.backgroundColor = [UIColor redColor];
    }
    
    return _containerView;
}

- (UIScrollView*)mainView
{
    if (!_mainView)
    {
        _mainView = [[UIScrollView alloc] initWithFrame:HHXX_MAIN_SCREEN];
//        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainView.backgroundColor = [UIColor greenColor];
        _mainView.contentSize = CGSizeMake(HHXX_MAIN_SCREEN_WIDTH * kHHXXNumberOfTab, HHXX_MAIN_SCREEN_HEIGHT);
        _mainView.showsHorizontalScrollIndicator = YES;
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.userInteractionEnabled = YES;
        _mainView.scrollEnabled = YES;
        _mainView.bounces = YES;
        _mainView.pagingEnabled = YES;
    }
    
    return _mainView;
}


- (UITableView*)preView
{
    if (!_preView)
    {
        _preView = [UITableView new];
        _preView.translatesAutoresizingMaskIntoConstraints = NO;
        _preView.backgroundColor = [UIColor redColor];
//        _preView.delegate = self;
//        _preView.dataSource = self;
    }
    
    return _preView;
}

- (UITableView*)currentView
{
    if (!_currentView)
    {
        _currentView = [UITableView new];
        _currentView.translatesAutoresizingMaskIntoConstraints = NO;
        _currentView.backgroundColor = [UIColor orangeColor];
//        _currentView.delegate = self;
//        _currentView.dataSource = self;
    }
    
    return _currentView;
}

- (UITableView*)nextView
{
    if (!_nextView)
    {
        _nextView = [UITableView new];
        _nextView.translatesAutoresizingMaskIntoConstraints = NO;
        _nextView.backgroundColor = [UIColor yellowColor];
//        _nextView.delegate = self;
//        _nextView.dataSource = self;
    }
    
    return _nextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:({
        UIButton* btn = [UIButton new];
        btn.layer.cornerRadius = 50.0f;
        [btn setTitle:@"1" forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 5.0f;
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(100, 100, 100, 100);
        btn.titleLabel.textColor = [UIColor clearColor];
        btn;
    })];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
