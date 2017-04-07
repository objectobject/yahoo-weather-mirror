//
//  UIView+generater.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/9.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXAutoLayoutDynamicView.h"
#import <Masonry.h>
#import "UIView+Border.h"


@interface HHXXAutoLayoutDynamicView()
// 后续根据比例
@property (nonatomic, strong) NSMutableArray<NSNumber*>* rate;
@end

@implementation HHXXAutoLayoutDynamicView


- (instancetype)initWithSuvViewGenerator:(HHXXSubViewGeneratorBlock)generator number:(NSUInteger)number
{
    self = [self init];
    if(self)
    {
        self.children = [NSMutableArray arrayWithCapacity:number];
        for (NSUInteger index = 0; index < number; ++index) {
            [self.children addObject:generator()];
        }
        
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithChildren:(NSArray*)children
{
    self = [self init];
    if(self)
    {
        self.children = [NSMutableArray arrayWithCapacity:[children count]];
        for (NSUInteger index = 0; index < [children count]; ++index) {
            [self.children addObject:children[index]];
        }
        
        [self commonInit];
    }
    
    return self;
}


- (void)decorateChildWithBlock:(HHXXDecorateChildrenBlock)modelBlock
{
    modelBlock? modelBlock(self.children): nil;
    modelBlock = nil;
}


- (void)configureWithModel
{
    self.modelBlock? self.modelBlock(self.children): nil;
    self.modelBlock = nil;
}


- (id)objectInChildrenAtIndex:(NSUInteger)index
{
    if (index >= [self.children count]) {
        return nil;
    }
    return [self.children objectAtIndex:index];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}


- (void)hhxx_createLayoutConstraints
{
    __block UIView* preView = nil;
    [self.children enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            if(preView){
                make.left.equalTo(preView.mas_right);
                make.width.equalTo(preView.mas_width);
            }else{
                make.left.equalTo(self);
            }
            if (idx == [self.children count] - 1) {
                make.right.equalTo(self);
            }
            
            preView = obj;
        }];
    }];
}



/**
 *  初始化各种子视图
 */
- (void)commonInit
{
    [self.children enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    
    //if view based frame, noted
}



#pragma mark - init function



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    //如果自定义视图从xib,sb创建的,可以在这里放置一个异常或者断言
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
