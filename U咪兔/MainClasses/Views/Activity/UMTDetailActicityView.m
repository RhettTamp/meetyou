//
//  UMTDetailActicityView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTDetailActicityView.h"

@interface UMTDetailActicityView ()

@property (nonatomic,strong) UILabel *personLabel;
@property (nonatomic,strong) UILabel *joinedPersonLabel;
@property (nonatomic,strong) UILabel *startTimeLabel;
@property (nonatomic,strong) UILabel *endTimeLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@end

@implementation UMTDetailActicityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView{
    UILabel *pLabel = [[UILabel alloc]init];
    pLabel.text = @"目标人数:";
    [self addSubview:pLabel];
    [pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    UILabel *personLabel = [[UILabel alloc]init];
    personLabel.text = @"70人";
    [self addSubview:personLabel];
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
    self.personLabel = personLabel;
    
    UILabel *jLabel = [[UILabel alloc]init];
    jLabel.text = @"实际报名人数:";
    [self addSubview:jLabel];
    [jLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(pLabel.mas_bottom).offset(10);
    }];
    UILabel *joinedLabel = [[UILabel alloc]init];
    joinedLabel.text = @"50人";
    [self addSubview:joinedLabel];
    [joinedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(jLabel.mas_top);
    }];
    self.joinedPersonLabel = joinedLabel;
    
    UILabel *sLabel = [[UILabel alloc]init];
    sLabel.text = @"报名开始时间:";
    [self addSubview:sLabel];
    [sLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(jLabel.mas_bottom).offset(10);
    }];
    UILabel *startTimeLabel = [[UILabel alloc]init];
    startTimeLabel.text = @"2017年04月20日";
    [self addSubview:startTimeLabel];
    [startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(sLabel.mas_top);
    }];
    self.startTimeLabel = startTimeLabel;
    
    UILabel *eLabel = [[UILabel alloc]init];
    eLabel.text = @"报名截止时间:";
    [self addSubview:eLabel];
    [eLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(sLabel.mas_bottom).offset(10);
    }];
    UILabel *endTimeLabel = [[UILabel alloc]init];
    endTimeLabel.text = @"2017年04月26日";
    [self addSubview:endTimeLabel];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(eLabel.mas_top);
    }];
    self.endTimeLabel = endTimeLabel;
    
    UILabel *tLabel = [[UILabel alloc]init];
    tLabel.text = @"类型:";
    [self addSubview:tLabel];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(eLabel.mas_bottom).offset(10);
    }];
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.text = @"精心计划";
    [self addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(tLabel.mas_top);
    }];
    self.typeLabel = typeLabel;
    
    UILabel *stLabel = [[UILabel alloc]init];
    stLabel.text = @"当前状态";
    [self addSubview:stLabel];
    [stLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(tLabel.mas_bottom).offset(10);
    }];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = @"正常报名";
    statusLabel.textColor = kCommonGreenColor;
    [self addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(stLabel.mas_top);
    }];
    self.statusLabel = statusLabel;
}

- (void)setStartTime:(NSString *)startTime{
    _startTime = startTime;
    self.startTimeLabel.text = startTime;
}

- (void)setEndTime:(NSString *)endTime{
    _endTime = endTime;
    self.endTimeLabel.text = endTime;
}

- (void)setLimitPerson:(NSInteger)limitPerson{
    _limitPerson = limitPerson;
    self.personLabel.text = [NSString stringWithFormat:@"%lu人",limitPerson];
}

- (void)setJoinedPerson:(NSInteger)joinedPerson{
    _joinedPerson = joinedPerson;
    self.joinedPersonLabel.text = [NSString stringWithFormat:@"%lu人",joinedPerson];
}

- (void)setState:(NSString *)state{
    _state = state;
    self.statusLabel.text = state;
    if ([state isEqualToString:@"报名尚未开始"]) {
        self.statusLabel.textColor = kCircleOrangeColor;
    }else if ([state isEqualToString:@"报名进行中"]){
        self.statusLabel.textColor = kCommonGreenColor;
    }else if ([state isEqualToString:@"报名已经结束"]){
        self.statusLabel.textColor = Hex(0xf0436d);
    }
}

@end
