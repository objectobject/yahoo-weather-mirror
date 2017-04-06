//
//  HHXXNetworkingHead.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/4.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#ifndef HHXXNetworkingHead_h
#define HHXXNetworkingHead_h
@class HHXXNetworkingResponse;
@class HHXXAbstractApiManager;

typedef NS_ENUM(NSUInteger, HHXXRequestMethod)
{
    HHXXRequestMethodNone = 0,
    HHXXRequestMethodGET,
    HHXXRequestMethodPOST,
    HHXXRequestMethodPUT,
    HHXXRequestMethodDELETE,
    HHXXRequestMethodHEAD
};

typedef void (^HHXXNetworkingSuccessBlock)(HHXXNetworkingResponse* response);
typedef void (^HHXXNetworkingFailedBlock)(HHXXNetworkingResponse* response);

// 网络代理协议
@protocol HHXXNetworkingProxyProtocol <NSObject>

@required
- (NSUInteger)hhxxNetworkingWithRequest:(NSURLRequest*)request success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed;

- (NSUInteger)hhxxGetNetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed;

- (NSUInteger)hhxxPOSTNetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed;

@optional
- (NSUInteger)hhxxPUTNetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed;
- (NSUInteger)hhxxDELETENetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed;
- (NSUInteger)hhxxHEADNetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed;
@end


#define HHXX_AUTO_REGIST_NETWORKING_SERVICE(name) \
+ (void)load \
{   \
[[HHXXNetworkingServiceFactory networkingServiceFactory] registerService:[name shareNetworkingService]]; \
}   \
\
+ (instancetype)shareNetworkingService\
{\
    static name* _service;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _service = [name new];\
    });\
\
    return _service;\
}\
\
- (NSString*)hhxxNetworkingServiceName \
{   \
return [NSString stringWithFormat:@"%@", [name class]]; \
}   \


// 网络服务协议
@protocol HHXXNetworkingServiceProtocol <NSObject>
- (NSString*)hhxxNetworkingServiceName;
- (NSString*)hhxxBaseURLForService;
@end


// 网络请求API协议
@protocol HHXXNetworkingApiProtocol <NSObject>

- (HHXXRequestMethod)hhxxMethodType;
- (NSString*)hhxxRequestPath;
- (NSString*)hhxxNetworkingServiceID;
@end


// 网络请求回调
@protocol HHXXNetworkingDelegate <NSObject>
- (void)hhxxCallApiSuccess:(HHXXAbstractApiManager*)mgr;
- (void)hhxxCallApiFailed:(HHXXAbstractApiManager*)mgr;
@end

@protocol HHXXNetworkingDataSource <NSObject>
- (NSDictionary*)hhxxRequestParamsForApi:(HHXXAbstractApiManager*)mgr;
@end


// 网络请求验证逻辑
@protocol HHXXNetworkingRequestParamsValidator <NSObject>

- (BOOL)hhxxManager:(HHXXAbstractApiManager*)manager isCorrectWithRequestParams:(NSDictionary*)params;
@end

// 网络请求数据过滤器
@protocol HHXXNetworkingDataFiltrator <NSObject>

- (id)hhxxManager:(HHXXAbstractApiManager*)manager filterData:(NSDictionary*)data;
@end
#endif /* HHXXNetworkingHead_h */
