//
//  UMTResetPasswordController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTResetPasswordController.h"
#import "UMTPasswordView.h"

@interface UMTResetPasswordController ()

@end

@implementation UMTResetPasswordController

- (NSString *)title{
    return @"重置密码";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    UMTPasswordView *passwordView = [[UMTPasswordView alloc]initWithFrame:CGRectMake(0, 84, UMTScreenWidth, 88)];
    passwordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordView];
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 172+30, UMTScreenWidth-40, 44)];
    commitButton.layer.cornerRadius = 4;
    [commitButton setTitle:@"确认重置" forState:UIControlStateNormal];
    [commitButton setBackgroundColor:kCommonGreenColor];
    commitButton.titleLabel.textColor = [UIColor whiteColor];
    commitButton.titleLabel.font = kDefaultFont;
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
}

- (void)commitButtonClicked{
    
    
}

@end
