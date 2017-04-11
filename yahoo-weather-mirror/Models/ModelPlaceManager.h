//
//  ModelPlaceManager.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ModelPlace;

@interface ModelPlaceManager : NSObject
@property (nonatomic, assign) NSUInteger count;
// 客户端没有使用这个字段,暂时不格式化
@property (nonatomic, strong) NSString* created;
@property (nonatomic, copy) NSArray<ModelPlace*>* place;


@end


// yahoo 相关的API很坑,当只有一个查询信息的时候就不传回数组了.
@interface ModelPlaceManagerWithOnePlace : NSObject
@property (nonatomic, assign) NSUInteger count;
// 客户端没有使用这个字段,暂时不格式化
@property (nonatomic, strong) NSString* created;
@property (nonatomic, strong) ModelPlace* place;
@end
