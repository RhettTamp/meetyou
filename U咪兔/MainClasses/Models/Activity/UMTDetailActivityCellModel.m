//
//  UMTDetailActivityCellModel.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/4.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTDetailActivityCellModel.h"

@implementation UMTDetailActivityCellModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"activityId":@"id",
             @"title":@"title",
             @"startTime":@"entrie_time_start",
             @"endTime":@"entrie_time_end",
             @"content":@"content",
             @"site":@"location",
             @"tags":@"tags",
             @"joinedPeople":@"people_number_join",
             @"peopleLimit":@"people_number_up",
             @"type":@"type"};
}

@end
