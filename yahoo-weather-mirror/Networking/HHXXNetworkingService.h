//
//  HHXXNetworkingService.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHXXNetworkingHead.h"


@interface HHXXNetworkingServiceFactory : NSObject

+ (instancetype)networkingServiceFactory;
- (void)registerService:(id)networkingService;
- (id<HHXXNetworkingServiceProtocol>)networkingServiceWithName:(NSString*)serviceName;
@end


@interface HHXXNetworkingService : NSObject

- (instancetype)init;
@end
