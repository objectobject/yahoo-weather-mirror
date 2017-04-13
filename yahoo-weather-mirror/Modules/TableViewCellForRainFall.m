//
//  TableViewCellForRainFall.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForRainFall.h"
#import <Masonry.h>
#import "HHXXUIKitMacro.h"
#import "UIView+Border.h"
#import "NSAttributedString+Attachment.h"
#import "YahooWeatherItemKey.h"
#import "UITableViewCell+EnableDrag.h"


@interface TableViewCellForRainFall()
@property (nonatomic, strong) UIView* headArea;
@property (nonatomic, strong) UIView* borderView;
@property (nonatomic, strong) UIStackView* bodyArea;
//@property (nonatomic, strong) UIView* bodyArea;

// 头部
@property (nonatomic, strong) UILabel* cellTitle;
@property (nonatomic, strong) UIImageView* typeImage;

// 为了学习UIStackView直接用UIStackView实现
@property (nonatomic, strong) NSMutableArray<UILabel*>* rainFallDetail;
@end

@implementation TableViewCellForRainFall

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
        make.top.equalTo(self.borderView.mas_bottom).mas_offset(kHHXXVPadding);
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
    
    // 详细布局
//    __block UILabel* preLabel = nil;
//    [self.rainFallDetail enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(self.bodyArea).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//            if(preLabel){
//                make.left.equalTo(preLabel.mas_right);
//                make.width.equalTo(preLabel.mas_width);
//            }else{
//                make.left.equalTo(self.bodyArea);
//            }
//            if (idx == [self.rainFallDetail count] - 1) {
//                make.right.equalTo(self.bodyArea);
//            }
//            
//            preLabel = obj;
//        }];
//    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.rainFallDetail enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx != [self.rainFallDetail count] - 1)
        {
            [obj hhxxAddBorderWithColor:[UIColor grayColor] borderWidth:1.0 borderStyle:HHXXBorderStyleRight|HHXXBorderStyleDashed];
        }
    }];
}

- (void)configureWithModel:(id)model
{
    [self.cellTitle setText:@"降雨量"];
    
    NSArray<NSString*> *keysForTimes = @[kHHXXYahooWeatherItemKey_RainFallTitle0, kHHXXYahooWeatherItemKey_RainFallTitle1, kHHXXYahooWeatherItemKey_RainFallTitle2, kHHXXYahooWeatherItemKey_RainFallTitle3];
    NSArray<NSString*> *keysForValues = @[kHHXXYahooWeatherItemKey_RainFallValue0, kHHXXYahooWeatherItemKey_RainFallValue1, kHHXXYahooWeatherItemKey_RainFallValue2, kHHXXYahooWeatherItemKey_RainFallValue3];
    
    [self.rainFallDetail enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* title = [keysForTimes objectAtIndex:idx];
        NSString* value = [keysForValues objectAtIndex:idx];
        
        [obj setAttributedText:[self _hhxxCreateRainFallAttributeString:model[title] rainFallValue:model[value] rainFallString:[NSString stringWithFormat:@"rain_ico_%@", model[value]]]];
    }];
}


- (NSAttributedString*)_hhxxCreateRainFallAttributeString:(NSString*)time rainFallValue:(id)rainFallValue rainFallString:(NSString*)rainFallString
{
    NSMutableAttributedString* tempRainFallString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\r\n", time]];
    
    [tempRainFallString appendAttributedString:[NSAttributedString clearAttributeStringWithTransparenceImageName:@"translucent" size:CGSizeMake(8, 8)]];
    [tempRainFallString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r\n"]];
    
    [tempRainFallString appendAttributedString:[NSAttributedString attributedStringWithAttachment:({
        NSTextAttachment* attachment = [NSTextAttachment new];
        attachment.image = [UIImage imageNamed:rainFallString];
        attachment.bounds = CGRectMake(0, 0, 18, 23.5);// 1.3的倍率
        attachment;
    })]];
    
    [tempRainFallString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r\n"]];
    [tempRainFallString appendAttributedString:[NSAttributedString clearAttributeStringWithTransparenceImageName:@"translucent" size:CGSizeMake(8, 8)]];
    
    [tempRainFallString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\r\n%@%%", rainFallValue]]];
    [tempRainFallString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, time.length)];
    return [tempRainFallString copy];
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
    
    [self.headArea addSubview:self.cellTitle];
    [self.headArea addSubview:self.typeImage];
    [self.rainFallDetail enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.bodyArea addSubview:obj];
        [self.bodyArea addArrangedSubview:obj];
    }];
    
    [self configureWithModel:nil];
    //if view based frame, noted
    self.typeImage.userInteractionEnabled = YES;
    [self.typeImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxTouchCell:)]];

    //    [self updateConstraintsIfNeeded];
    //    [self setNeedsUpdateConstraints];
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


- (UIStackView*)bodyArea
{
    if (!_bodyArea) {
        _bodyArea = [UIStackView new];
        _bodyArea.backgroundColor = [UIColor clearColor];
        _bodyArea.axis = UILayoutConstraintAxisHorizontal;
        _bodyArea.distribution = UIStackViewDistributionFillEqually;
#ifdef DEBUG
        //无效
        _bodyArea.backgroundColor = [UIColor redColor];
#endif
    }
    return _bodyArea;
}

//- (UIView*)bodyArea
//{
//    if (!_bodyArea) {
//        _bodyArea = [UIView new];
//        _bodyArea.backgroundColor = [UIColor clearColor];
//    }
//    return _bodyArea;
//}


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

- (NSMutableArray<UILabel *> *)rainFallDetail
{
    if (!_rainFallDetail) {
        _rainFallDetail = [NSMutableArray arrayWithCapacity:4];
        for (NSUInteger index = 0; index < 4; index++) {
            [_rainFallDetail addObject:({
                UILabel *_rainFallOne = [UILabel new];
                [_rainFallOne setTextColor:FONT_COLOR];
                _rainFallOne.numberOfLines = 0;
                _rainFallOne.backgroundColor = [UIColor clearColor];
                _rainFallOne.lineBreakMode = NSLineBreakByWordWrapping;
                [_rainFallOne setTextAlignment:NSTextAlignmentCenter];
                
//                if (index == 0) {
//                    [_rainFallOne hhxxAddBorderWithColor:[UIColor whiteColor] borderWidth:1.0 borderStyle:HHXXBorderStyleLeft|HHXXBorderStyleDashed];
//                }
//                [_rainFallOne hhxxAddBorderWithColor:[UIColor whiteColor] borderWidth:1.0 borderStyle:HHXXBorderStyleRight|HHXXBorderStyleDashed];
//                
                _rainFallOne;
            })];
        }
    }
    
    return _rainFallDetail;
}
@end

