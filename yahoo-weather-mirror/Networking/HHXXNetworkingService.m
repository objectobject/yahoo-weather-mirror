//
//  HHXXNetworkingService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingService.h"


@interface HHXXNetworkingServiceFactory()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<HHXXNetworkingServiceProtocol>>* services;
@end

@implementation HHXXNetworkingServiceFactory

#pragma mark - getter and setter
- (NSMutableDictionary<NSString *,id<HHXXNetworkingServiceProtocol>> *)services
{
    if (_services == nil) {
        _services = [NSMutableDictionary dictionary];
    }
    
    return _services;
}

+ (instancetype)networkingServiceFactory
{
    static HHXXNetworkingServiceFactory* networkingServiceFactory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkingServiceFactory = [HHXXNetworkingServiceFactory new];
    });
    
    return networkingServiceFactory;
}


- (void)registerService:(id)networkingService
{
    [self.services setObject:networkingService forKey:NSStringFromClass([networkingService class])];
}

- (id<HHXXNetworkingServiceProtocol>)networkingServiceWithName:(NSString*)serviceName
{
    if ([[self.services allKeys] containsObject:serviceName]) {
        return self.services[serviceName];
    }else{
        NSLog(@"该网络服务[%@]没有注册,请先注册再使用!", serviceName);
    }
    return nil;
}

@end

@interface HHXXNetworkingService()
@property (nonatomic, weak) id<HHXXNetworkingServiceProtocol> child;
@end

@implementation HHXXNetworkingService

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSParameterAssert([self conformsToProtocol:@protocol(HHXXNetworkingServiceProtocol)]);
        self.child = (id<HHXXNetworkingServiceProtocol>)self;
    }
    
    return self;
}
@end
