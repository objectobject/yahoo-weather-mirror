//
//  HHXXAutoLayoutView.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXAutoLayoutView.h"

@implementation HHXXAutoLayoutView


+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)configureWithModel:(id)model
{
    
}

- (void)updateConstraints
{
    if (!_layoutConstraintsIsCreated) {
        [self hhxx_createLayoutConstraints];
        _layoutConstraintsIsCreated = YES;
    }
    [super updateConstraints];
}


- (void)hhxx_createLayoutConstraintsIfNeed
{
    if (!_layoutConstraintsIsCreated) {
        [self hhxx_createLayoutConstraints];
        _layoutConstraintsIsCreated = YES;
    }
}


- (void)hhxx_createLayoutConstraints
{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//+ (BOOL)requiresConstraintBasedLayout
//{
//    return YES;
//}
//
//
//- (void)updateConstraints
//{
//    if (!_layoutConstraintsIsCreated) {
//        [self hhxx_createLayoutConstraints];
//    }
//    [super updateConstraints];
//}
//
//
//- (void)hhxx_createLayoutConstraintsIfNeed
//{
//    if (!_layoutConstraintsIsCreated) {
//        [self hhxx_createLayoutConstraints];
//        _layoutConstraintsIsCreated = NO;
//    }
//}
//
//
//- (void)hhxx_createLayoutConstraints
//{
//    
//}
//
//
///**
// *  初始化各种子视图
// */
//- (void)commonInit
//{
//    [@[] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self addSubview:obj];
//    }];
//    
//    //if view based frame, noted
//    //    [self updateConstraintsIfNeeded];
//    //    [self setNeedsUpdateConstraints];
//}



#pragma mark - init function

/* 如果是UITableViewCell或者是UICollectionViewCell的话就需要把下面的初始化函数用上
 */
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self)
//    {
//        [self commonInit];
//    }
//    
//    return self;
//}
//
//
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


- (void)commonInit
{
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}


@end
