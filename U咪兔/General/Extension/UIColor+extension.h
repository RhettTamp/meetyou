//
//  UIColor+extension.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (extension)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString: (NSString *)color;
+ (UIColor *)colorWithRGB:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

@end
