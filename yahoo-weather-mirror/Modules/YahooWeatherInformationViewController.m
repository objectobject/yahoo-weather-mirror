//
//  YahooWeatherInformationViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "YahooWeatherInformationViewController.h"
#import "Macro.h"
#import <Masonry/Masonry.h>
#import "YahooWeatherInformationView.h"
#import "TableViewCellForAd.h"
#import "TableViewCellForMap.h"
#import "TableViewCellForSpeed.h"
#import "TableViewCellForDetail.h"
#import "TableViewCellForSunMoon.h"
#import "TableViewCellForRainFall.h"
#import "TableViewCellForWeekDaily.h"
#import "UITableViewCell+EnableDrag.h"


const NSUInteger numberOfWeatherInformation = 7;

@interface YahooWeatherInformationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* mainView;
@property (nonatomic, strong) UIImageView* backgroundView;
@property (nonatomic, strong) UIView* maskView;

@property (nonatomic, strong) NSMutableArray<Class>* cellTypes;
@end

@implementation YahooWeatherInformationViewController


- (UIView*)maskView
{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor grayColor];
        _maskView.alpha = 0.9f;
        
    }
    
    return _maskView;
}

- (UIImageView*)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [UIImageView new];
        [_backgroundView setImage:[UIImage imageNamed:@"adContent"]];
        [_backgroundView setContentMode:UIViewContentModeScaleAspectFill];
    }
    
    return _backgroundView;
}


- (UITableView*)mainView
{
    if (!_mainView)
    {
        _mainView = [[UITableView alloc] initWithFrame:HHXX_MAIN_SCREEN style:UITableViewStylePlain];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainView.delegate = self;
        _mainView.dataSource = self;
        _mainView.backgroundColor = [UIColor clearColor];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.estimatedRowHeight = 128;
        _mainView.rowHeight = UITableViewAutomaticDimension;
        _mainView.tableHeaderView = ({
            YahooWeatherInformationView* view = [[YahooWeatherInformationView alloc] initWithFrame:HHXX_MAIN_SCREEN];
            view;
        });
        
        _mainView.tableFooterView = [UIView new];
        
        
        for (Class _cls in self.cellTypes) {
            [_mainView registerClass:_cls forCellReuseIdentifier:NSStringFromClass(_cls)];
        }
    }
    
    return _mainView;
}


- (NSMutableArray<Class> *)cellTypes
{
    if (!_cellTypes) {
        _cellTypes = [@[[TableViewCellForAd class], [TableViewCellForDetail class],
                        [TableViewCellForWeekDaily class], [TableViewCellForMap class],
                        [TableViewCellForSpeed class], [TableViewCellForSunMoon class],
                        [TableViewCellForRainFall class]] mutableCopy];
    }
    return _cellTypes;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellTypes count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellType = [self.cellTypes objectAtIndex:indexPath.row];
    HHXXAutoLayoutTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellType) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.switchDataBlock = ^(NSUInteger fromIndex, NSUInteger toIndex){
        [self.cellTypes exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
    };
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)_hhxxInitChildView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.mainView];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _hhxxInitChildView];
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
