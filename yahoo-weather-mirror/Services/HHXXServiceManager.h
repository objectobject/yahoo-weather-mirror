//
//  HHXXServiceManager.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define HHXX_AUTO_REGISTER_SERVICE(name) \
+ (void)load \
{   \
    [[HHXXServiceManager sharedServiceManager] registerService:[name new]]; \
}   \
    \
- (NSString*)hhxxServiceName \
{   \
    return [NSString stringWithFormat:@"%@", [name class]]; \
}   \


@protocol HHXXSOAServiceDelegate <UIApplicationDelegate>

- (NSString*)hhxxServiceName;
@end

@interface HHXXServiceManager : NSObject

+ (instancetype)sharedServiceManager;

- (NSArray<id<HHXXSOAServiceDelegate>>*)allServices;
- (void)registerService:(id<HHXXSOAServiceDelegate>)service;

- (void)hhxxForwardInvocation:(NSInvocation *)anInvocation;
- (BOOL)hhxxCanRespondToSel:(SEL)aSelector;
@end
