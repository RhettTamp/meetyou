//
//  UMTBaseViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBaseViewController.h"

@interface UMTBaseViewController ()

@end

@implementation UMTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCommonbackColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


@end
