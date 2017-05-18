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
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    //    UIVibrancyEffect *effect = [UIVibrancyEffect effectForBlurEffect:blur];
//    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    visualView.frame = CGRectMake(0, 0, 120, 200);
//    visualView.alpha = 0.8;
////    self.visualView = visualView;
//    [view addSubview:visualView];
//    UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 50, 100)];
//    blueView.backgroundColor = [UIColor blueColor];
//    [visualView addSubview:blueView];
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
