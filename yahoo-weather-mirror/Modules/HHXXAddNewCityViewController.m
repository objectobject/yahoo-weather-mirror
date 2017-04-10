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

@interface HHXXAddNewCityViewController ()<UISearchResultsUpdating, UISearchBarDelegate, NSXMLParserDelegate, HHXXNetworkingDelegate, HHXXNetworkingDataSource>
@property (nonatomic, strong) UISearchController* searchViewController;
@property (nonatomic, copy) NSMutableArray* searchArray;
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
        _YQLApi.responseDataType = HHXXResponseData;
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
    [self.searchArray addObject:@"查不到结果!"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)hhxxCallApiSuccess:(HHXXAbstractApiManager *)mgr
{
    NSData* data = [mgr hhxxFetchDataWithFiltrator:nil];
    
    self.parse = [[NSXMLParser alloc] initWithData:data];
    self.parse.delegate = self;
    [self.parse parse];
    [self.searchViewController.searchBar resignFirstResponder];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [[NSMutableArray alloc] init];
    }
    
    return _searchArray;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"s"]) {
        NSString* value = [attributeDict objectForKey:@"d"];
        if (value)
        {
            NSArray* parseValue = [value componentsSeparatedByString:@":"];
            if ([parseValue count] >= 2) {
                HHXXCity* newCity = [HHXXCity new];
                id cityInfoList = [parseValue[1] componentsSeparatedByString:@"&"];
                
                for (NSString* city in cityInfoList) {
                    NSLog(@"cityinfolist %@", cityInfoList);
                    NSArray* cityInfo = [city componentsSeparatedByString:@"="];
                    NSLog(@"cityInfo %@", cityInfo);
                    if ([cityInfo[0] isEqualToString:@"woeid"]) {
                        newCity.woeid = (NSString*)cityInfo[1];
                        continue;
                    }
                    if ([cityInfo[0] isEqualToString:@"n"]) {
                        newCity.cnCityName = cityInfo[1];
                        continue;
                    }
                }
                [self.searchArray addObject:newCity];
            }
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([weakSelf.searchArray count] <= 0)
        {
            [weakSelf.searchArray addObject:@"查不到结果!"];
        }
        
        [weakSelf.tableView reloadData];
    });
}


- (UISearchController*)searchViewController
{
    if (_searchViewController == nil) {
        
        _searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchViewController.searchResultsUpdater = self;
        _searchViewController.dimsBackgroundDuringPresentation = false;
        [_searchViewController.searchBar sizeToFit];
        _searchViewController.searchBar.placeholder = @"输入城市名";
        _searchViewController.searchBar.delegate = self;
        self.tableView.tableHeaderView = self.searchViewController.searchBar;
        
        UITextField* searchTextField = [_searchViewController.searchBar valueForKey:@"searchField"];
        [searchTextField setTextColor:[UIColor whiteColor]];
    }
    
    return _searchViewController;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchArray removeAllObjects];
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
    
    id data = [self.searchArray objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[NSString class]]) {
        [cell.textLabel setText:data];
    }
    else
    {
        [cell.textLabel setText: ((HHXXCity*)data).cnCityName];
    }
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self.searchArray objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[NSString class]]) {
        return;
    }
    else
    {
        HHXXCity* newCity = (HHXXCity*)data;
        [[HHXXCityManager sharedCityManager] addCity:({
            HHXXCity* city = [HHXXCity new];
            city.cnCityName = newCity.cnCityName;
            city.woeid = newCity.woeid;
            city.isLocation = newCity.isLocation;
            city;
        })];
        
        [self dismissViewControllerAnimated:YES completion:nil];
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
    return [self.searchArray count];
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

