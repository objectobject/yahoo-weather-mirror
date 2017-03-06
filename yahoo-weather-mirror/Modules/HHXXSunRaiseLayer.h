//
//  HHXXSunRaiseLayer.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/24.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HHXXSunRaiseLayer : CALayer
@property (nonatomic, copy) NSString* sunraiseTime;
@property (nonatomic, copy) NSString* sunsetTime;

@property (nonatomic, assign, readonly) CGPoint startPoint;
@property (nonatomic, assign, readonly) CGPoint endPoint;
@property (nonatomic, assign, readonly) CGFloat radius;
@property (nonatomic, assign) CGFloat lineLength;
@property (nonatomic, assign) CGFloat sunsetRateValue;
@end
