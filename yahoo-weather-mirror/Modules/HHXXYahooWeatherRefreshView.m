//
//  HHXXYahooWeatherRefreshView.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/18.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXYahooWeatherRefreshView.h"
#import <HHXXUIScrollViewPredefine.h>
#import <Masonry.h>
#import "HHXXUIKitMacro.h"

const CGFloat kHHXXRadiusValue = 10.0f;

@interface HHXXYahooWeatherRefreshView()
@property (nonatomic, strong) UILabel* lastUpdateTime;
@property (nonatomic, strong) UIImageView* logoImage;

@property (nonatomic, strong) UIView* animationView;
@property (nonatomic, strong) UIView* maskView;

@property (nonatomic, strong) CAShapeLayer* loadingLayer;
@property (nonatomic, strong) CAShapeLayer* willLoadingLayer;
@property (nonatomic, strong) CAShapeLayer* processLayer;
@end

@implementation HHXXYahooWeatherRefreshView
@synthesize state = _state;
@synthesize hhxxRefreshType = _hhxxRefreshType;



#pragma mark - setter and getter
- (CAShapeLayer *)loadingLayer
{
    if (!_loadingLayer) {
        _loadingLayer = [CAShapeLayer layer];
    }
    
    return _loadingLayer;
}

- (CAShapeLayer *)willLoadingLayer
{
    if (!_willLoadingLayer) {
        _willLoadingLayer = [CAShapeLayer layer];
    }
    
    return _willLoadingLayer;
}

- (UIView*)maskView
{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    }
    
    return _maskView;
}

- (UILabel *)lastUpdateTime
{
    if (!_lastUpdateTime) {
        _lastUpdateTime = [UILabel new];
        _lastUpdateTime.numberOfLines = 0;
        [_lastUpdateTime setFont:[UIFont systemFontOfSize:12]];
        [_lastUpdateTime setTextColor:FONT_COLOR];
    }
    return _lastUpdateTime;
}


- (UIView*)animationView
{
    if (!_animationView) {
        _animationView = [UIView new];
//        _animationView.backgroundColor = [UIColor redColor];
    }
    
    return _animationView;
}

- (CGFloat)hhxxHeight
{
    return kDefaultRefreshViewHeight;
}

- (UIImageView *)logoImage
{
    if (!_logoImage) {
        _logoImage = [UIImageView new];
        [_logoImage setImage:[UIImage imageNamed:@"yahoo_logo"]];
        _logoImage.contentMode = UIViewContentModeBottom;
    }
    return _logoImage;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kDefaultRefreshViewHeight);
        [self _commitInit];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // loading 动画
    {
        _loadingLayer.frame = self.animationView.bounds;
        CGPoint centerPoint = CGPointMake(self.animationView.bounds.size.width / 2, self.animationView.bounds.size.height / 2);
        [_loadingLayer addSublayer:({
            CAShapeLayer* circleLayer = [CAShapeLayer layer];
            circleLayer.strokeColor = [UIColor whiteColor].CGColor;
            circleLayer.lineWidth = 2.0f;
            circleLayer.fillColor = [UIColor clearColor].CGColor;
            UIBezierPath* path = [UIBezierPath bezierPath];
            [path addArcWithCenter:centerPoint radius:kHHXXRadiusValue startAngle:0 endAngle:M_PI * 2 clockwise:NO];
            circleLayer.path = path.CGPath;
            circleLayer;
        })];
        
        CAShapeLayer* xReplicatorLineLayer = ({
            CAShapeLayer* lineLayer = [CAShapeLayer layer];
            lineLayer.lineWidth = 2.0f;
            lineLayer.fillColor = [UIColor clearColor].CGColor;
            lineLayer.strokeColor = [UIColor whiteColor].CGColor;
            UIBezierPath* path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(centerPoint.x + 14, centerPoint.y)];
            [path addLineToPoint:CGPointMake(centerPoint.x + 18, centerPoint.y)];
            lineLayer.path = path.CGPath;
            
            [lineLayer addAnimation:({
                CABasicAnimation * animation = [CABasicAnimation animation];
                animation.keyPath = @"transform.scale.x";
                animation.fromValue = @1.0f;
                animation.toValue = @1.1f;
                animation.duration = 1.0f;
                animation.repeatCount = HUGE;
                animation.autoreverses = YES;
                animation;
            }) forKey:@""];
            lineLayer;
        });
        
        [_loadingLayer addSublayer:({
            CAReplicatorLayer* replicatorLayer = [CAReplicatorLayer layer];
            replicatorLayer.frame = self.animationView.bounds;
            replicatorLayer.instanceTransform = CATransform3DRotate(CATransform3DIdentity, M_PI / 3, 0, 0, 1);
            replicatorLayer.instanceCount = 6;
            replicatorLayer.instanceDelay = 0.2;
            [replicatorLayer addSublayer:xReplicatorLineLayer];
            replicatorLayer;
        })];
        
        CAShapeLayer* yReplicatorLineLayer = ({
            CAShapeLayer* lineLayer = [CAShapeLayer layer];
            lineLayer.lineWidth = 2.0f;
            lineLayer.fillColor = [UIColor clearColor].CGColor;
            lineLayer.strokeColor = [UIColor whiteColor].CGColor;
            UIBezierPath* path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(centerPoint.x, centerPoint.y + 14)];
            [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y + 18)];
            lineLayer.path = path.CGPath;
            
            [lineLayer addAnimation:({
                CABasicAnimation * animation = [CABasicAnimation animation];
                animation.beginTime = .5f;
                animation.duration = 1.0f;
                animation.keyPath = @"transform.scale.y";
                animation.fromValue = @1.0f;
                animation.toValue = @1.1f;
                animation.repeatCount = HUGE;
                animation.autoreverses = YES;
                animation;
            }) forKey:@""];
            lineLayer;
        });
        
        [_loadingLayer addSublayer:({
            CAReplicatorLayer* replicatorLayer = [CAReplicatorLayer layer];
            replicatorLayer.frame = self.animationView.bounds;
            replicatorLayer.instanceTransform = CATransform3DRotate(CATransform3DIdentity, M_PI / 3, 0, 0, 1);
            replicatorLayer.instanceCount = 6;
            [replicatorLayer addSublayer:yReplicatorLineLayer];
            replicatorLayer;
        })];
    }
    {
        
        _willLoadingLayer.frame = self.animationView.bounds;
        CGPoint centerPoint = CGPointMake(self.animationView.bounds.size.width / 2, self.animationView.bounds.size.height / 2);
        
        self.processLayer = ({
            CAShapeLayer* circleLayer = [CAShapeLayer layer];
            circleLayer.frame = self.willLoadingLayer.bounds;
            circleLayer.strokeColor = [UIColor whiteColor].CGColor;
            circleLayer.lineWidth = 2.0f;
            circleLayer.fillColor = [UIColor clearColor].CGColor;
            UIBezierPath* path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(centerPoint.x, centerPoint.y - kHHXXRadiusValue * 2)];
            [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y - kHHXXRadiusValue)];
            [path addArcWithCenter:centerPoint radius:kHHXXRadiusValue startAngle:1.5 * M_PI endAngle:3.5 * M_PI clockwise:YES];
            circleLayer.path = path.CGPath;
            circleLayer;
        });
        
        [_willLoadingLayer addSublayer:self.processLayer];
    }
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)_commitInit
{
    [self addSubview:self.maskView];
    [self addSubview:self.logoImage];
    [self addSubview:self.animationView];
    [self addSubview:self.lastUpdateTime];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
    }];
    
    [self.lastUpdateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastUpdateTime);
        make.bottom.equalTo(self.lastUpdateTime.mas_top);
        make.height.equalTo(self.lastUpdateTime);
        make.top.equalTo(self);
    }];
    
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lastUpdateTime.mas_left).offset(-16);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(kDefaultRefreshViewHeight - 16));
    }];
    [self.animationView.layer addSublayer:self.loadingLayer];
    [self.animationView.layer addSublayer:self.willLoadingLayer];
    
    self.loadingLayer.hidden = YES;
    self.willLoadingLayer.hidden = YES;
    [self configureModel:nil];
}


- (void)hhxxUpdateTime:(NSDate *)lastTime
{
    NSDateFormatter* timeFormatter = [NSDateFormatter new];
    timeFormatter.dateFormat = @"HH:MM:ss";
    [self.lastUpdateTime setText:[NSString stringWithFormat:@"最后更新时间:%@", [timeFormatter stringFromDate:lastTime]]];
}

- (void)configureModel:(id)model
{
    [self.lastUpdateTime setText:@"这是最后一次更新的时间"];
}



- (void)setState:(HHXXRefreshState)state
{
    _state = state;
}

- (HHXXRefreshState)state
{
    return _state;
}

- (void)setHhxxRefreshType:(HHXXRefreshType)hhxxRefreshType
{
    _hhxxRefreshType = hhxxRefreshType;
}

- (HHXXRefreshType)hhxxRefreshType
{
    return _hhxxRefreshType;
}


- (void)hhxxSetProgress:(CGFloat)progressValue withMaxValue:(CGFloat)maxValue
{
    self.loadingLayer.hidden = YES;
    self.willLoadingLayer.hidden = NO;
    self.processLayer.strokeEnd = progressValue / maxValue;
    self.processLayer.strokeStart = progressValue / maxValue - 0.85;
}

- (void)hhxxStopLoading
{
    self.loadingLayer.hidden = YES;
    self.willLoadingLayer.hidden = YES;
}

- (void)hhxxStartLoading
{
    self.loadingLayer.hidden = NO;
    self.willLoadingLayer.hidden = YES;
}
@end
