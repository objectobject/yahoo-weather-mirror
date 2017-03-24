//
//  UIImage+Processing.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/23.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Processing)

- (UIImage*)hhxxScaleWithXRate:(CGFloat)xRate yRate:(CGFloat)yRate;
- (UIImage*)hhxxRotateWithOrientation:(UIImageOrientation)orientation;

@end
