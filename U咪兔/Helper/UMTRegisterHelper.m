//
//  UMTRegisterHelper.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRegisterHelper.h"
#import <YYModel.h>

@implementation UMTRegisterHelper

static UMTRegisterHelper *helper = nil;

+ (instancetype)sharedHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[UMTRegisterHelper alloc]init];
    });
    return helper;
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"label":@"description",
             @"photo":[NSDate class]};
}

@end
