//
//  NSAttributedString+Attachment.m
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import "NSAttributedString+Attachment.h"

@implementation NSAttributedString (Attachment)


+ (instancetype)clearAttributeStringWithTransparenceImageName:(NSString*)name size:(CGSize)size
{
    return [NSAttributedString attributedStringWithAttachment:({
        NSTextAttachment* attachment = [NSTextAttachment new];
        attachment.image = [UIImage imageNamed:name];
        attachment.bounds = CGRectMake(0, 0, size.width, size.height);
        attachment;
    })];
}
@end
