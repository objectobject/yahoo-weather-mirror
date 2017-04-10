//
//  HHXXCustionNavigationView.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXCustionNavigationView.h"
#import <Masonry.h>

const CGFloat kHHXXNavHeight = 64;

@implementation HHXXCustionNavigationView

- (void)hhxx_createLayoutConstraints
{
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(12);
        make.height.mas_equalTo(kHHXXNavHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.height.mas_equalTo(kHHXXNavHeight);
        make.centerX.equalTo(self);
        make.left.equalTo(self.leftButton.mas_right).offset(8).priority(100);
        make.right.equalTo(self.rightButton.mas_left).offset(-8).priority(100);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-12);
        make.height.mas_equalTo(kHHXXNavHeight);
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _gradientLayer.frame = CGRectMake(-8, -1, [UIScreen mainScreen].bounds.size.width + 16, 96);
}


#pragma mark - getter and setter
- (CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil)
    {
        _gradientLayer = [CAGradientLayer new];
        _gradientLayer.colors = @[
                                  (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor,
                                  (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,
                                  (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor];
        _gradientLayer.locations = @[@0.0, @(64/96), @1];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
    }
    
    return _gradientLayer;
}

- (UIButton*)leftButton
{
    if (_leftButton == nil)
    {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _leftButton;
}


- (UIButton*)rightButton
{
    if (_rightButton == nil)
    {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setImage:[UIImage imageNamed:@"plus_icon"] forState:UIControlStateNormal];
        _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _rightButton;
}

- (UILabel*)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}


/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    
    
    [self.layer addSublayer:self.gradientLayer];
    [@[self.leftButton, self.titleLabel, self.rightButton] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    //if view based frame, noted
    //    [self updateConstraintsIfNeeded];
    //    [self setNeedsUpdateConstraints];
}


#pragma mark - init function
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    //如果自定义视图从xib,sb创建的,可以在这里放置一个异常或者断言
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
