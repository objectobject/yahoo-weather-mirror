//
//  TableViewCellForCurrentPosition.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "TableViewCellForCurrentPosition.h"

@interface TableViewCellForCurrentPosition()
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UISwitch* switcher;
@end

@implementation TableViewCellForCurrentPosition

- (void)hhxx_createLayoutConstraints
{
    
}

/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    [@[] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    
    //if view based frame, noted
    
    //    [self setNeedsUpdateConstraints];
    //    [self updateConstraintsIfNeeded];
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


- (void)awakeFromNib
{
    [super awakeFromNib];
}


@end
