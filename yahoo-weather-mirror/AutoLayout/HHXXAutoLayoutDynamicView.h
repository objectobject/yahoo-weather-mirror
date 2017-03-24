//
//  UIView+generater.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/9.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHXXAutoLayoutView.h"

typedef id (^HHXXSubViewGeneratorBlock)();
typedef void (^HHXXDecorateChildrenBlock)(NSArray* child);

@interface HHXXAutoLayoutDynamicView: HHXXAutoLayoutView
@property (nonatomic, strong) NSMutableArray<UIView*>* children;
@property (nonatomic, copy) HHXXDecorateChildrenBlock modelBlock;

- (instancetype)initWithSuvViewGenerator:(HHXXSubViewGeneratorBlock)generator number:(NSUInteger)number;
- (id)objectInChildrenAtIndex:(NSUInteger)index;

- (void)decorateChildWithBlock:(HHXXDecorateChildrenBlock)modelBlock;
- (void)configureWithModel;
@end
