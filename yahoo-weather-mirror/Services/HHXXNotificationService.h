//
//  HHXXNotificationService.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHXXNotificationService: NSObject<UIApplicationDelegate>


+ (instancetype)sharedNotificationService;

- (void)startup;
@end
