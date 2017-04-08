//
//  HHXXWindmillView.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXWindmillView.h"
#import <Masonry.h>
#import "UIImage+Processing.h"

@interface HHXXWindmillView()
@property (nonatomic, strong) UIImageView* headerView;
@property (nonatomic, strong) UIImageView* bodyView;
@property (nonatomic, strong) CADisplayLink* displayLink;
@end

@implementation HHXXWindmillView

#pragma mark - private method
- (void)hhxxTick
{
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)_hhxxTick:(CADisplayLink*)displayLine
{
    CGAffineTransform oldTransform = self.headerView.transform;
    self.headerView.transform = CGAffineTransformRotate(oldTransform, M_PI * 2 / 300);
}

- (void)hhxx_createLayoutConstraints
{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(8);
    }];
    
    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_centerY).offset(4);
        make.bottom.equalTo(self).offset(-8).priority(999);
    }];
}


/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    [@[self.headerView, self.bodyView] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    
    //if view based frame, noted
    //    [self updateConstraintsIfNeeded];
    //    [self setNeedsUpdateConstraints];
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
- (CADisplayLink *)displayLink
{
    if (_displayLink) {
        [_displayLink invalidate];
    }
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_hhxxTick:)];
    _displayLink = displayLink;
    
    return _displayLink;
}


- (UIImageView*)bodyView
{
    if (_bodyView == nil)
    {
        _bodyView = [UIImageView new];
        _bodyView.image = [UIImage imageNamed:@"blade_body"];
        _bodyView.contentMode = UIViewContentModeScaleAspectFit;
        _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _bodyView;
}


- (void)setScaleValue:(CGFloat)scaleValue
{
    _bodyView.image = [[_bodyView image] hhxxScaleWithXRate:scaleValue yRate:scaleValue];
    _headerView.image = [[_headerView image] hhxxScaleWithXRate:scaleValue yRate:scaleValue];
    _scaleValue = scaleValue;
    
    [self setNeedsDisplay];
}


- (UIImageView*)headerView
{
    if (_headerView == nil)
    {
        _headerView = [UIImageView new];
        _headerView.image = [UIImage imageNamed:@"blade_head"];
        _headerView.contentMode = UIViewContentModeScaleAspectFit;
        _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _headerView;
}
@end
