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
#import <UIImageView+LBBlurredImage.h>
#import "HHXXYQLApiManager.h"
#import "HHXXBingImageApiManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModelWeatherForecast.h"
#import <YYModel.h>
#import <NSObject+YYModel.h>
#import "HHXXCustionNavigationView.h"
#import "SliderViewController.h"
#import "HHXXCityManager.h"
#import "HHXXAddNewCityViewController.h"


const NSUInteger numberOfWeatherInformation = 7;

@interface YahooWeatherInformationViewController ()<UITableViewDelegate, UITableViewDataSource, HHXXNetworkingDelegate, HHXXNetworkingDataSource>
@property (nonatomic, strong) UITableView* mainView;
@property (nonatomic, strong) UIImageView* backgroundView;
@property (nonatomic, strong) UIImageView* maskView;
@property (nonatomic, strong) YahooWeatherInformationView* yahooWeatherHeadView;

@property (nonatomic, strong) NSMutableArray<Class>* cellTypes;
@property (nonatomic, strong) HHXXYQLApiManager* yqlApi;
@property (nonatomic, strong) HHXXBingImageApiManager* bingApi;
@property (nonatomic, strong) NSString* queryKw;
@property (nonatomic, strong) ModelWeatherForecast* weatherForecastInformation;

@property (nonatomic, strong) HHXXCustionNavigationView* nav;
@end

@implementation YahooWeatherInformationViewController

#pragma mark - private method


- (void)_hhxxAddNewCity:(id)sender
{
    [self presentViewController:({
        HHXXAddNewCityViewController* addNewCity = [HHXXAddNewCityViewController new];
        addNewCity.fromType = HHXXFromViewControllerLeftSlider;
        addNewCity;
    }) animated:YES completion:nil];
}

- (void)_hhxxShowSliderViewController:(id)sender
{
    [self presentViewController:[SliderViewController new] animated:YES completion:nil];
}


# pragma mark - delegate and datasource
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
    
    if(self.weatherForecastInformation)
    {
        [cell configureWithModel:[self.weatherForecastInformation hhxxWeatherFiltrator:^(Class cls){
            if (cls == [TableViewCellForAd class]) {
                return HHXXWeatherForecastTypeAd;
            }
            if (cls == [TableViewCellForMap class]) {
                return HHXXWeatherForecastTypeMap;
            }
            if (cls == [TableViewCellForSpeed class]) {
                return HHXXWeatherForecastTypeWind;
            }
            if (cls == [TableViewCellForDetail class]) {
                return HHXXWeatherForecastTypeDetail;
            }
            if (cls == [TableViewCellForSunMoon class]) {
                return HHXXWeatherForecastTypeSunAndMoon;
            }
            if (cls == [TableViewCellForRainFall class]) {
                return HHXXWeatherForecastTypeRainfall;
            }
            if (cls == [TableViewCellForWeekDaily class]) {
                return HHXXWeatherForecastTypeForecast;
            }
            
            return HHXXWeatherForecastTypeNone;
        }(cellType)]];
    }
    return cell;
}


- (void)_hhxxInitChildView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //防止上面出现空白UISCrollView
//    [self.view addSubview:[UIView new]];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.nav];
    
    [self.nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.view.layer.borderColor = [UIColor blackColor].CGColor;
    self.view.layer.borderWidth = 2.0f;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _hhxxInitChildView];
    
    [self.nav.titleLabel setText:@"这是标题"];
    
    [self.nav.leftButton addTarget:self action:@selector(_hhxxShowSliderViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.rightButton addTarget:self action:@selector(_hhxxAddNewCity:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.yqlApi hhxxFetchData];
    [self.bingApi hhxxFetchData];
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


#pragma mark - about fetch data from networking

- (HHXXBingImageApiManager*)bingApi
{
    if (!_bingApi) {
        _bingApi = [[HHXXBingImageApiManager alloc] init];
        _bingApi.delegate = self;
        _bingApi.dataSource = self;
    }
    
    return _bingApi;
}

- (HHXXYQLApiManager *)yqlApi
{
    if (!_yqlApi) {
        _yqlApi = [[HHXXYQLApiManager alloc] init];
        _yqlApi.dataSource = self;
        _yqlApi.delegate = self;
    }
    
    return _yqlApi;
}

- (NSDictionary *)hhxxRequestParamsForApi:(HHXXAbstractApiManager *)mgr
{
//    HHXXCityManager* cm = [HHXXCityManager sharedCityManager];
    NSString* queryString = [HHXXYQLApiManager hhxxGetWeatherForecastByWoeid:@"12712963"];
    return @{
             @"q": queryString,
             @"format": @"json",
             @"u":@"c",
             };
}

- (void)hhxxCallApiFailed:(HHXXAbstractApiManager *)mgr
{
    __weak typeof(self) weakSelf = self;
    if ([mgr isKindOfClass:[HHXXBingImageApiManager class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.maskView setImageToBlur:[UIImage imageNamed:@"adContent"] blurRadius:10.0 completionBlock:nil];
            [weakSelf.backgroundView setImage:[UIImage imageNamed:@"adContent"]];
        });
    }
    NSLog(@"网络请求失败!错误信息:\r\n%@", mgr);
}


- (void)hhxxCallApiSuccess:(HHXXAbstractApiManager *)mgr
{
    id requestData = [mgr hhxxFetchDataWithFiltrator:nil];
    
    // 这里设置背景图片
    if ([mgr isKindOfClass:[HHXXBingImageApiManager class]]) {
        NSString* backgroundImageURLString = requestData[@"data"][@"url"];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.maskView sd_setImageWithURL:[NSURL URLWithString:backgroundImageURLString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [_maskView setImageToBlur:image blurRadius:10.0 completionBlock:nil];
            }];
            [weakSelf.backgroundView sd_setImageWithURL:[NSURL URLWithString:backgroundImageURLString]];
        });
    }
    
    // 这里设置数据源
    if ([mgr isKindOfClass:[HHXXYQLApiManager class]]) {
        self.weatherForecastInformation = [ModelWeatherForecast yy_modelWithJSON:requestData];
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.yahooWeatherHeadView configureWithModel:[self.weatherForecastInformation hhxxWeatherFiltrator:HHXXWeatherForecastTypeTodayCondition]];
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
        });
    }
}

#pragma mark - setter and getter
- (HHXXCustionNavigationView *)nav
{
    if(!_nav)
    {
        _nav = [HHXXCustionNavigationView new];
    }
    
    return _nav;
}


- (YahooWeatherInformationView *)yahooWeatherHeadView
{
    if (!_yahooWeatherHeadView) {
        _yahooWeatherHeadView = [[YahooWeatherInformationView alloc] initWithFrame:HHXX_MAIN_SCREEN];
    }
    
    return _yahooWeatherHeadView;
}

- (UIImageView*)maskView
{
    if (!_maskView) {
        _maskView = [[UIImageView alloc] initWithFrame:HHXX_MAIN_SCREEN];
        [_maskView setContentMode:UIViewContentModeScaleAspectFill];
        _maskView.alpha = 0.75f;
        //        [_maskView setImageToBlur:[UIImage imageNamed:@"adContent"] blurRadius:10.0 completionBlock:nil];
    }
    
    return _maskView;
}

- (UIImageView*)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] initWithFrame:HHXX_MAIN_SCREEN];
        //        [_backgroundView setImage:[UIImage imageNamed:@"adContent"]];
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
        _mainView.tableHeaderView = self.yahooWeatherHeadView;
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
        _cellTypes = [@[[TableViewCellForAd class], [TableViewCellForWeekDaily class],
                        [TableViewCellForDetail class], [TableViewCellForMap class],
                        [TableViewCellForSpeed class], [TableViewCellForSunMoon class],
                        [TableViewCellForRainFall class]] mutableCopy];
    }
    return _cellTypes;
}
@end