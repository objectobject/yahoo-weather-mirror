//
//  SliderViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "SliderViewController.h"
#import <Masonry.h>
#import "UIView+Border.h"
#import "HHXXSetting.h"
#import "HHXXSettingManager.h"
#import "HHXXCityManager.h"
#import "HHXXCity+Transform.h"
#import "HHXXEditCityViewController.h"
#import "LeftSliderHead.h"
#import "HHXXCityManager+Transform.h"
#import "UIImage+Processing.h"
#import "HHXXViewControllerContainer.h"



static NSString* const kHHXXTableViewCellId = @"kHHXXTableViewCellId";

#define HHXXCellDefaultBackground [UIColor colorWithRed:39.0 / 255 green:38.0 / 255 blue:38.0 / 255 alpha:1]
static const CGFloat kHHXXDefaultMargin = 0.0f;
static const CGFloat kHHXXDefaultHeight = 32.0f;
static const CGFloat kHHXXDefaultBottomMargin = 8.0f;


typedef NS_ENUM(NSUInteger, HHXXSectionType) {
    HHXXSectionEdit = 0,
    HHXXSectionCity = 1,
    HHXXSectionSetting = 2
};

@interface SliderViewController ()<HHXXRefreshDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL isExpaned;

@property (nonatomic, copy) NSArray* settingDataSource;
@property (nonatomic, strong) NSArray* cityDataSource;
@end

@implementation SliderViewController


#pragma mark - setter and getter function
- (NSArray *)cityDataSource
{
    return [[HHXXCityManager sharedCityManager] hhxxAllCityToSetings:self.isExpaned];
}

- (NSArray *)settingDataSource
{
    if (!_settingDataSource) {
        _settingDataSource = [HHXXSettingManager hhxxApplicationSettings];
    }
    
    return [_settingDataSource copy];
}

- (UITableView*)tableView
{
    if (_tableView == nil)
    {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = HHXXCellDefaultBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHHXXTableViewCellId];
        
        _tableView.tableFooterView = ({
            
            //NOTE: !!!UITableView的FooterView中高度能显示里面的Button不然Button事件就无法响应了.
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  _tableView.bounds.size.width, 48 + 24)];
            
            UIImageView* yahooLogo = [UIImageView new];
            yahooLogo.image = [UIImage imageNamed:@"yahoo_logo"];
            yahooLogo.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview:yahooLogo];
            
            UIButton* termName = [UIButton new];
            [termName setTitle:@"About Yahoo!" forState:UIControlStateNormal];
            [termName addTarget:self action:@selector(_hhxxTouchAboutYahoo:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:termName];
            
            
            yahooLogo.translatesAutoresizingMaskIntoConstraints = NO;
            termName.translatesAutoresizingMaskIntoConstraints = NO;
            [yahooLogo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view.mas_centerX).multipliedBy(0.75);
                make.height.equalTo(@48);
                make.top.equalTo(view);
            }];
            [termName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(yahooLogo.mas_bottom).offset(kHHXXDefaultMargin);
                make.centerX.equalTo(view.mas_centerX).multipliedBy(0.75);
                make.height.equalTo(@24);
                make.bottom.equalTo(view).priorityHigh();
            }];
            view;
        });
    }
    
    return _tableView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:HHXXCellDefaultBackground];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(self.view);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.66);
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)hhxxRefreshView
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRowsInSection = 0;
    if (section == HHXXSectionEdit) {
        numberOfRowsInSection = [self.settingDataSource[0] count];
    }
    
    if (section == HHXXSectionSetting) {
        numberOfRowsInSection = [self.settingDataSource[1] count];
    }

    if (section == HHXXSectionCity) {
        numberOfRowsInSection = [self.cityDataSource count];
    }
    return numberOfRowsInSection;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kHHXXTableViewCellId];
    cell.accessoryView = nil;
    
    HHXXSetting* item = nil;
    if (indexPath.section == HHXXSectionSetting) {
        item = self.settingDataSource[1][indexPath.row];
    }
    if(indexPath.section == HHXXSectionEdit)
    {
        item = self.settingDataSource[0][indexPath.row];
    }
    if (indexPath.section == HHXXSectionCity) {
        item = self.cityDataSource[indexPath.row];
        
        if (item.type == ModelSettingShowFewer || item.type == ModelSettingLoadMore) {
            cell.accessoryView = ({
                UIImageView* decorateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kHHXXDefaultHeight, kHHXXDefaultHeight)];
                if (item.type == ModelSettingLoadMore) {
                    decorateView.image = [[UIImage imageNamed:@"icon-arrow-up"]  hhxxRotateWithOrientation:UIImageOrientationLeft];
                }
                if (item.type == ModelSettingShowFewer) {
                    decorateView.image = [UIImage imageNamed:@"icon-arrow-up"];
                }
                decorateView;
            });
        }
    }
    
    [cell.textLabel setText:item.title];
    [cell.imageView setImage:[UIImage imageNamed:item.imageName]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setBackgroundColor:HHXXCellDefaultBackground];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHHXXDefaultHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //最上面故意留一点空间，个人觉得比较好看....
    if (section == HHXXSectionEdit)
    {
        return kHHXXDefaultHeight;
    }
    if (section == HHXXSectionSetting)
    {
        return kHHXXDefaultHeight;
    }
    return 0.0f;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == HHXXSectionCity) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kHHXXDefaultHeight)];
    UILabel * label = [[UILabel alloc] init];
    label.text = section == HHXXSectionSetting? @"工具": @"";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12 weight:8];
    
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(20);
        make.bottom.equalTo(headerView);
    }];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == HHXXSectionCity)
    {
        return kHHXXDefaultBottomMargin;
    }
    return 0;
}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // TODO:左边边距差几个像素
    if (section == HHXXSectionCity)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kHHXXDefaultBottomMargin)];
        [view hhxxAddBorderWithColor:[UIColor colorWithRed:12.0 / 255 green:12 / 255 blue:12 / 255 alpha:0.6] borderWidth:1.0f borderStyle:HHXXBorderStyleTop | HHXXBorderStyleBottom];
        return view;
    }
    
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHXXSetting* currentSetting = nil;
    if (indexPath.section == HHXXSectionSetting) {
        currentSetting = self.settingDataSource[1][indexPath.row];
    }
    if(indexPath.section == HHXXSectionEdit)
    {
        currentSetting = self.settingDataSource[0][indexPath.row];
    }
    if (indexPath.section == HHXXSectionCity) {
        currentSetting = self.cityDataSource[indexPath.row];
    }
    
    UIViewController * newVC = nil;
    switch (currentSetting.type)
    {
        case ModelSettingNormal:
            break;
        case ModelSettingSuggest:
            break;
        case ModelSettingPosition:
        {
            if ([self.parentViewController isKindOfClass:[HHXXViewControllerContainer class]]) {
                HHXXViewControllerContainer* fatherVC = (HHXXViewControllerContainer*)self.parentViewController;
                fatherVC.selectedIndex = indexPath.row;
            }
        }
            break;
        case ModelSettingAppleShop:
        {
            //            [NSURL hhxx_toAppStoreWithAppID:@"application id"];
            return;
        }
            break;
        case ModelSettingShare:
            newVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"从yahoo_wather_mirror发送，下载应用请到zhangzheyang.today"] applicationActivities:nil];
            break;
        case ModelSettingAddPosition:
        {
            HHXXEditCityViewController* editCityVC = [HHXXEditCityViewController new];
            editCityVC.refreshDelegate = self;
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:editCityVC] animated:YES completion:nil];
        }
            break;
            
        case ModelSettingLoadMore:
        {
            self.isExpaned = YES;
            [self.tableView reloadData];
            break;
        }
        case ModelSettingShowFewer:
        {
            self.isExpaned = NO;
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
    
    newVC? [self presentViewController:newVC animated:YES completion:^{
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    }]: nil;
}


#pragma mark - event function
- (UIAlertController*)alertController
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"About Yahoo!" message:@"..." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"😍特别鸣谢😍" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    UIAlertAction* etcAction = [UIAlertAction actionWithTitle:@"😤说明😤" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                      }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"😡取消😡" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    
    [alertController setValue:@[defaultAction, etcAction, cancelAction] forKeyPath:@"_actions"];
    
    return alertController;
}


- (void)_hhxxTouchAboutYahoo:(UIButton*)button
{
    [self presentViewController:[self alertController] animated:YES completion:nil];
}


- (void)_hhxxClickedFooterView:(id)sender
{
    NSURL* URL = [NSURL URLWithString:@"http://www.yahoo.com"];
    if ([[URL scheme]isEqualToString:@"http"] || [[URL scheme]isEqualToString:@"https"]) {
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL options:nil completionHandler:nil];
        }
    }
}
@end
