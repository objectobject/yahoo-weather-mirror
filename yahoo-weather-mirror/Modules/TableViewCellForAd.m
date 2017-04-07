//
//  TableViewCellForAdd.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForAd.h"
#import "HHXXUIKitMacro.h"
#import <Masonry.h>
#import "YahooWeatherItemKey.h"

@interface TableViewCellForAd()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;
@property (nonatomic, strong) UIView* bodyArea;

@property (nonatomic, strong) UILabel* adTitle;
@property (nonatomic, strong) UIImageView* typeImage;

@property (nonatomic, strong) UILabel* adVertiser;
@property (nonatomic, strong) UIImageView* adContent;
@end

@implementation TableViewCellForAd


- (void)configureWithModel:(id)model
{
#ifdef DEBUG
    [self.adTitle setText:@"广告标题告标题告标题告标题告标题告标题告标题告标题告标题告标题告标题"];
    [self.adVertiser setText:@"广告主"];
    [self.adContent setImage:[UIImage imageNamed:@"adContent"]];
#endif
    
    [self.adTitle setText:model[kHHXXYahooWeatherItemKey_AdTitle]];
    [self.adVertiser setText:model[kHHXXYahooWeatherItemKey_AdContent]];
    [self.adContent setImage:[UIImage imageNamed:model[kHHXXYahooWeatherItemKey_AdImage]]];
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
    CGFloat iconHeight = 32.0f;
    CGFloat bodyAreaHeight = 192;
    
    
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
        make.top.equalTo(self.borderView.mas_bottom);
        make.bottom.equalTo(self.contentViewInstead.mas_bottom).mas_offset(-kHHXXVPadding);
    }];
    
    // 头部
    [self.adTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.headArea).insets(UIEdgeInsetsMake(kHHXX2DivPadding, kHHXX2DivPadding, 0, 0));
        make.bottom.equalTo(self.headArea);
    }];
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.headArea).insets(UIEdgeInsetsZero);
        make.width.height.mas_equalTo(iconHeight);
        make.left.equalTo(self.adTitle.mas_right).offset(4);
        make.bottom.equalTo(self.headArea).priority(500);
    }];

    // 详细内容区域
    [self.adVertiser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bodyArea).insets(UIEdgeInsetsMake(0, kHHXX2DivPadding, 0, kHHXX2DivPadding));
    }];
    [self.adContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bodyArea).insets(UIEdgeInsetsMake(0, kHHXX2DivPadding, 0, kHHXX2DivPadding));
        make.top.equalTo(self.adVertiser.mas_bottom).offset(4);
        make.height.mas_equalTo(bodyAreaHeight);
        make.bottom.equalTo(self.bodyArea).mas_equalTo(-kHHXX2DivPadding).priority(500);
    }];
}


/**
 *  初始化各种子视图
 */
- (void)commonInit
{
//    self.contentViewInstead.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [super commonInit];
    self.canDrag = NO;
    self.layer.cornerRadius = 4.0f;
    [@[self.bodyArea, self.headArea, self.borderView] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentViewInstead addSubview:obj];
    }];
    
    [self.headArea addSubview:self.adTitle];
    [self.headArea addSubview:self.typeImage];
    [self.bodyArea addSubview:self.adVertiser];
    [self.bodyArea addSubview:self.adContent];
    
    [self configureWithModel:nil];
    //if view based frame, noted
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    [self.contentViewInstead setNeedsLayout];
//    [self.contentViewInstead layoutIfNeeded];
//    
//    self.adTitle.preferredMaxLayoutWidth = CGRectGetWidth(self.contentViewInstead.frame) - 24;
//}


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


- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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


- (UILabel*)adTitle
{
    if (!_adTitle) {
        _adTitle = [UILabel new];
        [_adTitle setTextColor:FONT_COLOR];
        _adTitle.numberOfLines = 0;
        _adTitle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _adTitle;
}


- (UIImageView*)typeImage
{
    if (!_typeImage) {
        _typeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-type-ad"]];
        [_typeImage setContentMode:UIViewContentModeCenter];
        _typeImage.hidden = YES;
    }
    
    return _typeImage;
}

- (UILabel*)adVertiser
{
    if (!_adVertiser) {
        _adVertiser = [UILabel new];
        [_adVertiser setTextColor:[UIColor grayColor]];
        [_adVertiser setFont:[UIFont systemFontOfSize:12]];
    }
    
    return _adVertiser;
}


- (UIImageView*)adContent
{
    if (!_adContent) {
        _adContent = [UIImageView new];
        [_adContent setContentMode:UIViewContentModeScaleAspectFill];
    }
    
    return _adContent;
}
@end
