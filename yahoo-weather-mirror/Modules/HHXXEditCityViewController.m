//
//  HHXXEditCityViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXEditCityViewController.h"
#import <Masonry.h>
#import "HHXXCityManager.h"
#import "HHXXCity.h"
#import "TableViewCellForPosition.h"
#import "HHXXAddNewCityViewController.h"

@interface HHXXEditCityViewController ()

@end

#define HHXXCellDefaultBackground [UIColor colorWithRed:39.0 / 255 green:38.0 / 255 blue:38.0 / 255 alpha:1]

@interface HHXXEditCityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* cityTableView;

@property (nonatomic, strong) NSArray* cityDataSources;
@end

@implementation HHXXEditCityViewController

- (NSArray *)cityDataSources
{
    if (!_cityDataSources) {
        _cityDataSources = [HHXXCityManager sharedCityManager].allCitys;
    }
    
    return _cityDataSources;
}

- (UITableView*)cityTableView
{
    if (_cityTableView == nil)
    {
        _cityTableView = [UITableView new];
        _cityTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _cityTableView.tableFooterView = [UIView new];
        _cityTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _cityTableView.separatorColor = [UIColor blackColor];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.backgroundColor = HHXXCellDefaultBackground;
        _cityTableView.showsVerticalScrollIndicator = NO;
        [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_cityTableView registerNib:[UINib nibWithNibName:@"TableViewCellForPosition" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableViewCellForPosition"];
    }
    
    return _cityTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cityDataSources count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHXXCity* city = [self.cityDataSources objectAtIndex:indexPath.row];
    UITableViewCell* cell = nil;
    if (city.isLocation) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellForPosition" forIndexPath:indexPath];
        [((TableViewCellForPosition*)cell).positionName setText:kHHXXCurrentCity];
        [cell setBackgroundColor:HHXXCellDefaultBackground];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        [cell.textLabel setText:city.cnCityName];
        [cell setBackgroundColor:HHXXCellDefaultBackground];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        for (UIView* view in cell.subviews)
        {
            if ([view isKindOfClass:NSClassFromString(@"UITableViewCellReorderControl")])
            {
                for (UIView* imageView in view.subviews)
                {
                    if ([imageView isKindOfClass:[UIImageView class]]) {
                        [(UIImageView*)imageView setImage:[UIImage imageNamed:@"touch-cell"]];
                        [(UIImageView*)imageView setContentMode:UIViewContentModeScaleAspectFill];
                    }
                }
            }
        }
    }
    
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_hhxxBackToPreVC:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_hhxxAddNewCity:)];
    self.title = @"地点";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.view.backgroundColor = HHXXCellDefaultBackground;
    [self.view addSubview:self.cityTableView];
    [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.cityTableView setEditing:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHXXCity* city = [self.cityDataSources objectAtIndex:indexPath.row];
    if (city.isLocation) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHXXCity* city = [self.cityDataSources objectAtIndex:indexPath.row];
    return !city.isLocation;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[HHXXCityManager sharedCityManager] switchCityWithIndex:sourceIndexPath.row index2:destinationIndexPath.row];
}

#pragma mark - private method
- (void)_hhxxAddNewCity:(id)sender
{
    [self presentViewController:[HHXXAddNewCityViewController new] animated:YES completion:nil];
}


- (void)_hhxxBackToPreVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
