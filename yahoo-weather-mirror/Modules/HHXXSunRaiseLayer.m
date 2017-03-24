//
//  HHXXSunRaiseLayer.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/24.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXSunRaiseLayer.h"
#import <UIKit/UIKit.h>
#import "UIColor+Provider.h"

@interface HHXXSunRaiseLayer()
@property (nonatomic, assign, readwrite) CGPoint startPoint;
@property (nonatomic, assign, readwrite) CGPoint endPoint;
@property (nonatomic, strong) UIImage* sunImage;
@property (nonatomic, assign) CGMutablePathRef sunPath;

@property (nonatomic, assign, readwrite) CGFloat radius;
@end

@implementation HHXXSunRaiseLayer
@dynamic sunraiseTime, sunsetTime, sunsetRateValue;

- (UIImage *)sunImage
{
    if (!_sunImage) {
        _sunImage = [UIImage imageNamed:@"sun"];
    }
    
    return _sunImage;
}


+ (NSArray*)propertyNeedDisplay
{
    return @[@"lineLength", @"sunsetTime", @"sunraiseTime", @"sunsetRateValue"];
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([[HHXXSunRaiseLayer propertyNeedDisplay] containsObject:key]) {
        return YES;
    }
    
    
    return [super needsDisplayForKey:key];
}



//
- (id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"sunsetRateValue"])
    {
        CABasicAnimation* animation = [CABasicAnimation animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fromValue = @([self presentationLayer].sunsetRateValue);
        animation.duration = 2.0f;
        return animation;
    }
    return [super actionForKey:event];
}


- (void)display
{
    //           _
    //         _   _
    //       _       _
    //      |         |
    //      |         |
    //    --o---------o--[40, self.bounds.size.height - 32 - 4] [40 + ]
    _radius = self.bounds.size.height - 32.0f - 8.0f;
    CGFloat yValue = self.bounds.size.height - 32.0f;
    CGFloat xStartValue = 8 + 32;
    CGFloat lengths[] = {2, 4};
    _startPoint = CGPointMake(xStartValue - 2, yValue - 2);
    _endPoint = CGPointMake(xStartValue + 2 * _radius - 2, yValue - 2);
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 底边直线
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextMoveToPoint(ctx, 8, yValue);
    CGContextAddLineToPoint(ctx, self.lineLength - 8, yValue);
    CGContextStrokePath(ctx);

    // 左边圆弧起点
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextAddEllipseInRect(ctx, CGRectMake(_startPoint.x, _startPoint.y, 4, 4));
    CGContextDrawPath(ctx, kCGPathFillStroke);

    // 右边圆弧起点
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextAddEllipseInRect(ctx, CGRectMake(_endPoint.x, _endPoint.y, 4, 4));
    CGContextDrawPath(ctx, kCGPathFillStroke);

    // 半圆弧
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextSetLineDash(ctx, 0, lengths, 2);
    CGContextAddArc(ctx, xStartValue + _radius, yValue, _radius, 0, M_PI, 1);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    // 日出,日落时间
    if (self.sunraiseTime)
    {
        [self.sunraiseTime drawAtPoint:CGPointMake(xStartValue - 4 - 16, yValue - 4 + 8) withAttributes:@
         {
         NSFontAttributeName:[UIFont systemFontOfSize:12],
         NSForegroundColorAttributeName: [UIColor whiteColor]
         }];
    }
    
    if (self.sunsetTime)
    {
        [self.sunsetTime drawAtPoint:CGPointMake(xStartValue + 2 * _radius - 4 - 16, yValue - 4 + 8) withAttributes:@
         {
         NSFontAttributeName:[UIFont systemFontOfSize:12],
         NSForegroundColorAttributeName: [UIColor whiteColor]
         }];
    }

    // 绘制动画轨迹
    CGFloat xValue = _radius * [self presentationLayer].sunsetRateValue * 2 + _startPoint.x;
    CGPoint centerPoint = CGPointMake(xStartValue + _radius - 2, yValue - 2);
    // 公式
    // x = a + rcos
    // y = b + rsin
    // cos^2 + sin^2 = 2
    
    CGFloat cosValue = (xValue - centerPoint.x) / _radius;
    CGFloat sinValue = sqrt(1 - pow(cosValue, 2));
    CGFloat newYValue = centerPoint.y + _radius * sinValue;
    CGFloat endAngle = (xValue > centerPoint.x)? M_PI - asin(sinValue): asin(sinValue);
    if (self.sunImage)
    {
        CGContextDrawImage(ctx, CGRectMake(xValue - 4, - newYValue + 2 * centerPoint.y - 4, 12, 12), self.sunImage.CGImage);
        
        CGContextSetLineWidth(ctx, 1.0f);
        CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
        CGContextMoveToPoint(ctx, _startPoint.x, _startPoint.y + 2);
        CGContextAddArc(ctx, centerPoint.x, centerPoint.y, _radius - 3, M_PI, M_PI + endAngle, NO);
        CGContextAddLineToPoint(ctx, xValue, centerPoint.y + 2);
        CGContextFillPath(ctx);
    }
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    self.contents = (__bridge id _Nullable)(image.CGImage);
    UIGraphicsEndImageContext();
}


@end

