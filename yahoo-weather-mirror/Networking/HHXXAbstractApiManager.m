//
//  HHXXAbstractApiManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/29.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXAbstractApiManager.h"
#import "HHXXNetworkingHead.h"
#import "HHXXNetworkingResponse.h"
#import "HHXXNetworkingProxyUseAF.h"


@interface HHXXAbstractApiManager()

@property (nonatomic, weak) id<HHXXNetworkingApiProtocol> child;
@property (nonatomic, strong) id<HHXXNetworkingProxyProtocol> networkingProxy;
@property (nonatomic, weak) id<HHXXNetworkingRequestParamsValidator> validator;
@end

@implementation HHXXAbstractApiManager


//+ (instancetype)shareNetworkingApiManager
//{
//    static HHXXAbstractApiManager* api = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        api = [HHXXAbstractApiManager new];
//    });
//    
//    return api;
//}

- (id<HHXXNetworkingProxyProtocol>)networkingProxy
{
    if (!_networkingProxy) {
        _networkingProxy = [[HHXXNetworkingProxyUseAF alloc] init];
    }
    
    return _networkingProxy;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSParameterAssert([self conformsToProtocol:@protocol(HHXXNetworkingApiProtocol)]);
        self.child = (id<HHXXNetworkingApiProtocol>)self;
        self.delegate = nil;
        self.validator = nil;
        self.dataSource = nil;
        self.responseData = nil;
        
        // 指定返回给delegate处理的数据类型
        self.responseDataType = HHXXResponseJSONObject;
    }
    
    return self;
}


- (void)setResponseData:(id)responseData
{
    HHXXNetworkingResponse* response = responseData;
    switch (self.responseDataType) {
        case HHXXResponseData:
            _responseData = [response.rawResponseData copy];
            break;
            
        case HHXXResponseString:
            _responseData = [response.rawResponseString copy];
            break;
            
        case HHXXResponseJSONObject:
            _responseData = [response.rawJSONObject copy];
            break;
            
        default:
            _responseData = [response.rawResponseData copy];
            break;
    }
}


- (void)_hhxxFetchDataSuccess:(HHXXNetworkingResponse*)response
{
    self.responseData = response;
    if (self.delegate) {
        [self.delegate hhxxCallApiSuccess:self];
    }
    NSLog(@"Scuess: %@", response);
}

- (void)_hhxxFetchDataFailed:(HHXXNetworkingResponse*)response
{
    self.responseData = response;
    
    if (self.delegate) {
        [self.delegate hhxxCallApiFailed:self];
    }
}


- (NSUInteger)hhxxFetchData
{
    NSParameterAssert(self.dataSource);
    return [self hhxxFetchDataWithParams:[self.dataSource hhxxRequestParamsForApi:self]];
}


- (NSUInteger)hhxxFetchDataWithParams:(NSDictionary*)params
{
    if (self.validator && ![self.validator hhxxManager:self isCorrectWithRequestParams:params]) {
        NSLog(@"请求网络参数验证不通过!!请求参数为:\r\n%@", params);
        return -1;
    }
    
    HHXXRequestMethod requestMethod = [self.child hhxxMethodType];
    NSString* serviceName = [self.child hhxxNetworkingServiceID];
    NSString* requestPath = [self.child hhxxRequestPath];
    
    NSUInteger requestID = -1;
    
    switch (requestMethod) {
        case HHXXRequestMethodGET:
        {
            __weak typeof(self) weakSelf = self;
            requestID = [self.networkingProxy hhxxGetNetworkingWithServiceID:serviceName methodName:requestPath requestParams:params success:^(HHXXNetworkingResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf _hhxxFetchDataSuccess:response];
            } failed:^(HHXXNetworkingResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf _hhxxFetchDataFailed:response];
            }];
        }
            break;
        
        case HHXXRequestMethodPOST:
        {
            __weak typeof (self) weakSelf = self;
            requestID = [self.networkingProxy hhxxGetNetworkingWithServiceID:serviceName methodName:requestPath requestParams:params success:^(HHXXNetworkingResponse *response) {
                __strong typeof (weakSelf) strongSelf = weakSelf;
                [strongSelf _hhxxFetchDataSuccess:response];
            } failed:^(HHXXNetworkingResponse *response) {
                __strong typeof (weakSelf) strongSelf = weakSelf;
                [strongSelf _hhxxFetchDataFailed:response];
            }];
        }
            break;

        case HHXXRequestMethodHEAD:
        {
            NSLog(@"请求数据方式[HHXXRequestMethodHEAD]还没定义!!");
        }
            break;
            
        case HHXXRequestMethodPUT:
        {
            NSLog(@"请求数据方式[HHXXRequestMethodPUT]还没定义!!");
        }
            break;
            
        case HHXXRequestMethodDELETE:
        {
            NSLog(@"请求数据方式[HHXXRequestMethodDELETE]还没定义!!");
        }
            break;
        
        default:
            NSLog(@"请求数据方式还没定义!!");
            break;
    }
    
    return requestID;
}


- (id)hhxxFetchDataWithFiltrator:(id<HHXXNetworkingDataFiltrator>)filtrator{
    id resultData = nil;
    if ([filtrator respondsToSelector:@selector(hhxxManager:filterData:)]) {
        resultData = [filtrator hhxxManager:self filterData:self.responseData];
    }else{
        resultData = self.responseData;
    }
    
    return resultData;
}
@end
