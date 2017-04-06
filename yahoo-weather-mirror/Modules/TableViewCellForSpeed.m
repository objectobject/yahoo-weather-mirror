//
//  TableViewCellForSpeed.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForSpeed.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "HHXXWindmillView.h"


const NSString* kHHXXDashedLayer = @"kHHXXDashedLayer";

@interface TableViewCellForSpeed()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;
@property (nonatomic, strong) UIView* bodyArea;

// 头部
@property (nonatomic, strong) UILabel* cellTitle;
@property (nonatomic, strong) UIImageView* typeImage;
@property (nonatomic, strong) HHXXWindmillView* largeWinmill;
@property (nonatomic, strong) HHXXWindmillView* miniWinmill;
@property (nonatomic, strong) UIView* levelView;

@property (nonatomic, strong) UILabel* windDetail;
@property (nonatomic, strong) UIView* divisionBorder;
@property (nonatomic, strong) UILabel* airDetail;
@end

@implementation TableViewCellForSpeed

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
    
    // body
    [self.largeWinmill mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.bodyArea);
        make.left.equalTo(self.bodyArea).offset(kHHXXHPadding);
        make.width.equalTo(@80);
        make.top.equalTo(self.bodyArea).offset(kHHXXVPadding);
        make.bottom.equalTo(self.bodyArea).priority(999).offset(-kHHXXVPadding);
    }];
    [self.miniWinmill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.largeWinmill);
        make.bottom.equalTo(self.largeWinmill);
    }];
    
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bodyArea).offset(-kHHXXHPadding);
        make.top.equalTo(self.bodyArea).offset(kHHXXVPadding);
        make.bottom.equalTo(self.bodyArea).offset(-kHHXXVPadding);
        make.width.equalTo(@4);
    }];
    
    [self.airDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bodyArea).offset(-kHHXXHPadding);
        make.right.equalTo(self.levelView.mas_left).offset(-kHHXXHPadding);
    }];
    [self.windDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.largeWinmill.mas_right).offset(kHHXXHPadding);
        make.top.equalTo(self.bodyArea).offset(kHHXXVPadding);
    }];
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
    }];
    [self.divisionBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.airDetail.mas_top);
        make.left.equalTo(self.bodyArea).offset(8 + kHHXXVPadding);
        make.height.equalTo(@1);
        make.right.equalTo(self.levelView.mas_left).offset(-kHHXXVPadding);
    }];
}


- (void)configureWithModel:(id)model
{
    [self.miniWinmill hhxxTick];
    [self.largeWinmill hhxxTick];
    [self.cellTitle setText:@"风速和气压"];
    
    NSString* windetailText = [NSString stringWithFormat:@"风速\r\n%.01f公里/小时 东南", 11.33];
    NSString* airdatailText = [NSString stringWithFormat:@"气压\r\n%.01f毫巴", 1010.9];
    [self.windDetail setAttributedText:({
        NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:windetailText];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[windetailText rangeOfString:[NSString stringWithFormat:@"%.01f", 11.33]]];
        attributeString;
    })];
    
    [self.airDetail setAttributedText:({
        NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:airdatailText];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[windetailText rangeOfString:[NSString stringWithFormat:@"%.01f", 1010.9]]];
        attributeString;
    })];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[_levelView.layer.sublayers filteredArrayUsingPredicate:({
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", kHHXXDashedLayer];
        predicate;
    })] enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    CAShapeLayer* calayer = [CAShapeLayer layer];
    calayer.lineDashPattern = @[@1, @8];
    calayer.strokeColor = [UIColor grayColor].CGColor;
    calayer.frame = _levelView.bounds;
    calayer.path = ({
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:_levelView.bounds.origin];
        [path addLineToPoint:CGPointMake(_levelView.bounds.origin.x, _levelView.bounds.size.height)];
        path;
    }).CGPath;
    calayer.lineWidth = 4.0;
    calayer.name = (NSString*)kHHXXDashedLayer;
    [_levelView.layer addSublayer:calayer];
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
    [self.bodyArea addSubview:self.miniWinmill];
    [self.bodyArea addSubview:self.largeWinmill];
    [self.bodyArea addSubview:self.levelView];
    [self.bodyArea addSubview:self.windDetail];
    [self.bodyArea addSubview:self.airDetail];
    [self.bodyArea addSubview:self.divisionBorder];
    
    //if view based frame, noted
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

- (UIView *)levelView
{
    if (!_levelView) {
        _levelView = [[UIView alloc] init];
    }
    
    return _levelView;
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


- (HHXXWindmillView *)largeWinmill
{
    if (!_largeWinmill) {
        _largeWinmill = [[HHXXWindmillView alloc] init];
    }
    
    return _largeWinmill;
}

- (HHXXWindmillView *)miniWinmill
{
    if (!_miniWinmill) {
        _miniWinmill = [[HHXXWindmillView alloc] init];
        [_miniWinmill setScaleValue:0.6];
    }
    
    return _miniWinmill;
}

- (UILabel*)windDetail
{
    if (!_windDetail) {
        _windDetail = [UILabel new];
        _windDetail.numberOfLines = 0;
        [_windDetail setTextColor:FONT_COLOR];
        [_windDetail setFont:[UIFont systemFontOfSize:10]];
    }
    
    return _windDetail;
}

- (UIView*)divisionBorder
{
    if (!_divisionBorder) {
        _divisionBorder = [UIView new];
        _divisionBorder.backgroundColor = [UIColor grayColor];
    }
    
    return _divisionBorder;
}


- (UILabel*)airDetail
{
    if (!_airDetail) {
        _airDetail = [UILabel new];
        _airDetail.numberOfLines = 0;
        [_airDetail setTextColor:FONT_COLOR];
        [_airDetail setTextAlignment:NSTextAlignmentRight];
        [_airDetail setFont:[UIFont systemFontOfSize:10]];
    }
    
    return _airDetail;
}
@end
