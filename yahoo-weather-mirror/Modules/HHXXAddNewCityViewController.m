//
//  HHXXAddNewCityViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXAddNewCityViewController.h"
#import <Masonry.h>
#import "HHXXCity.h"
#import "HHXXCityManager.h"
#import "HHXXYQLApiManager.h"
#import <MBProgressHUD.h>
#import "ModelPlaceManager.h"
#import <NSObject+YYModel.h>
#import "ModelPlace.h"
#import "LeftSliderHead.h"

@interface HHXXAddNewCityViewController ()<UISearchResultsUpdating, UISearchBarDelegate, NSXMLParserDelegate, HHXXNetworkingDelegate, HHXXNetworkingDataSource>
@property (nonatomic, strong) UISearchController* searchViewController;
@property (nonatomic, strong) NSMutableArray* searchResult;
@property (nonatomic, strong) NSXMLParser* parse;
@property (nonatomic, strong) NSString* parserElmentName;

@property (nonatomic, strong) HHXXYQLApiManager* YQLApi;
@end

@implementation HHXXAddNewCityViewController

- (HHXXYQLApiManager *)YQLApi
{
    if (!_YQLApi) {
        _YQLApi = [[HHXXYQLApiManager alloc] init];
        _YQLApi.delegate = self;
        _YQLApi.dataSource = self;
//        _YQLApi.responseDataType = HHXXResponseData;
    }
    
    return _YQLApi;
}

- (NSDictionary *)hhxxRequestParamsForApi:(HHXXAbstractApiManager *)mgr
{
    //    HHXXCityManager* cm = [HHXXCityManager sharedCityManager];
    NSString* queryString = [HHXXYQLApiManager hhxxGetCityInformationByKeyWord:self.searchViewController.searchBar.text];
    return @{
             @"q": queryString,
             @"format": @"json",
             @"u":@"c",
             };
}

- (void)hhxxCallApiFailed:(HHXXAbstractApiManager *)mgr
{
    [self.searchViewController.searchBar resignFirstResponder];
    [self.searchResult addObject:@"查不到结果!"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)hhxxCallApiSuccess:(HHXXAbstractApiManager *)mgr
{
    [self.searchViewController.searchBar resignFirstResponder];
    id data = [mgr hhxxFetchDataWithFiltrator:nil];
    
    if ([mgr isKindOfClass:[HHXXYQLApiManager class]]) {
        NSInteger countOfResult = [[data valueForKeyPath:@"query.count"] integerValue];
        if (countOfResult == 1) {
            ModelPlaceManagerWithOnePlace* placeMgr = [ModelPlaceManagerWithOnePlace yy_modelWithDictionary:data];
            [self.searchResult addObject:placeMgr.place];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            return;
        }
        ModelPlaceManager* placeMgr = [ModelPlaceManager yy_modelWithDictionary:data];
        
        if (!placeMgr.count) {
            [self.searchResult addObject:@"查不到结果!"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            self.searchResult = [placeMgr.place mutableCopy];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (NSMutableArray *)searchResult
{
    if (!_searchResult) {
        _searchResult = [[NSMutableArray alloc] init];
    }
    
    return _searchResult;
}

- (UISearchController*)searchViewController
{
    if (_searchViewController == nil) {
        
        _searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchViewController.searchResultsUpdater = self;
        _searchViewController.dimsBackgroundDuringPresentation = YES;
        [_searchViewController.searchBar sizeToFit];
        _searchViewController.searchBar.placeholder = @"输入城市名";
        _searchViewController.searchBar.delegate = self;
        _searchViewController.searchBar.showsCancelButton = YES;
        self.tableView.tableHeaderView = self.searchViewController.searchBar;
        
        UITextField* searchTextField = [_searchViewController.searchBar valueForKey:@"searchField"];
        [searchTextField setTextColor:[UIColor blackColor]];
    }
    
    return _searchViewController;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchResult = [NSMutableArray array];
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return YES;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.tableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.YQLApi hhxxFetchData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.searchViewController.searchBar becomeFirstResponder];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    id data = [self.searchResult objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[NSString class]]) {
        [cell.textLabel setText:data];
    }
    else
    {
        [cell.textLabel setText: [NSString stringWithFormat:@"%@", (ModelPlace*)data]];
    }
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchViewController.active) {
        return;
    }
    id data = [self.searchResult objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[NSString class]]) {
        return;
    }
    else
    {
        ModelPlace* place = (ModelPlace*)data;
        [[HHXXCityManager sharedCityManager] addCity:({
            HHXXCity* city = [HHXXCity new];
            city.cnCityName = NSLocalizedString(place.name, nil);
            city.enCityName = place.name;
            city.woeid = place.woeid;
            city.isLocation = NO;
            city;
        })];
        
        self.refreshDelegate? [self.refreshDelegate hhxxRefreshView] : nil;
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.fromType == HHXXFromViewControllerHome) {
                // 调整到新的视图控制器
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResult count];
}


/*YQL参考资料
 
 
 dispatch_async(dispatch_queue_create([@"com.adfsdaf" UTF8String],  DISPATCH_QUEUE_CONCURRENT), ^{
 YQL* yql = [[YQL alloc] init];
 NSString* queryString  = nil;
 //查询地区的例子
 queryString = @"select * from geo.places where text=\"厦门\"";
 queryString = @"select * from geo.places where text=\"ShangHai\"";
 
 
 //通过经纬度查询不了
 queryString = @"select * from geo.places where text=\"39.9919336,116.3404132\"";
 
 
 // 查询天气的例子(从前面获取城市的whoeid)
 queryString = @"select * from weather.forecast where woeid=2502265";
 
 //        // 查询更具体的天气(风)
 //        queryString = @"select wind from weather.forecast where woeid=2502265";
 //
 //        // 当前天气状况
 //        queryString = @"select item.condition from weather.forecast where woeid=2502265";
 //
 //        // 日落信息
 //        queryString = @"select astronomy.sunset from weather.forecast where woeid=2502265";
 //
 //        //and geo_context=2
 //        queryString = @"select * from flickr.photos.search where text=\"厦门\" and api_key=\"64aa3162f147c64879f0796f1cfbdc7a\" and has_geo=\"true\"";
 
 // 图片信息格式
 //        {
 //            farm = 8;
 //            id = 28974031592;
 //            isfamily = 0;
 //            isfriend = 0;
 //            ispublic = 1;
 //            owner = "143750153@N08";
 //            secret = 31aa1b1e35;
 //            server = 7730;
 //            title = "SummerGo\U53a6\U95e8";
 //        }https://farm8/staticflickr.com/7730/28974031592_31aa1b1e35.jpg
 
 
 // 拼装图片URL格式的方法为:https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
 // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{mstzb}.jpg
 
 
 //        queryString = @"select* from select * from flickr.people.getInfo where user_id=\"143750153@N08\"";
 //        NSDictionary* result = [yql query:queryString];
 //        NSDictionary* result = [yql query:queryString ];
 });
 
 */

@end

