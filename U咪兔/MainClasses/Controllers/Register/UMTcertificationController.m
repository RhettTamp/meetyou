//
//  UMTcertificationController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTcertificationController.h"
#import "UMTSchoolInfoView.h"

@interface UMTcertificationController ()<chooseSchoolDelegate>

@end

@implementation UMTcertificationController

- (NSString *)title{
    return @"实名";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    [self initSchoolInfoView];
}

- (void)initSchoolInfoView{
    UMTSchoolInfoView *sclView = [[UMTSchoolInfoView alloc]initWithFrame:CGRectMake(0, 80, UMTScreenWidth, 80)];
    sclView.backgroundColor = [UIColor whiteColor];
    sclView.delegate = self;
    [self.view addSubview:sclView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark--chooseSchoolDelegate
- (void)chooseSchool{
    
}

@end
