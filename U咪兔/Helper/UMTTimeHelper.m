//
//  UMTTimeHelper.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTTimeHelper.h"

@implementation UMTTimeHelper

+ (NSString *)timeFromTimeInterval:(NSTimeInterval)timeInterval {
    int h = (int)timeInterval/3600;
    NSString *hour = [NSString stringWithFormat:@"%02ld",(NSInteger)timeInterval/3600];
    NSString *minutes = [NSString stringWithFormat:@"%02ld",(NSInteger)(timeInterval -(h*3600))/ 60];
    NSString *seconds = [NSString stringWithFormat:@"%02ld",(NSInteger)timeInterval % 60];
    return [NSString stringWithFormat:@"%@:%@:%@",hour,minutes,seconds];
}

@end
