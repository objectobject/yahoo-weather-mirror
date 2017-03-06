//
//  NSAttributedString+Attachment.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/3/10.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Attachment)

+ (instancetype)clearAttributeStringWithTransparenceImageName:(NSString*)name size:(CGSize)size;
@end
