//
//  HHXXViewControllerTransitioningContext.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/5.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HHXXViewControllerTranstitionCompleteBlock)(BOOL);


@interface HHXXViewControllerTransitioningContext : NSObject<UIViewControllerContextTransitioning>

@property (nonatomic, assign) BOOL isInteractive;
@property (nonatomic, copy) HHXXViewControllerTranstitionCompleteBlock completeBlock;

- (instancetype)initWithFromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController;

@end
