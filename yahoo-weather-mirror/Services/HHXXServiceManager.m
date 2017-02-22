//
//  HHXXServiceManager.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXServiceManager.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface HHXXServiceManager()
{
    
}
@property (nonatomic, copy) NSMutableDictionary<NSString*, id<UIApplicationDelegate>>* services;
@end

@implementation HHXXServiceManager


+ (instancetype)sharedServiceManager
{
    static HHXXServiceManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HHXXServiceManager alloc] init];
    });
    
    return manager;
}


- (NSArray<id<HHXXSOAServiceDelegate>> *)allServices
{
    return [self.services copy];
}


- (void)registerService:(id<HHXXSOAServiceDelegate>)service
{
    if (service && ![_services.allKeys containsObject:[service hhxxServiceName]]) {
        _services[[service hhxxServiceName]] = service;
    }else{
        NSLog(@"register service failed.\r\n serverName:%@\r\n\r\n", [service respondsToSelector:@selector(serverName)]?[service performSelector:@selector(hhxxServiceName)]: [service class]);
    }
}


- (void)hhxxForwardInvocation:(NSInvocation *)anInvocation
{
    NSUInteger argvCount = [anInvocation methodSignature].numberOfArguments;
    NSUInteger returnValueLength = [anInvocation methodSignature].methodReturnLength;
    __block void* returnValueBuffer = returnValueLength > 0? (void *)malloc(returnValueLength): NULL;
    [self.services enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<HHXXSOAServiceDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (![obj respondsToSelector:anInvocation.selector]) {
            return;
        }
        
        // 排除函数签名不一样的。
        if (![[self _hhxxMethodSignature:anInvocation.methodSignature] isEqualToString:[self _hhxxMethodSignature:[(id)obj methodSignatureForSelector:anInvocation.selector]]]) {
            NSLog(@"[%@]服务中函数签名和UIApplicationDelegate中同名接口函数签名不一致!!!", [obj hhxxServiceName]);
            return;
        }
        
        // 设置相关函数签名，函数参数，SEL，触发对象
        NSInvocation* newInvocation = [NSInvocation invocationWithMethodSignature:anInvocation.methodSignature];
        [newInvocation setSelector:anInvocation.selector];
//        [newInvocation setArgument:&obj atIndex:0];
//        [newInvocation setArgument:anInvocation.selector atIndex:1];
        
        for(NSUInteger index = 0; index < argvCount; ++index)
        {
            const char* argValueType = [[anInvocation methodSignature] getArgumentTypeAtIndex:index];
            NSUInteger argValueSize = 0;
            NSGetSizeAndAlignment(argValueType, &argValueSize, NULL);
            void* argValue = argValueSize > 0? (void*)malloc(argValueSize): NULL;
            [anInvocation getArgument:&argValue atIndex:index];
            [newInvocation setArgument:&argValue atIndex:index];
//            argValue != NULL? free(argValue): ({});
        }
        [newInvocation retainArguments];
        [newInvocation invokeWithTarget:obj];
        
        if (strcmp([newInvocation methodSignature].methodReturnType, @encode(BOOL)) == 0&& [newInvocation methodSignature].methodReturnLength) {
            [newInvocation getReturnValue:&returnValueBuffer];
        }
    }];
    
    
    if ([anInvocation methodSignature].methodReturnLength > 0)
    {
        [anInvocation setReturnValue:&returnValueBuffer];
//        free(returnValueBuffer);
    }
}

#pragma mark - private method
- (NSString*)_hhxxMethodSignature:(NSMethodSignature*)signture
{
    NSMutableString* methodSigntureString = [NSMutableString stringWithCapacity:signture.numberOfArguments + signture.methodReturnLength];
    for (NSUInteger index = 0;  index < signture.numberOfArguments; ++index)
    {
        [methodSigntureString appendString:[NSString stringWithUTF8String:[signture getArgumentTypeAtIndex:index]]];
    }
    [methodSigntureString appendString:[NSString stringWithUTF8String:signture.methodReturnType]];
    
    return [methodSigntureString copy];
}


- (BOOL)hhxxCanRespondToSel:(SEL)aSelector
{
    __block BOOL canRespond = NO;
    [self.services enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<UIApplicationDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:aSelector]) {
            IMP imp = class_getMethodImplementation([obj class], aSelector);
            canRespond = imp && imp != _objc_msgForward;
            *stop = YES;
        }
    }];
    
    return canRespond;
}


#pragma mark - setter and getter
- (instancetype)init
{
    self = [super init];
    if (self) {
        _services = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}
@end
