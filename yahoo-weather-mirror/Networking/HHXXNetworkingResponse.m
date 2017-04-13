//
//  HHXXNetworkingResponse.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/6.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXNetworkingResponse.h"

@interface HHXXNetworkingResponse()
@property (nonatomic, copy, readwrite) NSString* rawResponseString;
@property (nonatomic, copy, readwrite) id rawJSONObject;
@property (nonatomic, copy, readwrite) NSData* rawResponseData;
@property (nonatomic, assign, readwrite) NSInteger requestID;
@property (nonatomic, strong, readwrite) NSURLRequest* request;
@property (nonatomic, copy, readwrite) NSString* responseErrorMsg;
@end

@implementation HHXXNetworkingResponse


- (instancetype)initWithRequest:(NSURLRequest*)request requestID:(NSInteger)requestID responseObject:(id)responseObject error:(NSError*)error
{
    self = [super init];
    if (self) {
        
        self.rawResponseData = nil;
        self.rawResponseString = nil;
        self.rawJSONObject = nil;
        if (!error) {
            self.rawResponseData = responseObject;
            self.rawResponseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            self.rawJSONObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        }
        
        self.requestID = requestID;
        self.request = [request copy];
    }
    
    return self;
}


- (NSString *)description
{
    NSString* descriptionString = [NSString stringWithFormat:
                                   @"==========[URL:%@]==========\r\nJSON=%@\r\n\r\nData=%@\r\n\r\nString=%@", [self.request URL], self.rawJSONObject, self.rawResponseData, self.rawResponseString];
    return descriptionString;
}

@end
