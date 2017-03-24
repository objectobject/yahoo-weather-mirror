//
//  UITableViewCell+EnableDrag.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHXXAutoLayoutTableViewCell.h"

typedef void (^HHXXSwitchDataBlock)(NSUInteger fromIndex, NSUInteger toIndex);

@interface HHXXAutoLayoutTableViewCell (EnableDrag)

//@property (nonatomic, strong) UILongPressGestureRecognizer* dragGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer* dragGesture;
@property (nonatomic, strong) UIView* selfSnapshotView;
@property (nonatomic, strong) NSIndexPath* locationIndexPath;

@property (nonatomic, copy) HHXXSwitchDataBlock switchDataBlock;
@property (nonatomic, assign) BOOL ignoreCellHeight;
- (void)hhxxDragView:(UIView*)dragView;
@end
