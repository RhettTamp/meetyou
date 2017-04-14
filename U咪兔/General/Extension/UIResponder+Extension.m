//
//  UIResponder+Extension.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UIResponder+Extension.h"

@implementation UIResponder (Extension)

static __weak id currentFirstResponder;


+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
