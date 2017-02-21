//
//  HHXXAMapService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXAMapService.h"

@implementation HHXXAMapService

+ (instancetype)sharedAMapService
{
    static HHXXAMapService* service;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[HHXXAMapService alloc] init];
    });
    
    
    return service;
}


- (NSString*)serverName
{
    return @"AMap";
}
@end
