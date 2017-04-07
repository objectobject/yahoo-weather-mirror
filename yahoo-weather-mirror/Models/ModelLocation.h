//
//  ModelLocation.h
//  oc_like_yahoo_weather
//
//  Created by as4 on 16/6/9.
//  Copyright © 2016年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelLocation : NSObject

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString* region;

@property (nonatomic, assign) NSString* jingDu;

@property (nonatomic, assign) NSString* weiDu;
@end

