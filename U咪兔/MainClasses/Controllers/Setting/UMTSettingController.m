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

@interface UMTSettingController ()

@end

@implementation UMTSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 50, 40)];
    [button setTitle:@"退出" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(deleteClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)deleteClicked{
    [UMTKeychainTool delete:kTokenKey];
    [UMTKeychainTool delete:@"lastDate"];
    UMTLoginViewController *loginVc = [[UMTLoginViewController alloc]init];
    UMTNavigationController *nav = [[UMTNavigationController alloc]initWithRootViewController:loginVc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
