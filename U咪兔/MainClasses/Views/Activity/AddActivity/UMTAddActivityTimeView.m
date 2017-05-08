//
//  UMTAddActivityTimeView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTAddActivityTimeView.h"
#import "NSString+Extension.h"

#define kItemHeight 40

@interface UMTAddActivityTimeView ()


@end

@implementation UMTAddActivityTimeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        self.layer.borderColor = kLineColor.CGColor;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 40, kItemHeight)];
    startLabel.text = @"开始";
    [self addSubview:startLabel];
//    [startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(8);
//        make.top.equalTo(self.mas_top);
//        make.height.mas_equalTo(40);
//    }];
    self.startLabel = startLabel;
    
    CGSize stringSize = [NSString getAttributeSizeWithText:@"2017/04/18,19:00" fontSize:20];
    UIButton *startTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-8-stringSize.width, 0, stringSize.width, kItemHeight)];
    [startTimeButton setTitle:@"2017/04/18,19:00" forState:UIControlStateNormal];
    [startTimeButton setTitleColor:kCommonGreenColor forState:UIControlStateSelected];
    [startTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startTimeButton addTarget:self action:@selector(startTimeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:startTimeButton];
//    [startTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-8);
//        make.top.equalTo(self.mas_top);
//        make.height.mas_equalTo(kItemHeight);
//    }];
    self.startTimeButton = startTimeButton;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kItemHeight, CGRectGetWidth(self.frame), 1)];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self);
//        make.height.mas_equalTo(1);
//        make.top.equalTo(self.mas_top).offset(kItemHeight);
//    }];
    self.lineView = lineView;
    
    UILabel *endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, kItemHeight, 40, kItemHeight)];
    endTimeLabel.text = @"结束";
    [self addSubview:endTimeLabel];
//    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(8);
//        make.top.equalTo(self).mas_offset(kItemHeight);
//        make.height.mas_equalTo(kItemHeight);
//    }];
    self.endLabel = endTimeLabel;
    
    UIButton *endTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-8-stringSize.width, kItemHeight, stringSize.width, kItemHeight)];
    [endTimeButton setTitle:@"2017/04/18,19:00" forState:UIControlStateNormal];
    [endTimeButton setTitleColor:kCommonGreenColor forState:UIControlStateSelected];
    [endTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [endTimeButton addTarget:self action:@selector(endTimeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:endTimeButton];
//    [endTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-8);
//        make.top.equalTo(self.mas_top).offset(kItemHeight);
//        make.height.mas_equalTo(kItemHeight);
//    }];
    self.endTimeButton = endTimeButton;

}

- (void)startTimeButtonClicked:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    if (self.delegate) {
        [self.delegate clickedStartTime:button];
    }
}

- (void)endTimeButtonClicked:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;

    }else{
        button.selected = YES;
    }
    if (self.delegate) {
        [self.delegate clickedEndTime:button];
    }
}




@end
