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
@property (nonatomic,strong) UILabel *joinedPerson;
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
    self.joinedPerson = joinedLabel;
    
    UILabel *sLabel = [[UILabel alloc]init];
    sLabel.text = @"剩余报名时间:";
    [self addSubview:sLabel];
    [sLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(jLabel.mas_bottom).offset(10);
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"00小时30分钟22秒";
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(sLabel.mas_top);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *tLabel = [[UILabel alloc]init];
    tLabel.text = @"类型:";
    [self addSubview:tLabel];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(sLabel.mas_bottom).offset(10);
    }];
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.text = @"说走就走";
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



@end
