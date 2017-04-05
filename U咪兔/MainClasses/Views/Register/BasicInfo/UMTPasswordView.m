//
//  UMTPasswordView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/4.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTPasswordView.h"
#import "UMTInfoItemView.h"

@interface UMTPasswordView()

@property (nonatomic,strong) UMTInfoItemView *passwordView;
@property (nonatomic,strong) UIView *lineView;
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
        self.passwordView.inputTextField.secureTextEntry = YES;
        [self addSubview:self.passwordView];
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor grayColor];
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
        make.left.mas_offset(10);
        make.centerY.equalTo(self);
        make.height.mas_offset(1);
    }];
}

- (BOOL)isEqualPassword{
    BOOL isequal = [self.passwordView.textInput isEqualToString:self.commitPasswordView.textInput];

    return isequal;
}

- (NSString *)password{
    if (!self.isEqualPassword) {
        return nil;
    }
    return self.passwordView.textInput;
}

@end
