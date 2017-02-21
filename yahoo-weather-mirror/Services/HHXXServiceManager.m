//
//  HHXXServiceManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXServiceManager.h"

@interface HHXXServiceManager()
{
    
}
@property (nonatomic, copy) NSMutableArray<id<UIApplicationDelegate>>* services;
@end

@implementation HHXXServiceManager


+ (instancetype)sharedServiceManager
{
    static HHXXServiceManager* manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HHXXServiceManager alloc] init];
    });
    
    return manager;
}


- (NSArray<id<UIApplicationDelegate>> *)allServices
{
    return [self.services copy];
}


- (void)registerService:(id)service
{
    if (service && ![_services containsObject:service]) {
        [_services addObject:service];
    }else{
        NSLog(@"register service failed.\r\n serverName:%@\r\n\r\n", [service respondsToSelector:@selector(serverName)]?[service performSelector:@selector(serviceName)]: [service class]);
    }
}


#pragma mark - setter and getter
- (instancetype)init
{
    self = [super init];
    if (self) {
        _services = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
