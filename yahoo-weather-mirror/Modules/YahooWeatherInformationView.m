//
//  YahooWeatherInformationView.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "YahooWeatherInformationView.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "UIView+Border.h"
#import "YahooWeatherItemKey.h"

@interface YahooWeatherInformationView()

// 第一行
@property (nonatomic, strong) UIImageView* weatherIcon;
@property (nonatomic, strong) UILabel* wetherInfo;

// 第二行
@property (nonatomic, strong) UIImageView* highTempIcon;
@property (nonatomic, strong) UILabel* highTempInfo;
@property (nonatomic, strong) UIImageView* lowTempIcon;
@property (nonatomic, strong) UILabel* lowTempInfo;

// 第三行
@property (nonatomic, strong) UILabel* tempInfo;

// 版权信息
@property (nonatomic, strong) UILabel* copyrightLabel;


@property (nonatomic, strong) UIView* rowOne, *rowTwo, *rowThree;
@end

@implementation YahooWeatherInformationView


- (void)configureWithModel:(id)model
{
#ifdef DEBUG
    self.wetherInfo.text = @"多云!";
    [self.weatherIcon setImage:[UIImage imageNamed:@"01"]];
    [self.highTempInfo setText:@"99º"];
    [self.lowTempInfo setText:@"8º"];
    [self.tempInfo setText:@"88º"];
#endif
    
    [self.weatherIcon setImage:[UIImage imageNamed:model[kHHXXYahooWeatherItemKey_HeadImage]]];
    [self.wetherInfo setText:model[kHHXXYahooWeatherItemKey_HeadText]];
    [self.highTempInfo setText:model[kHHXXYahooWeatherItemKey_HeadTopTemp]];
    [self.lowTempInfo setText:model[kHHXXYahooWeatherItemKey_HeadLowTemp]];
    [self.tempInfo setText:model[kHHXXYahooWeatherItemKey_HeadTemp]];
    
    NSMutableAttributedString* copyrightString = [[NSMutableAttributedString alloc] initWithString:@"© 由 Bing 提供, "];
    [copyrightString appendAttributedString:[NSAttributedString attributedStringWithAttachment:({
        NSTextAttachment* logo = [[NSTextAttachment alloc] init];
        logo.image = [UIImage imageNamed:@"bing"];
        logo.bounds = CGRectMake(0, 0, 12, 12);
        logo;
    })]];
    self.copyrightLabel.attributedText = copyrightString;
}


- (void)updateConstraints
{
    if (!self.layoutConstraintsIsCreated) {
        [self hhxx_createLayoutConstraints];
    }
    [super updateConstraints];
}


- (void)hhxx_createLayoutConstraintsIfNeed
{
    if (!self.layoutConstraintsIsCreated) {
        [self hhxx_createLayoutConstraints];
        self.layoutConstraintsIsCreated = NO;
    }
}


- (void)hhxx_createLayoutConstraints
{
    CGFloat vPadding = 6.0f;
    CGFloat hPadding = 8.0f;
    CGFloat fontHeight = HHXX_MAIN_SCREEN_WIDTH * 0.25;
    CGFloat iconHeight = 24;
    
    // 装饰视图
    [self.rowOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rowTwo.mas_top).offset(-vPadding);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, hPadding, 0, hPadding));
        make.height.mas_equalTo(iconHeight);
    }];
    
    [self.rowTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rowThree.mas_top).offset(-vPadding);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, hPadding, 0, hPadding));
        make.height.mas_equalTo(iconHeight);
    }];
    
    [self.rowThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(fontHeight);
        make.bottom.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, hPadding, vPadding, hPadding));
    }];
    
    // 天气详情布局
    [self.weatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.rowOne).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(iconHeight);
    }];
    [self.wetherInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.rowOne).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.left.equalTo(self.weatherIcon.mas_right).mas_offset(hPadding);
        make.right.equalTo(self.rowOne).priorityLow();
    }];
    
    // 温度上下限
    [self.highTempIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.rowTwo).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(iconHeight);
    }];
    [self.highTempInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.rowTwo).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.left.equalTo(self.highTempIcon.mas_right).mas_offset(hPadding);
    }];
    [self.lowTempIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.rowTwo).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.left.equalTo(self.highTempInfo.mas_right).mas_offset(hPadding);
        make.width.mas_equalTo(iconHeight);
    }];
    [self.lowTempInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.rowTwo).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.left.equalTo(self.lowTempIcon.mas_right).mas_offset(hPadding);
    }];
    
    // 版权
    [self.tempInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.rowThree).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        make.width.equalTo(self.tempInfo.mas_height);
    }];
    [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.rowThree).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    [self.tempInfo hhxxAddBorderWithColor:[UIColor grayColor] borderWidth:1.0 borderStyle:HHXXBorderStyleRight|HHXXBorderStyleDashed];
}

- (NSArray*)_hhxxSubviews
{
    return @[self.rowOne, self.rowTwo, self.rowThree];
}


/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    [[self _hhxxSubviews] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    
    [self.rowOne addSubview:self.wetherInfo];
    [self.rowOne addSubview:self.weatherIcon];
    
    [self.rowTwo addSubview:self.highTempIcon];
    [self.rowTwo addSubview:self.highTempInfo];
    [self.rowTwo addSubview:self.lowTempIcon];
    [self.rowTwo addSubview:self.lowTempInfo];
    
    [self.rowThree addSubview:self.tempInfo];
    [self.rowThree addSubview:self.copyrightLabel];
    
    
    [self configureWithModel:nil];
    //if view based frame, noted
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
    
    self.backgroundColor = [UIColor clearColor];
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


#pragma mark - getter and setter
- (UIView*)rowOne
{
    if (!_rowOne) {
        _rowOne = [UIView new];
        _rowOne.backgroundColor = [UIColor clearColor];
    }
    
    return _rowOne;
}


- (UIView*)rowTwo
{
    if (!_rowTwo) {
        _rowTwo = [UIView new];
        _rowTwo.backgroundColor = [UIColor clearColor];
    }
    
    return _rowTwo;
}

- (UIView*)rowThree
{
    if (!_rowThree){
        _rowThree = [UIView new];
        _rowThree.backgroundColor = [UIColor clearColor];
    }
    
    return _rowThree;
}


- (UILabel*)wetherInfo
{
    if (!_wetherInfo)
    {
        _wetherInfo = [[UILabel alloc] init];
        _wetherInfo.font = [UIFont systemFontOfSize:10];
        _wetherInfo.textColor = [UIColor whiteColor];
    }
    
    return _wetherInfo;
}

- (UIImageView*)weatherIcon
{
    if (!_weatherIcon) {
        _weatherIcon = [[UIImageView alloc] init];
    }
    
    return _weatherIcon;
}

- (UILabel*)highTempInfo
{
    if (!_highTempInfo)
    {
        _highTempInfo = [[UILabel alloc] init];
        _highTempInfo.textColor = [UIColor whiteColor];
    }
    
    return _highTempInfo;
}

- (UIImageView*)highTempIcon
{
    if (!_highTempIcon) {
        _highTempIcon = [[UIImageView alloc] init];
        [_highTempIcon setImage:[UIImage imageNamed:@"high"]];
        [_highTempIcon setContentMode:UIViewContentModeCenter];
    }
    
    return _highTempIcon;
}

- (UILabel*)lowTempInfo
{
    if (!_lowTempInfo)
    {
        _lowTempInfo = [[UILabel alloc] init];
        _lowTempInfo.textColor = [UIColor whiteColor];
    }
    
    return _lowTempInfo;
}

- (UIImageView*)lowTempIcon
{
    if (!_lowTempIcon) {
        _lowTempIcon = [[UIImageView alloc] init];
        [_lowTempIcon setImage:[UIImage imageNamed:@"low"]];
        [_lowTempIcon setContentMode:UIViewContentModeCenter];
    }
    
    return _lowTempIcon;
}


- (UILabel*)tempInfo
{
    if (!_tempInfo)
    {
        _tempInfo = [[UILabel alloc] init];
        [_tempInfo setFont:[UIFont systemFontOfSize:96]];
        _tempInfo.textColor = [UIColor whiteColor];
    }
    
    return _tempInfo;
}


- (UILabel*)copyrightLabel
{
    if (!_copyrightLabel) {
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.textColor = [UIColor whiteColor];
        [_copyrightLabel setFont:[UIFont systemFontOfSize:8]];
    }
    
    return _copyrightLabel;
}
@end
