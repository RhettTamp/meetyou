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
#import "UMTActivityTypeView.h"

@interface UMTRootViewController ()<UMTTabBarDelegate>

@property (nonatomic,strong) NSArray *tabBarDefines;
@property (nonatomic,strong) UMTTabBar *myTabBar;
@property (nonatomic,strong) UMTActivityTypeView *detailTypeView;
@property (nonatomic,strong) UMTActivityTypeView *simpleTypeView;
//@property (nonatomic,strong) UIButton *issueSimpleButton;
@property (nonatomic,strong) UIVisualEffectView *visualView;
@property (nonatomic,strong) UIButton *quitIssueButton;

@end

@implementation UMTRootViewController
{
    BOOL isShowIssueButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isShowIssueButton = NO;
    [self configSubControllers];
    [self.tabBar removeFromSuperview];
    [self.view addSubview:self.myTabBar];
//    for (UITabBarItem *item in self.tabBar.items) {
//        item.title = @"";
//        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    }
    [self initIssueView];
}


- (void)initIssueView{
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blur];
    visualView.frame = self.view.bounds;
    visualView.alpha = 0;
    self.visualView = visualView;
    [self.view addSubview:visualView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"选择发布活动类型";
    titleLabel.textColor = Hex(0x8e8e8e);
    titleLabel.font = kFont(24);
    [visualView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(visualView);
        make.top.mas_offset(UMTScreenHeight*200/667.0);
    }];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"SELECT TYPE";
    label.textColor = Hex(0x8e8e8e);
    label.font = kFont(15);
    [visualView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.centerX.equalTo(visualView);
    }];

    UMTActivityTypeView *detailType = [[UMTActivityTypeView alloc]init];
    detailType.name = @"精心计划";
    detailType.buttonImage = [UIImage imageNamed:@"planActivity"];
    detailType.alpha = 0;
    __weak typeof(self) weakSelf = self;
    detailType.block = ^(UIButton *button) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf issueDetailActivity];
        [strongSelf hideIssueView];
    };
    [self.view addSubview:detailType];
//    [visualView.contentView addSubview:issueView];
    [detailType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-80);
        make.centerX.equalTo(self.view).offset(-60);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    self.detailTypeView = detailType;
    
    UMTActivityTypeView *simpleType = [[UMTActivityTypeView alloc]init];
    simpleType.name = @"说走就走";
    simpleType.buttonImage = [UIImage imageNamed:@"rightnowActivity"];
    simpleType.alpha = 0;
    simpleType.block = ^(UIButton *button) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf issueSimpleActivity];
        [strongSelf hideIssueView];
    };
    [self.view addSubview:simpleType];
    [simpleType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-80);
        make.centerX.equalTo(self.view).offset(60);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    self.simpleTypeView = simpleType;
    
    UIButton *quitIssueButton = [[UIButton alloc]init];
    [quitIssueButton setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
    quitIssueButton.alpha = 0;
    [quitIssueButton addTarget:self action:@selector(hideIssueView) forControlEvents:UIControlEventTouchUpInside];
    self.quitIssueButton = quitIssueButton;
    [self.view addSubview:quitIssueButton];
    [quitIssueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(19);
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(-15);
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
    [self showIssueView];
//    if (isShowIssueButton == NO) {
//        [self showIssueView];
//        isShowIssueButton = YES;
//    }else{
//        [self hideIssueView];
//        isShowIssueButton = NO;
//    }
}

- (void)showIssueView{
    self.detailTypeView.centerY += 200;
    self.simpleTypeView.centerY += 200;
    [UIView animateWithDuration:0.5 animations:^{
        self.visualView.alpha = 1;
        self.detailTypeView.alpha = 1;
        self.simpleTypeView.alpha = 1;
        self.quitIssueButton.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.detailTypeView.centerY -= 200;
            self.simpleTypeView.centerY -= 200;
        } completion:nil];
    }];
   
}

- (void)hideIssueView{
    [UIView animateWithDuration:0.5 animations:^{
        self.visualView.alpha = 0;
        self.detailTypeView.centerY += 200;
        self.simpleTypeView.centerY += 200;
        self.quitIssueButton.alpha = 0;
    } completion:^(BOOL finished) {
        self.detailTypeView.alpha = 0;
        self.simpleTypeView.alpha = 0;
        self.detailTypeView.centerY -= 200;
        self.simpleTypeView.centerY -= 200;
    }];
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
        _myTabBar = [[UMTTabBar alloc]initWithFrame:CGRectMake(0, UMTScreenHeight - 49, UMTScreenWidth, 49)];
        _myTabBar.delegate = self;
    }
    return _myTabBar;
}

@end
