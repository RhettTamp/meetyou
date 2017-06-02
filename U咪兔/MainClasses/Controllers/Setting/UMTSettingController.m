//
//  UMTSettingController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSettingController.h"
#import "UMTKeychainTool.h"
#import "UMTLoginViewController.h"
#import "UMTNavigationController.h"
#import "UMTBaseRequest.h"
#import "UMTAddActivityItem.h"
#import "UMTAboutViewController.h"

#define kItemHeight 44

@interface UMTSettingController ()

@end

@implementation UMTSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self addItem];
}

- (void)addItem{
    UIScrollView *s = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:s];
    UMTAddActivityItem *contentItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, 12, UMTScreenWidth-20, kItemHeight)];
    contentItem.numberofItems = 1;
    contentItem.itemNames = @[@"关于"];
    [s addSubview:contentItem];
    
    UIView *aboutView = [[UIView alloc]initWithFrame:CGRectMake(UMTScreenWidth-20-150, 0, 150, kItemHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aboutClicked)];
    [aboutView addGestureRecognizer:tap];
    [contentItem addSubview:aboutView];
    UILabel *aboutLabel = [[UILabel alloc]init];
    aboutLabel.text = @"V1.0.0";
    aboutLabel.textColor = Hex(0xbbbbbb);
    [aboutView addSubview:aboutLabel];
    [aboutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-26);
        make.centerY.equalTo(aboutView);
    }];

    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
    [aboutView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.equalTo(aboutView);
    }];
    
    UIButton *button = [[UIButton alloc]init];
    button.layer.cornerRadius = 4;
    [button setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = Hex(0xff6656);
    [button addTarget:self action:@selector(deleteClicked) forControlEvents:UIControlEventTouchUpInside];
    [s addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentItem.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(44);
    }];

}

-(void)aboutClicked{
    UMTAboutViewController *aboutVC = [[UMTAboutViewController alloc]init];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

- (void)deleteClicked{
    [UMTKeychainTool delete:kTokenKey];
    [UMTKeychainTool delete:@"lastDate"];
    UMTBaseRequest *request = [UMTBaseRequest sharedRequest];
    request.requestToken = nil;
    UMTLoginViewController *loginVc = [[UMTLoginViewController alloc]init];
    UMTNavigationController *nav = [[UMTNavigationController alloc]initWithRootViewController:loginVc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
