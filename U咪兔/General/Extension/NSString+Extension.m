//
//  NSString+Extension.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    return size;
}

@end
