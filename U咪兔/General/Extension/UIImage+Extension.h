//
//  UIImage+Extension.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/13.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (UIImage *)circleImageWithOldImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
