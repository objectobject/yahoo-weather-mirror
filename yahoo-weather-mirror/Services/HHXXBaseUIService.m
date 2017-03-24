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
#import "HHXXViewControllerContainer.h"
#import "WeatherInformationViewController.h"
#import "YahooWeatherInformationViewController.h"

@interface HHXXBaseUIService()<HHXXSOAServiceDelegate>
@end

@implementation HHXXBaseUIService

HHXX_AUTO_REGISTER_SERVICE(HHXXBaseUIService)

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    HHXXViewControllerContainer* rootVC = [[HHXXViewControllerContainer alloc] initWithViewControllers:@[[ViewController new], [ViewController new], [ViewController new], [ViewController new], [ViewController new], [ViewController new], [ViewController new]]];
    
//    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WeatherInformationViewController new]];
//    UIViewController* rootVC = [[WeatherInformationViewController alloc] init];
//    HHXXViewControllerContainer* rootVC = [[HHXXViewControllerContainer alloc] initWithViewControllers:@[[YahooWeatherInformationViewController new], [ViewController new], [ViewController new], [ViewController new], [ViewController new], [ViewController new], [ViewController new]]];
    
//    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WeatherInformationViewController new]];
    YahooWeatherInformationViewController* rootVC = [[YahooWeatherInformationViewController alloc] init];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    application.delegate.window = window;
    [application.delegate.window makeKeyAndVisible];
    return YES;
}
@end
