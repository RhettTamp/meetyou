//
//  UMTRootViewController.m
//  U米兔
//
//  Created by 谭培 on 2017/3/30.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRootViewController.h"
#import "UMTActivityController.h"
#import "UMTMessageController.h"
#import "UMTMeViewController.h"
#import "UMTNavigationController.h"
#import "UMTRecommendController.h"
#import "UMTTabBar.h"
#import "UMTIssueDetailActivityController.h"
#import "UMTIssueSimpleActivityController.h"

@interface UMTRootViewController ()<UMTTabBarDelegate>

@property (nonatomic,strong) NSArray *tabBarDefines;
@property (nonatomic,strong) UMTTabBar *myTabBar;
@property (nonatomic,strong) UIButton *issueDetailButton;
@property (nonatomic,strong) UIButton *issueSimpleButton;

@end

@implementation UMTRootViewController
{
    BOOL isShowIssueButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isShowIssueButton = NO;
    [self configSubControllers];
    [self.tabBar addSubview:self.myTabBar];
    [self initIssueButton];
}

- (void)initIssueButton{
    UIButton *detailButton = [[UIButton alloc]init];
    [detailButton setTitle:@"精心计划" forState:UIControlStateNormal];
    detailButton.backgroundColor = kCommonGreenColor;
    detailButton.alpha = 0;
    [detailButton addTarget:self action:@selector(issueDetailActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailButton];
    self.issueDetailButton = detailButton;
    [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-64);
        make.centerX.equalTo(self.view).offset(-40);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *simpleButton = [[UIButton alloc]init];
    [simpleButton setTitle:@"说走就走" forState:UIControlStateNormal];
    simpleButton.backgroundColor = kCommonGreenColor;
    simpleButton.alpha = 0;
    [simpleButton addTarget:self action:@selector(issueSimpleActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:simpleButton];
    self.issueSimpleButton = simpleButton;
    [simpleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-64);
        make.centerX.equalTo(self.view).offset(40);
        make.width.mas_equalTo(80);
    }];
}


- (void)configSubControllers{
    NSMutableArray *viewControllers = [NSMutableArray array];
//    for (NSDictionary *dic in self.tabBarDefines) {
//        Class vcClass = NSClassFromString(dic[@"viewController_class"]);
//        UIViewController *controller = [[vcClass alloc]init];
//        controller.title = dic[@"name"];
//        UMTNavigationController *navController = [[UMTNavigationController alloc]initWithRootViewController:controller];
//        
//        navController.navigationBar.tintColor = kCommonGreenColor;
//        navController.tabBarItem.title = dic[@"name"];
//        navController.navigationBar.barTintColor = kCommonGreenColor;
////        navController.tabBarController.tabBar.barTintColor = kCommonGreenColor;   //为什么这句话不行
//        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kCommonGreenColor} forState:UIControlStateSelected];
//        //img
//        navController.tabBarItem.image = [[UIImage imageNamed:dic[@"icon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        navController.tabBarItem.selectedImage = [[UIImage imageNamed:dic[@"icon_s"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        
//        
//        
//        [viewControllers addObject:navController];
//    }
    viewControllers = [NSMutableArray arrayWithArray:@[[UMTActivityController class],[UMTRecommendController class],[UMTMessageController class],[UMTMeViewController class]]];
    for (int i = 0; i < viewControllers.count; i++) {
        Class vcClass = viewControllers[i];
        UIViewController *vc = [[vcClass alloc] init];
        UMTNavigationController *nav = [[UMTNavigationController alloc]initWithRootViewController:vc];
        [viewControllers replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = 0;
}

//- (NSArray *)tabBarDefines{
//    NSArray *defineArray = @[
//                             @{@"name" : @"活动",
//                               @"icon" : @"home",
//                               @"icon_s" : @"selectedhome",
//                               @"viewController_class" : NSStringFromClass([UMTActivityController class])} ,
//                             @{@"name" : @"推荐",
//                               @"icon" : @"discover",
//                               @"icon_s" : @"selecteddiscover",
//                               @"viewController_class" : NSStringFromClass([UMTRecommendController class])},
//                             @{@"name" : @"",
//                               @"icon" : @"PlusButton",
//                               @"icon_s" : @"",
//                               @"viewController_class" : NSStringFromClass([UMTMessageController class])} ,
//                             @{@"name" : @"消息",
//                               @"icon" : @"messege",
//                               @"icon_s" : @"selectedmessege",
//                               @"viewController_class" : NSStringFromClass([UMTSettingController class])}];
//    return [defineArray copy];
//}

- (void)tabBar:(UMTTabBar *)tabBar Clickeditem:(NSInteger)index{
    if (index != UMTItemAddActivity) {
        self.selectedIndex = index-UMTItemActivity;
        return;
    }
    
    if (isShowIssueButton == NO) {
        [self showIssueButton];
        isShowIssueButton = YES;
    }else{
        [self hideIssueButton];
        isShowIssueButton = NO;
    }
}

- (void)showIssueButton{
    self.issueSimpleButton.alpha = 1;
    self.issueDetailButton.alpha = 1;
}

- (void)hideIssueButton{
    self.issueDetailButton.alpha = 0;
    self.issueSimpleButton.alpha = 0;
}

- (void)issueDetailActivity{
    UMTIssueDetailActivityController *issueVc = [[UMTIssueDetailActivityController alloc]init];
    UMTNavigationController *nav = [[UMTNavigationController alloc]initWithRootViewController:issueVc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)issueSimpleActivity{
    
    UMTIssueSimpleActivityController *simpleVc = [[UMTIssueSimpleActivityController alloc]init];
    UMTNavigationController *nav = [[UMTNavigationController alloc]initWithRootViewController:simpleVc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (UMTTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[UMTTabBar alloc]initWithFrame:CGRectMake(0, 0, UMTScreenWidth, 49)];
        _myTabBar.delegate = self;
    }
    return _myTabBar;
}

@end
