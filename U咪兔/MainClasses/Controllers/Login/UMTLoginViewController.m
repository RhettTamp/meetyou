//
//  UMTLoginViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTLoginViewController.h"
#import "UMTRegisterViewController.h"
#import "UMTFindPasswordController.h"
#import "UMTRootViewController.h"

@interface UMTLoginViewController ()

@end

@implementation UMTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)registerClicked:(UIButton *)sender {
    UMTRegisterViewController *vc = [[UMTRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)fogotClicked:(UIButton *)sender {
    UMTFindPasswordController *vc = [[UMTFindPasswordController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)LoginClicked:(UIButton *)sender {
    UMTRootViewController *vc = [[UMTRootViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
