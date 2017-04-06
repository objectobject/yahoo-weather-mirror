//
//  HHXXNetworkingServiceForBingImage.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHXXNetworkingService.h"

@interface HHXXNetworkingServiceForBingImage: HHXXNetworkingService<HHXXNetworkingServiceProtocol>

- (NSString*)hhxxNetworkingServiceName;
- (NSString*)hhxxBaseURLForService;
@end
