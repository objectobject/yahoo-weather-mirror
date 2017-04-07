//
//  HHXXNetworkingServiceForBingImage.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingServiceForBingImage.h"
#import "HHXXNetworkingHead.h"
#import "HHXXNetworkingService.h"

// https://github.com/xcss/bing
// API接口说明
// http://bing.ioliu.cn/v1
// 目前开放的壁纸接口：/v1{d,w,h,p,size,callback} 返回今日的壁纸完整数据



@implementation HHXXNetworkingServiceForBingImage

HHXX_AUTO_REGIST_NETWORKING_SERVICE(HHXXNetworkingServiceForBingImage)

- (NSString*)hhxxBaseURLForService
{
    return @"http://bing.ioliu.cn";
}
@end
