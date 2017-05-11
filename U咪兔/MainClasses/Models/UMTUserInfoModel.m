//
//  UMTUserInfoModel.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTUserInfoModel.h"

@implementation UMTUserInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"userId":@"id",
             @"headImgUrl":@"avatar",
             @"userDescription":@"description"};
}

@end
