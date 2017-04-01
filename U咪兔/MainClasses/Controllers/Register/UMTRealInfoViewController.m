//
//  UMTRealInfoViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/1.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRealInfoViewController.h"
#import "UMTRootViewController.h"

@interface UMTRealInfoViewController ()

@end

@implementation UMTRealInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)addrightBar{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(skipCDInfomation)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)skipCDInfomation{
    [UMTUserMgr sharedMgr].userInfo.isHaveRealInfomation = NO;
    UMTRootViewController *vc = [[UMTRootViewController alloc]init];
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
