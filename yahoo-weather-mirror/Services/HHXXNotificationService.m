//
//  HHXXNotificationService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNotificationService.h"
#import "HHXXServiceManager.h"

@implementation HHXXNotificationService

HHXX_AUTO_REGISTER_SERVICE(HHXXNotificationService)

+ (instancetype)sharedNotificationService
{
    
    static HHXXNotificationService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[HHXXNotificationService alloc] init];
    });
    
    
    return service;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self startup];
    
    return YES;
}

- (void)startup
{
    NSLog(@"app start up!!");
}
@end
