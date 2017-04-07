//
//  HHXXNetworkingProxyUseAF.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/5.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingProxyUseAF.h"
#import <AFNetworking.h>
#import "HHXXNetworkingService.h"
#import "HHXXNetworkingResponse.h"

@interface HHXXNetworkingProxyUseAF()
@property (nonatomic, strong) NSMutableDictionary<NSNumber*, NSURLSessionTask*>* networkingTasks;

@property (nonatomic, strong) AFHTTPRequestSerializer* requestSerializer;
@property (nonatomic, strong) AFHTTPSessionManager* networkingSessionManager;
@end


@implementation HHXXNetworkingProxyUseAF


- (NSUInteger)hhxxNetworkingWithRequest:(NSURLRequest*)request success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed
{
    NSURLSessionTask* dataTask = [[self networkingSessionManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        HHXXNetworkingResponse* networkingResponse = [[HHXXNetworkingResponse alloc] initWithRequest:request requestID:[dataTask taskIdentifier] responseObject:responseObject error:error];
        
        [self.networkingTasks removeObjectForKey:@([dataTask taskIdentifier])];
        if (error) {
            failed? failed(networkingResponse) : nil;
        }else{
            success? success(networkingResponse): nil;
        }
    }];
    
    NSNumber* taskIdentifier = @([dataTask taskIdentifier]);
    self.networkingTasks[taskIdentifier] = dataTask;
    [dataTask resume];
    
    return [taskIdentifier unsignedIntegerValue];
}


- (NSUInteger)hhxxGetNetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed
{
    NSMutableURLRequest* request = ({
        id<HHXXNetworkingServiceProtocol> networkingService = [[HHXXNetworkingServiceFactory networkingServiceFactory] networkingServiceWithName:serviceId];
        NSString* fullRequestString = [NSString stringWithFormat:@"%@%@", [networkingService hhxxBaseURLForService], methodName];
        
        NSMutableURLRequest* request = [self.requestSerializer requestWithMethod:@"GET" URLString:fullRequestString parameters:requestParams error:NULL];
        [request setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"HHXX_REQUESTID"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        request;
    });
    return [self hhxxNetworkingWithRequest:request success:success failed:failed];
}


- (NSUInteger)hhxxPOSTNetworkingWithServiceID:(NSString*)serviceId methodName:(NSString*)methodName requestParams:(NSDictionary*)requestParams success:(HHXXNetworkingSuccessBlock)success failed:(HHXXNetworkingFailedBlock)failed
{
    NSMutableURLRequest* request = ({
        id<HHXXNetworkingServiceProtocol> networkingService = [[HHXXNetworkingServiceFactory networkingServiceFactory] networkingServiceWithName:serviceId];
        NSString* fullRequestString = [NSString stringWithFormat:@"%@%@", [networkingService hhxxBaseURLForService], methodName];
        
        NSMutableURLRequest* request = [self.requestSerializer requestWithMethod:@"POST" URLString:fullRequestString parameters:requestParams error:NULL];
        [request setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"HHXX_REQUESTID"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        request;
    });
    return [self hhxxNetworkingWithRequest:request success:success failed:failed];
}


#pragma mark - getter and setter
- (AFHTTPSessionManager*)networkingSessionManager
{
    if (!_networkingSessionManager) {
        _networkingSessionManager = [AFHTTPSessionManager manager];
//        _networkingSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _networkingSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

        _networkingSessionManager.securityPolicy.allowInvalidCertificates = YES;
        _networkingSessionManager.securityPolicy.validatesDomainName = NO;
    }
    
    return _networkingSessionManager;
}

- (AFHTTPRequestSerializer*)requestSerializer
{
    if (!_requestSerializer) {
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        _requestSerializer.timeoutInterval = 5.0f;
        _requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    
    return _requestSerializer;
}


- (NSMutableDictionary<NSNumber *,NSURLSessionTask *> *)networkingTasks
{
    if (!_networkingTasks) {
        _networkingTasks = [[NSMutableDictionary alloc] init];
    }
    
    return _networkingTasks;
}
@end
