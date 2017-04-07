//
//  HHXXBingImageApiManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/7.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXBingImageApiManager.h"
#import <UIKit/UIKit.h>

@implementation HHXXBingImageApiManager

- (HHXXRequestMethod)hhxxMethodType
{
    return HHXXRequestMethodGET;
}

- (NSString*)hhxxRequestPath
{
    return @"/v1";
}

- (NSString*)hhxxNetworkingServiceID
{
    return @"HHXXNetworkingServiceForBingImage";
}

@end
