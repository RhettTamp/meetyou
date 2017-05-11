//
//  UMTActivityController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTActivityController.h"
#import "UMTActivityNavgationBar.h"
#import "UMTDetailActivityController.h"
#import "UMTActivitySimpleController.h"

@interface UMTActivityController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic,strong) UMTActivityNavgationBar *navBar;
@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) NSArray *controllers;

@end

@implementation UMTActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self initNavBar];
    [self configSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)configSubViews{
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(64);
        make.left.and.right.equalTo(self.view);
        make.bottom.mas_offset(-49);
    }];
}

- (void)initNavBar{
    UMTActivityNavgationBar *navBar = [[UMTActivityNavgationBar alloc]initWithFrame:CGRectMake(0, 20, UMTScreenWidth, 44)];
    [self.view addSubview:navBar];
    navBar.block = ^(UMTActivityNavgationBarIndex index) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pageViewController setViewControllers:@[self.controllers[index-100]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        });
    };
    self.navBar = navBar;
}

#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == 0||index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == NSNotFound||index == self.controllers.count-1) {
        return nil;
    }
    
    return [self.controllers objectAtIndex:index+1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController *controller = self.pageViewController.viewControllers[0];
    NSInteger index = [self.controllers indexOfObject:controller];
    [self.navBar selectedAtIndex:index+100];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.controllers.count;
}




#pragma mark - getter
- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
        UIPageViewController *page = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        page.delegate = self;
        page.dataSource = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [page setViewControllers:@[self.controllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        });
        
        [self addChildViewController:page];
        [self.view addSubview:page.view];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSArray *)controllers{
    if (!_controllers) {
        UMTDetailActivityController *detail = [[UMTDetailActivityController alloc]init];
        UMTActivitySimpleController *simple = [[UMTActivitySimpleController alloc]init];
        _controllers = @[detail,simple];
    }
    return _controllers;
}

@end
