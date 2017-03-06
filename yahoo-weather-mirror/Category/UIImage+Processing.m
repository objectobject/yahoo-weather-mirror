//
//  UIImage+Processing.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "UIImage+Processing.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation UIImage (Processing)

- (UIImage*)hhxxScaleWithXRate:(CGFloat)xRate yRate:(CGFloat)yRate
{
    NSAssert(xRate > 0 && yRate > 0 , @"scale rate must a positive number!");
    
    CGSize newSize = CGSizeMake(self.size.width * xRate, self.size.height * yRate);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



- (UIImage*)hhxxRotateWithOrientation:(UIImageOrientation)orientation
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (orientation)
    {
        case UIImageOrientationLeft:
            CGContextRotateCTM(context, -90);
            break;
            
        case UIImageOrientationUp:
            CGContextRotateCTM(context, -90);
            break;
            
        case UIImageOrientationRight:
            CGContextRotateCTM(context, -90);
            break;
            
        default:
            break;
    }
    
    //绘制在坐标系上,选旋转过的.
    [self drawAtPoint:CGPointMake(0, 0)];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}
@end

