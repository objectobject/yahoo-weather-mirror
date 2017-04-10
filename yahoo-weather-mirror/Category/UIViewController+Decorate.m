//
//  UIViewController+Decorate.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "UIViewController+Decorate.h"

@implementation UIViewController (Decorate)


+ (UINavigationController*)viewControllerContainerWithNavigationController
{
    return [[UINavigationController alloc] initWithRootViewController:[self new]];
}

@end
