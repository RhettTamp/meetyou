//
//  UMTPasswordView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/4.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTPasswordView.h"
#import "UMTInfoItemView.h"
#import "UMTSeparatorLine.h"

@interface UMTPasswordView()

@property (nonatomic,strong) UMTInfoItemView *passwordView;
@property (nonatomic,strong) UMTSeparatorLine *lineView;
@property (nonatomic,strong) UMTInfoItemView *commitPasswordView;

@end

@implementation UMTPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.passwordView = [[UMTInfoItemView alloc]init];
        self.passwordView.rightPlaceholder = @"请输入密码";
        self.passwordView.leftTitle = @"密码";
        self.password = self.passwordView.textInput;
        self.passwordView.inputTextField.secureTextEntry = YES;
        [self addSubview:self.passwordView];
        self.lineView = [[UMTSeparatorLine alloc]init];
        self.lineView.backgroundColor = Hex(0xd5d4d8);
        [self addSubview:self.lineView];
        self.commitPasswordView = [[UMTInfoItemView alloc]init];
        self.commitPasswordView.leftTitle = @"确认密码";
        self.commitPasswordView.rightPlaceholder = @"再次输入密码";
        self.commitPasswordView.inputTextField.secureTextEntry = YES;
        [self addSubview:self.commitPasswordView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIView *lineView1 = [[UIView alloc]init];
    [self addSubview:lineView1];
    lineView1.backgroundColor = kLineColor;
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(self.height/2);
        make.top.equalTo(self);
    }];
    [self.commitPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(self.height/2);
        make.bottom.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.mas_offset(15);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = kLineColor;
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (BOOL)isEqualPassword{
    BOOL isequal = [self.passwordView.textInput isEqualToString:self.commitPasswordView.textInput];

    return isequal;
}

- (NSString *)password{
//    if (!self.isEqualPassword) {
//        return nil;
//    }
    return self.passwordView.textInput;
}

@end
