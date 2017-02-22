//
//  HHXXNotificationService.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HHXXServiceManager.h"

@interface HHXXNotificationService: NSObject<HHXXSOAServiceDelegate>


+ (instancetype)sharedNotificationService;

- (void)startup;
@end
