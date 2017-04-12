//
//  HHXXSliderAnimator.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/12.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHXXSliderAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isDismiss;

- (instancetype)initWithDismiss:(BOOL)isDismiss;
@end
