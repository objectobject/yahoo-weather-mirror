//
//  TableViewCellForMap.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForMap.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "UITableViewCell+EnableDrag.h"

@interface TableViewCellForMap()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;
@property (nonatomic, strong) UIView* bodyArea;

// 头部
@property (nonatomic, strong) UILabel* cellTitle;
@property (nonatomic, strong) UIImageView* typeImage;

@property (nonatomic, strong) UIImageView* mapImage;
@property (nonatomic, strong) UIImageView* touchImage;
@end

@implementation TableViewCellForMap

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
        make.top.equalTo(self.borderView.mas_bottom).offset(kHHXXVPadding);
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
    
    // 地图部分
    [self.mapImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, kHHXX2DivPadding, 0, kHHXX2DivPadding));
        make.height.mas_equalTo(bodyAreaHeight);
        make.bottom.equalTo(self.contentViewInstead.mas_bottom).mas_equalTo(-kHHXX2DivPadding).priority(500);
    }];
    [self.touchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, 0, 16, 16));
    }];
}


- (void)configureWithModel:(id)model
{
    [self.cellTitle setText:@"地图"];
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
    
    [self.bodyArea addSubview:self.mapImage];
    [self.bodyArea addSubview:self.touchImage];
    
    //if view based frame, noted
    self.typeImage.userInteractionEnabled = YES;
    [self.typeImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxTouchCell:)]];
    
<<<<<<< HEAD
//
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
=======
//    
//    [self updateConstraintsIfNeeded];
//    [self setNeedsUpdateConstraints];
>>>>>>> b664bb375049bbf077eea790084fdf33847c8bc8
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
#ifdef DEBUG
        _bodyArea.backgroundColor = [UIColor redColor];
#endif
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


- (UIImageView*)mapImage
{
    if (!_mapImage) {
        _mapImage = [UIImageView new];
        [_mapImage setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return _mapImage;
}


- (UIImageView*)touchImage
{
    if (!_touchImage) {
        _touchImage = [UIImageView new];
        [_touchImage setContentMode:UIViewContentModeScaleAspectFit];
        [_touchImage setImage:[UIImage imageNamed:@"map-touch"]];
    }
    
    return _touchImage;
}
@end
