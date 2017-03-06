//
//  ViewController.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/20.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "UIColor+Provider.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer* colorLayer;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"这是测试" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* view = [[UIButton alloc] init];
    view.backgroundColor = [UIColor hhxxRandomColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.width.equalTo(@100);
    }];
    [view addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view.layer addSublayer:self.colorLayer];
    
    self.colorLayer.frame = CGRectMake(200, 400, 100, 100);
    
    self.view.backgroundColor = [UIColor hhxxRandomColor];
}


- (void)test:(id)sender
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:4.0f];
    
    __weak typeof (self) weakSel = self;
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        weakSel.colorLayer.affineTransform = transform;
    }];
    self.colorLayer.backgroundColor = [UIColor hhxxRandomColor].CGColor;
    [CATransaction commit];
}

- (CALayer*)colorLayer
{
    if (!_colorLayer) {
        _colorLayer = [CALayer layer];
        _colorLayer.backgroundColor = [UIColor redColor].CGColor;
        _colorLayer.delegate = self;
    }
    
    return _colorLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
