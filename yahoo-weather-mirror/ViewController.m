//
//  ViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/20.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "UIColor+HHXXProvider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)test:(id)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"这是测试" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor hhxxRandomColor];
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor hhxxRandomColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.width.equalTo(@100);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
