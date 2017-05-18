//
//  UMTComitSuccessController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/16.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTComitSuccessController.h"
#import "UMTRootViewController.h"

@interface UMTComitSuccessController ()

@property (weak, nonatomic) IBOutlet UIView *enterView;

@end

@implementation UMTComitSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成功";
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(enterRoot)];
    [self.enterView addGestureRecognizer:tap];
//    self.navigationController.navigationBar.backItem
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)enterRoot{
    UMTRootViewController *rootVC = [[UMTRootViewController alloc]init];
    [self presentViewController:rootVC animated:YES completion:nil];
}

@end
