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
#import "UMTSettingController.h"
#import "UMTNavigationController.h"

@interface UMTRootViewController ()

@property (nonatomic,strong) NSArray *tabBarDefines;

@end

@implementation UMTRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubControllers];
}

- (void)createCustomeTabBar{
    
}

- (void)configSubControllers{
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSDictionary *dic in self.tabBarDefines) {
        Class vcClass = NSClassFromString(dic[@"viewController_class"]);
        UIViewController *controller = [[vcClass alloc]init];
        controller.title = dic[@"name"];
        UMTNavigationController *navController = [[UMTNavigationController alloc]initWithRootViewController:controller];
        
        navController.navigationBar.tintColor = [UIColor redColor];
        navController.tabBarItem.title = dic[@"name"];
        navController.navigationBar.barTintColor = [UIColor redColor];
        
        //img
        
        
        
        
        [viewControllers addObject:navController];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = 0;
}

- (NSArray *)tabBarDefines{
    NSArray *defineArray = @[
                             @{@"name" : @"活动",
                               @"icon" : @"icon_mainHome",
                               @"icon_s" : @"icon_mainHome_f",
                               @"viewController_class" : NSStringFromClass([UMTActivityController class])} ,
                             @{@"name" : @"消息",
                               @"icon" : @"icon_mainNews",
                               @"icon_s" : @"icon_mainNews_f",
                               @"viewController_class" : NSStringFromClass([UMTMessageController class])} ,
                             @{@"name" : @"个人中心",
                               @"icon" : @"icon_mainMore",
                               @"icon_s" : @"icon_mainMore_f2",
                               @"viewController_class" : NSStringFromClass([UMTSettingController class])}];
    return [defineArray copy];
}

@end
