//
//  UMTDetailActivityCellModel.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/4.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTDetailActivityCellModel : NSObject

@property (nonatomic,assign) int activityId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSDictionary *tags;
@property (nonatomic,assign) int joinedPeople;
@property (nonatomic,assign) int peopleLimit;
@property (nonatomic,strong) NSString *type;
//@property (nonatomic,assign) CGFloat *peopleCount; //人数所占百分比，保留两位百分数
//@property (nonatomic,assign) CGFloat *timeCount;  //时间所占百分比
@property (nonatomic,strong) NSArray *joinedPersons;

@end
