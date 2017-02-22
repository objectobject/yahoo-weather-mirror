//
//  HHXXBaseUIService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXBaseUIService.h"
#import "HHXXServiceManager.h"
#import "ViewController.h"

@interface HHXXBaseUIService()<HHXXSOAServiceDelegate>
@end

@implementation HHXXBaseUIService

HHXX_AUTO_REGISTER_SERVICE(HHXXBaseUIService)

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    NSLog(@"BASE UI");
    
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController* VC = [[ViewController alloc] init];
    VC.view.backgroundColor = [UIColor redColor];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
    
    
    application.delegate.window = window;
    [application.delegate.window makeKeyAndVisible];
    return YES;
}
@end
