//
//  TableViewCellForWeekDaily.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForWeekDaily.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "HHXXAutoLayoutDynamicView.h"
#import "UIView+Border.h"


const NSUInteger lowNumber = 7;
const NSUInteger hightNumber = 14;

@interface TableViewCellForWeekDaily()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;

// 头部
@property (nonatomic, strong) UILabel* cellTitle;
@property (nonatomic, strong) UIImageView* typeImage;


@property (nonatomic, strong) UIScrollView* dailyArea;
@property (nonatomic, strong) UIView* dailyContainer;
@property (nonatomic, strong) UIView* weekArea;
@property (nonatomic, strong) UIView* switchArea;


@property (nonatomic, strong) NSMutableArray<HHXXAutoLayoutDynamicView*>* dailyOfWeek;
@property (nonatomic, strong) NSMutableArray<UILabel*>* hourOfDay;

@property (nonatomic, strong) UIButton* lessDay;
@property (nonatomic, strong) UIView* onePixel;
@property (nonatomic, strong) UIButton* moreDay;


@property (nonatomic, assign) BOOL expand;
@end

@implementation TableViewCellForWeekDaily

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

//- (UIEdgeInsets)alignmentRectInsets
//{
//    return UIEdgeInsetsMake(-8, -8, -8, -8);
//}

- (CGRect)alignmentRectForFrame:(CGRect)frame
{
    return CGRectInset(frame, 8, 8);
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.dailyOfWeek enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == [self.dailyOfWeek firstObject]) {
            [obj hhxxAddBorderWithColor:[UIColor grayColor] borderWidth:1.0 borderStyle:HHXXBorderStyleBottom| HHXXBorderStyleDashed|HHXXBorderStyleTop];
        }else
        {
            [obj hhxxAddBorderWithColor:[UIColor grayColor] borderWidth:1.0 borderStyle:HHXXBorderStyleBottom| HHXXBorderStyleDashed];
        }
    }];
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
    [self.dailyArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, kHHXXHPadding, 0, kHHXXHPadding));
        make.top.equalTo(self.borderView.mas_bottom).mas_offset(kHHXXVPadding);
        make.height.equalTo(@64);
    }];
    [self.weekArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, kHHXXHPadding, 0, kHHXXHPadding));
        make.top.equalTo(self.dailyArea.mas_bottom);
//        make.height.equalTo(@110);
    }];
    [self.switchArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentViewInstead).insets(UIEdgeInsetsMake(0, kHHXXHPadding, 0, kHHXXHPadding));
        make.top.equalTo(self.weekArea.mas_bottom);
        make.bottom.equalTo(self.contentViewInstead.mas_bottom).mas_offset(-kHHXXVPadding).priority(500);
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
    
    // 每日24天气
    [self.dailyContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.dailyArea);
        make.left.top.right.bottom.equalTo(self.dailyArea);
    }];
    
    __block UIView* preView = nil;
    [self.hourOfDay enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.dailyContainer).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            if (preView) {
                make.left.equalTo(preView.mas_right).mas_offset(kHHXXHPadding);
                make.width.equalTo(preView.mas_width);
            }
            else{
                make.left.equalTo(self.dailyContainer);
            }
            if (idx == [self.hourOfDay count] - 1) {
                make.right.equalTo(self.dailyContainer);
            }
        }];
        preView = obj;
    }];
    
    // 每周7天天气
    preView = nil;
    [self.dailyOfWeek enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.expand) {
                make.height.equalTo(@32);
            }else{
                make.height.equalTo(idx >= lowNumber? @0: @32);
            }
            make.left.right.equalTo(self.weekArea);
            if (preView) {
                make.top.equalTo(preView.mas_bottom);
            }else{
                make.top.equalTo(self.weekArea);
            }
            if (obj == [self.dailyOfWeek lastObject]) {
                make.bottom.equalTo(self.weekArea);
            }
        }];
        preView = obj;
    }];
    
    // 转化开关
    [self.lessDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.switchArea).insets(UIEdgeInsetsMake(0, kHHXX2DivPadding, 0, kHHXX2DivPadding));
        make.height.equalTo(@24);
        make.bottom.equalTo(self.switchArea).mas_offset(kHHXX2DivPadding);
    }];
    
    [self.onePixel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.switchArea);
        make.height.equalTo(@10);
        make.width.equalTo(@1);
        make.left.equalTo(self.lessDay.mas_right);
    }];
    
    [self.moreDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.switchArea).insets(UIEdgeInsetsMake(0, kHHXX2DivPadding, 0, kHHXX2DivPadding));
        make.height.equalTo(@24);
        make.left.equalTo(self.onePixel.mas_right);
        make.bottom.equalTo(self.switchArea).mas_offset(kHHXX2DivPadding);
    }];
}


- (void)configureWithModel:(id)model
{
    [self.cellTitle setText:@"每日天气"];
    
    [self.dailyOfWeek enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.modelBlock = ^(NSArray* child){
            [(UILabel*)child[0] setText:@"星期一"];
            [(UILabel*)child[1] setText:@"天气"];
            [(UILabel*)child[2] setText:@"10 99"];
        };
        [obj configureWithModel];
    }];
    
    [self.hourOfDay enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setAttributedText:[self _hhxxCreateRainFallAttributeString:@"22:00" tempValue:24]];
    }];
}


- (NSAttributedString*)_hhxxCreateRainFallAttributeString:(NSString*)time tempValue:(CGFloat)tempValue
{
    NSMutableAttributedString* rainFallString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\r\n", time]];
    
    [rainFallString appendAttributedString:[NSAttributedString attributedStringWithAttachment:({
        NSTextAttachment* attachment = [NSTextAttachment new];
        attachment.image = [UIImage imageNamed:@"rain_ico_0"];
        attachment.bounds = CGRectMake(0, 0, 18, 23.5);// 1.3的倍率
        attachment;
    })]];
    [rainFallString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r\n22"]];
    [rainFallString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, time.length)];
    return [rainFallString copy];
}

/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    [super commonInit];
    self.canDrag = NO;
    [@[self.headArea, self.borderView, self.dailyArea, self.weekArea, self.switchArea] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentViewInstead addSubview:obj];
    }];
    
    [self.dailyArea addSubview:self.dailyContainer];
    
    [self.dailyOfWeek enumerateObjectsUsingBlock:^(HHXXAutoLayoutDynamicView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.weekArea addSubview:obj];
    }];
    [self.hourOfDay enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dailyContainer addSubview:obj];
    }];
    
    [self.switchArea addSubview:self.lessDay];
    [self.switchArea addSubview:self.onePixel];
    [self.switchArea addSubview:self.moreDay];
    
    [self configureWithModel:nil];
    [self.headArea addSubview:self.cellTitle];
    [self.headArea addSubview:self.typeImage];
    
    //if view based frame, noted
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
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

#pragma mark - event handler

- (void)_switchDayNumber:(UIButton*)sender
{
    self.lessDay.selected = !self.lessDay.selected;
    self.moreDay.selected = !self.moreDay.selected;
    
    self.expand = !self.expand;
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
        _typeImage.hidden = YES;
    }
    
    return _typeImage;
}


- (UIScrollView*)dailyArea
{
    if (!_dailyArea) {
        _dailyArea = [UIScrollView new];
        _dailyArea.showsVerticalScrollIndicator = NO;
        _dailyArea.showsHorizontalScrollIndicator = NO;
        _dailyArea.backgroundColor = [UIColor clearColor];
        _dailyArea.scrollEnabled = YES;
    }
    
    return _dailyArea;
}

- (UIView*)dailyContainer
{
    if (!_dailyContainer) {
        _dailyContainer = [UIView new];
        _dailyContainer.backgroundColor = [UIColor clearColor];
    }
    
    return _dailyContainer;
}

- (UIView*)weekArea{
    if (!_weekArea) {
        _weekArea = [UIView new];
    }
    
    return _weekArea;
}

- (UIView*)switchArea
{
    if (!_switchArea) {
        _switchArea = [UIView new];
    }
    
    return _switchArea;
}

- (NSMutableArray<HHXXAutoLayoutDynamicView *> *)dailyOfWeek
{
    if (!_dailyOfWeek) {
        _dailyOfWeek = [NSMutableArray new];
        
        for (NSUInteger index = 0; index < 14; ++index) {
            [_dailyOfWeek addObject:({
                HHXXAutoLayoutDynamicView* dailyView = [[HHXXAutoLayoutDynamicView alloc] initWithSuvViewGenerator:^id{
                    UILabel* label = [UILabel new];
                    label.textColor = FONT_COLOR;
                    [label setBackgroundColor:[UIColor clearColor]];
                    return label;
                } number:3];
                
                [dailyView decorateChildWithBlock:^(NSArray *child) {
                    [child[0] setTextAlignment:NSTextAlignmentLeft];
                    [child[1] setTextAlignment:NSTextAlignmentCenter];
                    [child[2] setTextAlignment:NSTextAlignmentRight];
                }];
                dailyView;
            })];
        }
    }
    
    return _dailyOfWeek;
}


- (NSMutableArray<UILabel *> *)hourOfDay
{
    if (!_hourOfDay) {
        _hourOfDay = [NSMutableArray arrayWithCapacity:4];
        for (NSUInteger index = 0; index < 24; index++) {
            [_hourOfDay addObject:({
                UILabel *hour = [UILabel new];
                [hour setTextColor:FONT_COLOR];
                hour.numberOfLines = 0;
                hour.backgroundColor = [UIColor clearColor];
                hour.lineBreakMode = NSLineBreakByWordWrapping;
                [hour setTextAlignment:NSTextAlignmentCenter];
                hour;
            })];
        }
    }
    
    return _hourOfDay;
}

- (UIButton*)lessDay
{
    if (!_lessDay) {
        _lessDay = [UIButton new];
        [_lessDay setTitle:@"7天" forState:UIControlStateNormal];
        [_lessDay.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_lessDay setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_lessDay setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [_lessDay setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected|UIControlStateHighlighted];
        _lessDay.selected = YES;
        [_lessDay addTarget:self action:@selector(_switchDayNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _lessDay;
}

- (UIButton*)moreDay
{
    if (!_moreDay) {
        _moreDay = [UIButton new];
        [_moreDay setTitle:@"10天" forState:UIControlStateNormal];
        [_moreDay.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_moreDay setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_moreDay setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [_moreDay setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected|UIControlStateHighlighted];
        _moreDay.selected = NO;
        
        [_moreDay addTarget:self action:@selector(_switchDayNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreDay;
}

- (UIView*)onePixel
{
    if (!_onePixel) {
        _onePixel = [UIView new];
        _onePixel.backgroundColor = [UIColor whiteColor];
    }
    
    return _onePixel;
}


- (void)setExpand:(BOOL)expand
{
    if ([self.superview isMemberOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
        [(UITableView*)self.superview.superview beginUpdates];
        
        _expand = expand;
        self.layoutConstraintsIsCreated = NO;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [(UITableView*)self.superview.superview endUpdates];
    }
}
@end
