//
//  TableViewCellForDetail.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForDetail.h"
#import "TableViewCellForMap.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "HHXXAutoLayoutDynamicView.h"
#import "UIView+Border.h"
#import "UITableViewCell+EnableDrag.h"
#import "YahooWeatherItemKey.h"

@interface TableViewCellForDetail()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;
@property (nonatomic, strong) UIView* bodyArea;

// 头部
@property (nonatomic, strong) UILabel* cellTitle;
@property (nonatomic, strong) UIImageView* typeImage;

@property (nonatomic, strong) UIImageView* detailWeatherIcon;
@property (nonatomic, strong) NSMutableArray<HHXXAutoLayoutDynamicView*>* detailViews;
@end

@implementation TableViewCellForDetail

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.detailViews enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != [self.detailViews count] - 1) {
            [obj hhxxAddBorderWithColor:[UIColor grayColor] borderWidth:1.0 borderStyle:HHXXBorderStyleBottom|HHXXBorderStyleDashed];
        }
    }];
    
    [super layoutSubviews];
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
        make.top.equalTo(self.borderView.mas_bottom).offset(kHHXXVPadding);
        make.bottom.equalTo(self.contentViewInstead.mas_bottom).mas_offset(-kHHXXVPadding);
    }];
    
    // 头部
    [self.cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.headArea).insets(UIEdgeInsetsMake(kHHXX2DivPadding, kHHXX2DivPadding, 0, 0));
        make.bottom.equalTo(self.headArea);
    }];
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.headArea).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.height.mas_equalTo(iconHeight);
        make.left.equalTo(self.cellTitle.mas_right).offset(4);
        make.bottom.equalTo(self.headArea).priority(500);
    }];
    
    // 天气详情
    [self.detailWeatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bodyArea).insets(UIEdgeInsetsMake(0, kHHXX2DivPadding, 0, kHHXX2DivPadding));
        make.height.equalTo(@96);
        make.width.equalTo(self.detailWeatherIcon.mas_height).multipliedBy(1.5).priority(999);
        make.bottom.equalTo(self.bodyArea).mas_offset(-kHHXXVPadding).priority(500);
    }];
    
    __block UIView* preView = nil;
    [self.detailViews enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.detailWeatherIcon.mas_right);
            make.right.equalTo(self.bodyArea);
            if (preView)
            {
                make.top.equalTo(preView.mas_bottom);
                make.height.equalTo(preView.mas_height);
            }else{
                make.top.equalTo(self.bodyArea);
            }
            if(idx == [self.detailViews count] - 1)
            {
                make.bottom.equalTo(self.bodyArea);
            }
        }];
        preView = obj;
    }];
}


- (NSArray<NSString*>*)titles
{
    return @[@"体感温度", @"湿度", @"能见度", @"紫外线"];
}

- (void)configureWithModel:(id)model
{
    [self.cellTitle setText:@"详细信息"];
    [self.detailWeatherIcon setImage:[UIImage imageNamed:model[kHHXXYahooWeatherItemKey_HeadImage]]];
    NSArray<NSString*>* values = @[@"暂时没值", model? model[kHHXXYahooWeatherItemKey_DetailHumidity]: @"暂时没值", model? model[kHHXXYahooWeatherItemKey_DetailVisibility]: @"暂时没值", @"暂时没值"];
    
    [self.detailViews enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.modelBlock = ^(NSArray* children){
            [(UILabel*)children[0] setText:[[self titles] objectAtIndex:idx]];
            [(UILabel*)children[1] setText:[values objectAtIndex:idx]];
        };
        [obj configureWithModel];
    }];
    
    
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
    
    [self.detailViews enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.bodyArea addSubview:obj];
    }];
    [self.bodyArea addSubview:self.detailWeatherIcon];
    
    //if view based frame, noted
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    self.typeImage.userInteractionEnabled = YES;
    [self.typeImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxTouchCell:)]];
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
        _typeImage.userInteractionEnabled = YES;
    }
    
    return _typeImage;
}


- (NSMutableArray<HHXXAutoLayoutDynamicView *> *)detailViews
{
    if (!_detailViews) {
        _detailViews = [NSMutableArray arrayWithCapacity:4];
        for (NSUInteger index = 0; index < 4; ++index) {
            HHXXAutoLayoutDynamicView* _detailView = [[HHXXAutoLayoutDynamicView alloc] initWithSuvViewGenerator:^{
                UILabel* label = [UILabel new];
                label.backgroundColor = [UIColor clearColor];
                [label setTextColor:FONT_COLOR];
                [label setText:@"这是测试"];
                [label setTextAlignment:NSTextAlignmentLeft];
                
                return label;
            } number:2];
            
            
            [_detailView decorateChildWithBlock:^(NSArray *child) {
                [(UILabel*)child[0] setFont:[UIFont systemFontOfSize:12]];
                [(UILabel*)child[1] setFont:[UIFont systemFontOfSize:14]];
                [(UILabel*)child[1] setTextAlignment:NSTextAlignmentRight];
            }];
            [_detailViews addObject:_detailView];
        }
    }
    
    return _detailViews;
}

- (UIImageView*)detailWeatherIcon
{
    if (!_detailWeatherIcon) {
        _detailWeatherIcon = [[UIImageView alloc] init];
        _detailWeatherIcon.contentMode = UIViewContentModeCenter;
    }
    
    return _detailWeatherIcon;
}
@end
