//
//  HHXXAbstractApiManager.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/29.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHXXNetworkingHead.h"


@interface HHXXAbstractApiManager : NSObject
@property (nonatomic, weak) id<HHXXNetworkingDelegate> delegate;
@property (nonatomic, weak) id<HHXXNetworkingDataSource> dataSource;
@property (nonatomic, strong) id responseData;
@property (nonatomic, assign) HHXXResponseType responseDataType;

- (NSUInteger)hhxxFetchData;
- (id)hhxxFetchDataWithFiltrator:(id<HHXXNetworkingDataFiltrator>)filtrator;
- (NSUInteger)hhxxFetchDataWithParams:(NSDictionary*)params;
@end
