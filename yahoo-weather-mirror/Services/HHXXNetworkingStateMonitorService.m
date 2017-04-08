//
//  HHXXNetworkingStateMonitorService.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/31.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingStateMonitorService.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "HHXXNetworkingService.h"
#import "HHXXNetworkingServiceForBingImage.h"

@interface HHXXNetworkingStateMonitorService()

@property (nonatomic, strong) MBProgressHUD* hub;
@end

@implementation HHXXNetworkingStateMonitorService

HHXX_AUTO_REGISTER_SERVICE(HHXXNetworkingStateMonitorService)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    AFNetworkReachabilityManager* mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                if (_hub) {
                    [_hub hideAnimated:YES afterDelay:1.0];
                    _hub = nil;
                }
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                if (!_hub) {
                    _hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
                    [_hub removeFromSuperViewOnHide];
                }
                [_hub.label setText:@"当前网络不可用，请仔细检查!"];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (_hub) {
                    [_hub hideAnimated:YES afterDelay:1.0];
                    _hub = nil;
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (_hub) {
                    [_hub hideAnimated:YES afterDelay:1.0];
                    _hub = nil;
                }
                break;
                
            default:
                if (_hub) {
                    [_hub hideAnimated:YES afterDelay:1.0];
                    _hub = nil;
                }
                break;
        }
    }];
    [mgr startMonitoring];
    return YES;
}
@end
