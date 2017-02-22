//
//  HHXXSOADelegate.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/2/21.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXSOADelegate.h"
#import "HHXXServiceManager.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface HHXXSOADelegate()

@property (nonatomic, copy) NSArray<NSString*>* nameOfMethodDefineProtocol;
@end

@implementation HHXXSOADelegate


// Objective-c中获取方法实现时，如果没有实现或返回_objc_msgForward
- (BOOL)respondsToSelector:(SEL)aSelector
{
    IMP imp = class_getMethodImplementation([self class], aSelector);
    BOOL canRespond = imp && imp != _objc_msgForward;
    
    // 自己无法响应响应的方法
    if (!canRespond && [self.nameOfMethodDefineProtocol containsObject:NSStringFromSelector(aSelector)])
    {
        canRespond = [[HHXXServiceManager sharedServiceManager] hhxxCanRespondToSel:aSelector];
    }
    return canRespond;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [[HHXXServiceManager sharedServiceManager] hhxxForwardInvocation:anInvocation];
}


#pragma mark - 获取UIApplicationDelegate委托定义的Sel名称列表
- (NSArray<NSString*>*)nameOfMethodDefineProtocol{
    if (!_nameOfMethodDefineProtocol)
    {
        NSMutableArray<NSString*>* methodNameList = nil;
        unsigned int methodCount = 0;
        
        struct objc_method_description* methodList = protocol_copyMethodDescriptionList(@protocol(UIApplicationDelegate), NO, YES, &methodCount);
        methodNameList = [NSMutableArray arrayWithCapacity:methodCount];
        for (NSInteger index = 0; index < methodCount; ++index)
        {
            [methodNameList addObject: NSStringFromSelector(methodList[index].name)];
        }
        free(methodList);
        
        _nameOfMethodDefineProtocol = [methodNameList copy];
    }
    
    return _nameOfMethodDefineProtocol;
}
@end
