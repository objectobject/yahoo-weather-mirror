//
//  TableViewCellForSunMoon.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForSunMoon.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "HHXXSunRaiseLayer.h"
#import "YahooWeatherItemKey.h"
#import "UITableViewCell+EnableDrag.h"


@interface TableViewCellForSunMoon()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;
@property (nonatomic, strong) UIView* bodyArea;

// 头部
@property (nonatomic, strong) UILabel* cellTitle;
@property (nonatomic, strong) UIImageView* typeImage;

@property (nonatomic, strong) HHXXSunRaiseLayer* sunSet;
@property (nonatomic, strong) UILabel* moonDescribe;
@end

@implementation TableViewCellForSunMoon

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)hhxx_createLayoutConstraints
{
    CGFloat iconHeight = 32.0f;
//    CGFloat bodyAreaHeight = 192;
    
    
    [self.headArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(kHHXXVPadding, kHHXXHPadding, 0, kHHXXHPadding));
    }];
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headArea.mas_bottom);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, kHHXXHPadding, 0, kHHXXHPadding));
    }];
    [self.bodyArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, kHHXXHPadding, 0, kHHXXHPadding));
        make.top.equalTo(self.borderView.mas_bottom).offset(2 * kHHXXVPadding);
        make.bottom.equalTo(self.contentViewInstead.mas_bottom).mas_offset(-kHHXXVPadding).priority(500);
        make.height.equalTo(@150);
    }];
    
    [self.moonDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bodyArea).offset(-kHHXXHPadding);
        make.top.equalTo(self.bodyArea).offset(kHHXXHPadding);
    }];
    
    // 头部
    [self.cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.headArea).insets(UIEdgeInsetsMake(kHHXX2DivPadding, kHHXX2DivPadding, 0, 0));
        make.bottom.equalTo(self.headArea);
    }];
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.headArea).insets(UIEdgeInsetsZero);
        make.width.height.mas_equalTo(iconHeight);
        make.left.equalTo(self.cellTitle.mas_right).offset(4);
        make.bottom.equalTo(self.headArea).priority(500);
    }];
}


- (void)configureWithModel:(id)model
{
    [self.cellTitle setText:@"日落"];
    
    self.sunSet.sunsetTime = model[kHHXXYahooWeatherItemKey_SunSetTime];
    self.sunSet.sunraiseTime = model[kHHXXYahooWeatherItemKey_SunRaiseTime];
    self.sunSet.sunsetRateValue = arc4random() % 10 / 10.0f;
    
    [self.moonDescribe setText:@"现在是满月时间!"];
    [self.moonDescribe setAttributedText:({
        NSMutableAttributedString* attributeString = [NSMutableAttributedString new];
        [attributeString appendAttributedString:[NSAttributedString attributedStringWithAttachment:({
            NSTextAttachment* atm = [[NSTextAttachment alloc] init];
            atm.image = [UIImage imageNamed:@"moon"];
            atm.bounds = CGRectMake(0, 0, 16, 16);
            atm;
        })]];
        [attributeString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 弦月"]];
        [attributeString addAttribute:NSBaselineOffsetAttributeName value:@(4) range:NSMakeRange(1, 3)];
        attributeString;
    })];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.sunSet.frame = CGRectMake(0, 0, self.bounds.size.width - 2 * kHHXXHPadding, 150);
    self.sunSet.lineLength = self.bounds.size.width;
}

/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    [super commonInit];
    [@[self.bodyArea, self.headArea, self.borderView] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentViewInstead addSubview:obj];
    }];
    
    [self configureWithModel:nil];
    [self.headArea addSubview:self.cellTitle];
    [self.headArea addSubview:self.typeImage];
    [self.bodyArea.layer addSublayer:self.sunSet];
    [self.bodyArea addSubview:self.moonDescribe];
    
    //if view based frame, noted
    self.typeImage.userInteractionEnabled = YES;
    [self.typeImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxTouchCell:)]];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


- (void)_hhxxTouchCell:(UILongPressGestureRecognizer*)sender
{
    [self hhxxDragView:self.typeImage];
}



#pragma mark - init function

/* 如果是UITableViewCell或者是UICollectionViewCell的话就需要把下面的初始化函数用上
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


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

#pragma mark - getter and setter
- (UIView*)headArea
{
    if (!_headArea) {
        _headArea = [UIView new];
        _headArea.backgroundColor = [UIColor clearColor];
    }
    
    return _headArea;
}


- (UIView*)bodyArea
{
    if (!_bodyArea) {
        _bodyArea = [UIView new];
        _bodyArea.backgroundColor = [UIColor clearColor];
        _bodyArea.clipsToBounds = YES;
    }
    return _bodyArea;
}

- (UIView*)borderView
{
    if (!_borderView) {
        _borderView = [UIView new];
        _borderView.backgroundColor = [UIColor whiteColor];
    }
    
    return _borderView;
}

- (UILabel*)cellTitle
{
    if (!_cellTitle) {
        _cellTitle = [UILabel new];
        [_cellTitle setTextColor:FONT_COLOR];
        _cellTitle.numberOfLines = 0;
        _cellTitle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _cellTitle;
}


- (UIImageView*)typeImage
{
    if (!_typeImage) {
        _typeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touch-cell"]];
        [_typeImage setContentMode:UIViewContentModeCenter];
        [_typeImage setAlpha:0.5];
    }
    
    return _typeImage;
}


- (HHXXSunRaiseLayer *)sunSet
{
    if (!_sunSet) {
        _sunSet = [HHXXSunRaiseLayer new];
    }
    
    return _sunSet;
}

- (UILabel *)moonDescribe
{
    
    if (!_moonDescribe) {
        _moonDescribe = [UILabel new];
        [_moonDescribe setTextColor:FONT_COLOR];
        [_moonDescribe setFont:[UIFont systemFontOfSize:13]];
        [_moonDescribe setTextAlignment:NSTextAlignmentCenter];
    }
    
    return _moonDescribe;
}
@end

