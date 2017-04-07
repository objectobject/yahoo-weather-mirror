//
//  HHXXAutoLayoutTableViewCell.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/8.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "HHXXAutoLayoutTableViewCell.h"

const CGFloat kHHXXHPadding = 6.0f;
const CGFloat kHHXXVPadding = 6.0f;
const CGFloat kHHXX2DivPadding = kHHXXVPadding / 2.0f;

@interface HHXXAutoLayoutTableViewCell()
@property (nonatomic, strong, readwrite) UIView* contentViewInstead;
@end

@implementation HHXXAutoLayoutTableViewCell


- (UIView*)contentViewInstead
{
    if (!_contentViewInstead) {
        _contentViewInstead = [UIView new];
        _contentViewInstead.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_contentViewInstead];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[_contentViewInstead]-4-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentViewInstead)]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_contentViewInstead]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentViewInstead)]];
    }
    
    return _contentViewInstead;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)commonInit
{
    self.canDrag = YES;
    self.backgroundColor = [UIColor clearColor];
    self.contentViewInstead.backgroundColor = [UIColor colorWithWhite:0 alpha:.75];
    self.contentViewInstead.layer.cornerRadius = 4.0f;
}



- (void)configureWithModel:(id)model
{
    
}


- (void)updateConstraints
{
    if (!_layoutConstraintsIsCreated) {
        [self hhxx_createLayoutConstraints];
        _layoutConstraintsIsCreated = YES;
    }
    [super updateConstraints];
}


- (void)hhxx_createLayoutConstraintsIfNeed
{
    if (!_layoutConstraintsIsCreated) {
        [self hhxx_createLayoutConstraints];
        _layoutConstraintsIsCreated = YES;
    }
}

//- (void)setFrame:(CGRect)frame
//{
//    if (!self.layoutConstraintsIsCreated) {
//        CGRect newFrame = CGRectInset(frame, 4, 2);
//        [super setFrame:newFrame];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
