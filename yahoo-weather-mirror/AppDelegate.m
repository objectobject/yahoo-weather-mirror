//
//  AppDelegate.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/20.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "AppDelegate.h"
#import "HHXXNotificationService.h"
#import "HHXXServiceManager.h"
#import "HHXXNotificationService.h"
#import "HHXXAMapService.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface AppDelegate ()
@property (nonatomic, strong) HHXXServiceManager* serverManager;
@end

@implementation AppDelegate


#pragma mark - setter and getter

- (HHXXServiceManager*)serverManager
{
    if (!_serverManager)
    {
        _serverManager = [HHXXServiceManager sharedServiceManager];
        
        //TODO: 这里添加各种功能服务
        [_serverManager registerService:[HHXXNotificationService sharedNotificationService]];
        [_serverManager registerService:[HHXXAMapService sharedAMapService]];
    }
    
    return _serverManager;
}


#pragma mark - application life cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    for (id<UIApplicationDelegate> service in self.serverManager.allServices) {
        
        // 暂时对于服务的返回值不处理
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
