//
//  HHXXNetworkingURLRequestGenerator.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/13.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingURLRequestGenerator.h"

@implementation HHXXNetworkingURLRequestGenerator

+ (instancetype)sharedNetworkingURLRequestGenerator
{
    static dispatch_once_t onceToken;
    static HHXXNetworkingURLRequestGenerator* _generator = nil;
    dispatch_once(&onceToken, ^{
        _generator = [HHXXNetworkingURLRequestGenerator new];
    });
    
    return _generator;
}
@end
