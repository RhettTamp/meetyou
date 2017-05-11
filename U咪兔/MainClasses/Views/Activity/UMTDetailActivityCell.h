//
//  UMTDetailActivityCell.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMTDetailActivityCell : UITableViewCell

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *startTime;  //活动开始时间
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *applyStartTime; //报名开始时间
@property (nonatomic,strong) NSString *applyEndTime;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSArray *tags;
@property (nonatomic,assign) CGFloat peoplePercent;
@property (nonatomic,strong) NSString *headStr;

- (void)resetData;

@end
