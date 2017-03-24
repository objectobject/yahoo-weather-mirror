//
//  UITableViewCell+EnableDrag.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "UITableViewCell+EnableDrag.h"
#import <objc/runtime.h>
#import "HHXXUIKitMacro.h"

const CGFloat kHHXXTouchHeight = 48.0f;

// 小于这个高度的cell直接拖拉的时候直接交换，不在进行更细致的处理
const CGFloat kHHXXMaxCellHieght = 64.0f;
const CGFloat kHHXXPerMSECScrollPiexl = 4.0f;


@interface HHXXAutoLayoutTableViewCell (EnableDrag)
@property (nonatomic, strong) CADisplayLink* displayLink;

@property (nonatomic, assign) CGFloat minYValue;
@property (nonatomic, assign) CGFloat maxYValue;

@property (nonatomic, assign) NSNumber* detalYValue;


@property (nonatomic, weak) UIView* dragView;
@end

@implementation HHXXAutoLayoutTableViewCell (EnableDrag)

#pragma mark - setter and getter

- (BOOL)ignoreCellHeight
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIgnoreCellHeight:(BOOL)ignoreCellHeight
{
    objc_setAssociatedObject(self, @selector(ignoreCellHeight), @(ignoreCellHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (UIView*)dragView
{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setDragView:(UIView *)dragView
{
    objc_setAssociatedObject(self, @selector(dragView), dragView, OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)minYValue
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMinYValue:(CGFloat)minYValue
{
    objc_setAssociatedObject(self, @selector(minYValue), @(minYValue), OBJC_ASSOCIATION_ASSIGN);
}


- (NSNumber*)detalYValue
{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setDetalYValue:(NSNumber*)detalYValue
{
    objc_setAssociatedObject(self, @selector(detalYValue), detalYValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)maxYValue
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMaxYValue:(CGFloat)maxYValue
{
    objc_setAssociatedObject(self, @selector(maxYValue), @(maxYValue), OBJC_ASSOCIATION_ASSIGN);
}


- (HHXXSwitchDataBlock)switchDataBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSwitchDataBlock:(HHXXSwitchDataBlock)switchDataBlock
{
    objc_setAssociatedObject(self, @selector(switchDataBlock), switchDataBlock, OBJC_ASSOCIATION_COPY);
}


- (CADisplayLink*)displayLink
{
    return objc_getAssociatedObject(self, _cmd);;
}

- (void)setDisplayLink:(CADisplayLink *)displayLink
{
    objc_setAssociatedObject(self, @selector(displayLink), displayLink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UILongPressGestureRecognizer *)dragGesture
{
    UILongPressGestureRecognizer* drag = objc_getAssociatedObject(self, _cmd);
    if (drag == nil) {
        drag.minimumPressDuration = 1.5f;
        drag = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_hhxxDragHandler:)];
        objc_setAssociatedObject(self, _cmd, drag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setDragGesture:(UILongPressGestureRecognizer *)dragGesture
{
    objc_setAssociatedObject(self, @selector(dragGesture), dragGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView*)selfSnapshotView
{
    UIView* selfSnapshotView = objc_getAssociatedObject(self, _cmd);
    if (!selfSnapshotView) {
        selfSnapshotView = [self.contentViewInstead snapshotViewAfterScreenUpdates:YES];
        selfSnapshotView.alpha = 0.75f;
        objc_setAssociatedObject(self, _cmd, selfSnapshotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelfSnapshotView:(UIView *)selfSnapshotView
{
    objc_setAssociatedObject(self, @selector(selfSnapshotView), selfSnapshotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSIndexPath*)locationIndexPath
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLocationIndexPath:(NSIndexPath *)locationIndexPath
{
    objc_setAssociatedObject(self, @selector(locationIndexPath), locationIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)_hhxxDragHandler:(UILongPressGestureRecognizer*)dragGesture
{
    if (!self.selfSnapshotView) {
        return;
    }
    
    UITableView* fatherView = [self _fatherView];
    NSIndexPath* path = [fatherView indexPathForRowAtPoint:[dragGesture locationInView:fatherView]];
    UITableViewCell* newCell = [fatherView cellForRowAtIndexPath:path];
    
    switch (dragGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
//            NSLog(@"begin!");
            CGFloat rateValue = fatherView.bounds.size.width / self.selfSnapshotView.bounds.size.width;
            self.detalYValue = @(newCell.center.y - [dragGesture locationInView:fatherView].y);
            
            [UIView animateWithDuration:1.0 animations:^{
                self.hidden = YES;
                self.selfSnapshotView.transform = CGAffineTransformScale(CGAffineTransformIdentity, rateValue, rateValue);
                self.selfSnapshotView.center = self.center;
            } completion:^(BOOL finished) {
                [fatherView addSubview:self.selfSnapshotView];
                self.locationIndexPath = [fatherView indexPathForRowAtPoint:self.selfSnapshotView.center];
            }];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint locationPoint = [dragGesture locationInView:fatherView];
            self.selfSnapshotView.center = CGPointMake(self.selfSnapshotView.center.x, locationPoint.y + [self.detalYValue floatValue]);
            
            // 忽略细节直接交换
            if(self.ignoreCellHeight)
            {
                [fatherView beginUpdates];
                self.switchDataBlock? self.switchDataBlock(self.locationIndexPath.row, path.row): nil;
                [fatherView moveRowAtIndexPath:self.locationIndexPath toIndexPath:path];
                [fatherView moveRowAtIndexPath:path toIndexPath:self.locationIndexPath];
                [fatherView endUpdates];
                self.locationIndexPath = path;
            }
            else
            {
                // 如果移动到新的单元格，进行单元格交换
                if (path && ![path isEqual:self.locationIndexPath])
                {
                    // 向下
                    if (path.row > self.locationIndexPath.row && (self.selfSnapshotView.center.y >= newCell.center.y || self.selfSnapshotView.bounds.size.height > newCell.bounds.size.height))
                    {
                        [fatherView beginUpdates];
                        self.switchDataBlock? self.switchDataBlock(self.locationIndexPath.row, path.row): nil;
                        [fatherView moveRowAtIndexPath:self.locationIndexPath toIndexPath:path];
                        [fatherView moveRowAtIndexPath:path toIndexPath:self.locationIndexPath];
                        [fatherView endUpdates];
                        self.locationIndexPath = path;
                    }// 向上
                    else if (path.row < self.locationIndexPath.row && self.selfSnapshotView.center.y <= newCell.center.y)
                    {
                        [fatherView beginUpdates];
                        self.switchDataBlock? self.switchDataBlock(self.locationIndexPath.row, path.row): nil;
                        [fatherView moveRowAtIndexPath:self.locationIndexPath toIndexPath:path];
                        [fatherView moveRowAtIndexPath:path toIndexPath:self.locationIndexPath];
                        [fatherView endUpdates];
                        self.locationIndexPath = path;
                    }
                }
            }
            
            // 如果移动到边缘就进行边缘处理
            CGFloat minYValue = fatherView.contentOffset.y + kHHXXTouchHeight;
            CGFloat maxYValue = fatherView.contentOffset.y + HHXX_MAIN_SCREEN_HEIGHT - kHHXXTouchHeight;
            CGFloat bottomCmpYValue = locationPoint.y + newCell.bounds.size.height / 2.0f;
            
//            NSLog(@"MAX: %03f, CUR: %03f, Min: %03f", maxYValue, locationPoint.y, minYValue);
            
            if (bottomCmpYValue < maxYValue && locationPoint.y > minYValue) {
                [self.displayLink invalidate];
                self.displayLink = nil;
            }
            else
            {
                if (!self.displayLink) {
                    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_hhxxTouchEdge:)];
                    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
                }
            }
        }
            break;
            
        default:
        {
            [self.selfSnapshotView removeFromSuperview];
            self.hidden = NO;
            [self.dragView removeGestureRecognizer:self.dragGesture];
            self.dragGesture = nil;
            if (self.displayLink) {
                [self.displayLink invalidate];
                self.displayLink = nil;
            }
        }
            break;
    }
    
}



- (UITableView*)_fatherView
{
    UIView* fv = self.superview;
    while (![fv isKindOfClass:[UITableView class]]) {
        fv = fv.superview;
    };
    
    return (UITableView*)fv;
}

- (void)_hhxxTouchEdge:(CADisplayLink*)dsl
{
    UITableView* fatherView = [self _fatherView];
    CGFloat minYValue = -kHHXXTouchHeight;
    CGFloat maxYValue = fatherView.contentSize.height + kHHXXTouchHeight;
    
    if (fatherView.contentOffset.y + HHXX_MAIN_SCREEN_HEIGHT + kHHXXTouchHeight > maxYValue) {
        NSLog(@"下边界!");
        return;
    }
    if (fatherView.contentOffset.y < minYValue) {
        NSLog(@"上边界!");
        return;
    }
    
    CGPoint locationPoint = [self.dragGesture locationInView:fatherView];
    minYValue = fatherView.contentOffset.y + kHHXXTouchHeight;
    maxYValue = fatherView.contentOffset.y + HHXX_MAIN_SCREEN_HEIGHT - kHHXXTouchHeight;
    
    NSLog(@"cur %04f, minYValue = %04f", locationPoint.y, minYValue);
    
    CGPoint newContentOffset = fatherView.contentOffset;
    if (locationPoint.y > maxYValue) {
        self.selfSnapshotView.center = CGPointMake(self.selfSnapshotView.center.x, self.selfSnapshotView.center.y + 8);
        [fatherView setContentOffset:CGPointMake(newContentOffset.x, newContentOffset.y + kHHXXPerMSECScrollPiexl)];
    }
    if (locationPoint.y < minYValue) {
        self.selfSnapshotView.center = CGPointMake(self.selfSnapshotView.center.x, self.selfSnapshotView.center.y - 8);
        [fatherView setContentOffset:CGPointMake(newContentOffset.x, newContentOffset.y - kHHXXPerMSECScrollPiexl)];
    }
}


- (void)hhxxDragView:(UIView*)dragView
{
    if (self.dragGesture && dragView) {
        self.dragView = dragView;
        [self.dragView addGestureRecognizer:self.dragGesture];
        UITableView* fatherView = [self _fatherView];
        self.minYValue = - HHXX_MAIN_SCREEN_HEIGHT + kHHXXTouchHeight;
        self.maxYValue = fatherView.contentSize.height - kHHXXTouchHeight;
    }
}
@end


