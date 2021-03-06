//
//  HHXXBaseUIService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/22.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXBaseUIService.h"
#import "HHXXServiceManager.h"
#import "HHXXViewControllerContainer.h"
#import "YahooWeatherInformationViewController.h"
#import "HHXXViewControllerContainer+Private.h"
#import "HHXXCityManager.h"

@interface HHXXBaseUIService()<HHXXSOAServiceDelegate>
@end

@implementation HHXXBaseUIService

HHXX_AUTO_REGISTER_SERVICE(HHXXBaseUIService)

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSMutableArray* allVC = [NSMutableArray array];
    [[HHXXCityManager sharedCityManager].allCitys enumerateObjectsUsingBlock:^(HHXXCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [allVC addObject:({
            [YahooWeatherInformationViewController new];
        })];
    }];
    HHXXViewControllerContainer* rootVC = [[HHXXViewControllerContainer alloc] initWithViewControllers:allVC];
    
//    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    window.rootViewController = rootVC;
    application.delegate.window = window;
    [application.delegate.window makeKeyAndVisible];
    return YES;
}
@end
