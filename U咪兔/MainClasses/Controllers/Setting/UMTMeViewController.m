//
//  UMTMeViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/2.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTMeViewController.h"
#import "UMTSettingController.h"

@interface UMTMeViewController ()

@end

@implementation UMTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUi];
}

- (void)initUi{
    [self addRightButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)addRightButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightButtonClicked{
    UMTSettingController *settingVc = [[UMTSettingController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

@end
