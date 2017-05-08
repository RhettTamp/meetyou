//
//  UMTAddActivityTimeView.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMTAddActivityTimeViewDelegate <NSObject>

- (void)clickedStartTime:(UIButton *)button;

- (void)clickedEndTime:(UIButton *)button;

@end

@interface UMTAddActivityTimeView : UIView

@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,strong) UIButton *startTimeButton;
@property (nonatomic,strong) UIButton *endTimeButton;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,weak) id <UMTAddActivityTimeViewDelegate>delegate;

@end
