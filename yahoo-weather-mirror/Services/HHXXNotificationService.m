//
//  HHXXNotificationService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNotificationService.h"

@implementation HHXXNotificationService


+ (instancetype)sharedNotificationService
{
    
    static HHXXNotificationService* service;
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
