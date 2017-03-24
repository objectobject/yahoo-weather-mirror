//
//  UIView+Border.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/9.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "UIView+Border.h"

static NSString * const kBorderName = @"HHXX_BORDER_NAME";

@implementation UIView (Border)


- (void)hhxxAddBorderWithColor:(UIColor*)borderColor borderWidth:(NSInteger)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}


/**
 *  对视图添加对应的边框，可以通过位预算传递组合的边框类型。例如：HHXXBorderTop|HHXXBorderLeft
 *
 *  @param borderStyle 边框类型
 *  @param borderColor 边框颜色
 *  @param borderWidth 边框宽度
 */
- (void)hhxxAddBorderWithColor:(UIColor*)borderColor borderWidth:(NSInteger)borderWidth borderStyle:(HHXXBorderStyle)borderStyle
{
    BOOL hasDashedAndAllBorder = (!(borderStyle & HHXXBorderStyleDashed)) && (borderStyle == HHXXBorderStyleAll);
    if(hasDashedAndAllBorder)
    {
        [self hhxxAddBorderWithColor:borderColor borderWidth:borderWidth borderStyle:borderStyle];
        return;
    }
    
    CGPoint pathPoints[4] = {
        CGPointZero,
        (CGPoint){0, self.bounds.size.height},
        (CGPoint){self.bounds.size.width, self.bounds.size.height},
        (CGPoint){self.bounds.size.width, 0}
    };
    
    BOOL borderFlags[4] = {
        (BOOL)(borderStyle & HHXXBorderStyleTop),
        (BOOL)(borderStyle & HHXXBorderStyleLeft),
        (BOOL)(borderStyle & HHXXBorderStyleBottom),
        (BOOL)(borderStyle & HHXXBorderStyleRight)
    };
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pathPoints[3]];
    for (NSInteger index = 0; index < 4; ++index)
    {
        if (borderFlags[index])
        {
            [path addLineToPoint:pathPoints[index]];
        }
        else
        {
            [path moveToPoint:pathPoints[index]];
        }
    }
    
    CAShapeLayer * borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.path = path.CGPath;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.lineWidth = borderWidth == 0 ? 0 : borderWidth;
    if (borderStyle & HHXXBorderStyleDashed)
    {
        borderLayer.lineDashPattern = @[@1, @1];
    }
    
    borderLayer.name = kBorderName;
    
    //特殊视图处理(UITableViewCell和UICollectionViewCell)
    if ([self isKindOfClass:[UITableViewCell class]] || [self isKindOfClass:[UICollectionViewCell class]])
    {
        UIView * view = [self valueForKeyPath:@"contentView"];
        UIView * borderView = [UIView new];
        
        [borderView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:kBorderName])
            {
                [obj removeFromSuperlayer];
                *stop = YES;
            }
        }];
        
        [borderView.layer addSublayer:borderLayer];
        [view addSubview:borderView];
    }
    else
    {
        [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:kBorderName])
            {
                [obj removeFromSuperlayer];
                *stop = YES;
            }
        }];
        [self.layer addSublayer:borderLayer];
    }
}
@end
