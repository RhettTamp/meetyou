//
//  UMTSimpleActivityView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSimpleActivityView.h"

@interface UMTSimpleActivityView ()

@property (nonatomic,strong) UILabel *personLabel;
@property (nonatomic,strong) UILabel *joinedPersonLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@end

@implementation UMTSimpleActivityView

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
    pLabel.font = kFont(15);
    [self addSubview:pLabel];
    [pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    UILabel *personLabel = [[UILabel alloc]init];
    personLabel.text = @"70人";
    personLabel.font = kFont(15);
    personLabel.textColor = Hex(0x8e8e8e);
    [self addSubview:personLabel];
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
    self.personLabel = personLabel;
    
    UILabel *jLabel = [[UILabel alloc]init];
    jLabel.text = @"实际报名人数:";
    jLabel.font = kFont(15);
    [self addSubview:jLabel];
    [jLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(pLabel.mas_bottom).offset(10);
    }];
    UILabel *joinedLabel = [[UILabel alloc]init];
    joinedLabel.text = @"50人";
    joinedLabel.font = kFont(15);
    joinedLabel.textColor = Hex(0x8e8e8e);
    [self addSubview:joinedLabel];
    [joinedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(jLabel.mas_top);
    }];
    self.joinedPersonLabel = joinedLabel;
    
    UILabel *sLabel = [[UILabel alloc]init];
    sLabel.text = @"剩余报名时间:";
    sLabel.font = kFont(15);
    [self addSubview:sLabel];
    [sLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(jLabel.mas_bottom).offset(10);
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"00小时30分钟22秒";
    timeLabel.font = kFont(15);
    timeLabel.textColor = Hex(0x8e8e8e);
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(sLabel.mas_top);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *tLabel = [[UILabel alloc]init];
    tLabel.text = @"类型:";
    tLabel.font = kFont(15);
    [self addSubview:tLabel];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(sLabel.mas_bottom).offset(10);
    }];
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.text = @"说走就走";
    typeLabel.font = kFont(15);
    typeLabel.textColor = Hex(0x8e8e8e);
    [self addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(tLabel.mas_top);
    }];
    self.typeLabel = typeLabel;
    
    UILabel *stLabel = [[UILabel alloc]init];
    stLabel.text = @"当前状态";
    stLabel.font = kFont(15);
    [self addSubview:stLabel];
    [stLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(tLabel.mas_bottom).offset(10);
    }];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = @"正常报名";
    statusLabel.font = kFont(15);
    statusLabel.textColor = kCommonGreenColor;
    [self addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(stLabel.mas_top);
    }];
    self.statusLabel = statusLabel;
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

- (void)setTimeString:(NSString *)timeString{
    self.timeLabel.text = timeString;
    _timeString = timeString;
}

@end
