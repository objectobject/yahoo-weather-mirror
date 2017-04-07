//
//  HHXXNetworkingResponse.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHXXNetworkingResponse : NSObject

@property (nonatomic, copy, readonly) NSString* rawResponseString;
@property (nonatomic, copy, readonly) NSData* rawResponseData;
@property (nonatomic, copy, readonly) id rawJSONObject;
@property (nonatomic, assign, readonly) NSInteger requestID;
@property (nonatomic, strong, readonly) NSURLRequest* request;
@property (nonatomic, copy, readonly) NSString* responseErrorMsg;

- (instancetype)initWithRequest:(NSURLRequest*)request requestID:(NSInteger)requestID responseObject:(id)responseObject error:(NSError*)error;
@end
