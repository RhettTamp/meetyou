//
//  UMTRecommendController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRecommendController.h"
#import "UMTNearbyController.h"
#import "UMTAttentionController.h"


@interface UMTRecommendController ()<UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) UILabel *nearbyLabel;
@property (nonatomic,strong) UILabel *attentionLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) NSArray *controllers;

@end

@implementation UMTRecommendController
{
    NSInteger lastIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    lastIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)initUI{
    [self addTopView];
    [self configureSubViews];
}

- (void)addTopView{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.top.mas_offset(64);
    }];
    self.topView = topView;
    
    UILabel *nearbyLabel = [[UILabel alloc]init];
    nearbyLabel.text = @"附近的人";
    nearbyLabel.font = kFont(15);
    nearbyLabel.textColor = Hex(0x262626);
    [topView addSubview:nearbyLabel];
    [nearbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView).offset(-40);
        make.centerY.equalTo(topView);
    }];
    self.nearbyLabel = nearbyLabel;
    
    UILabel *attentionLabel = [[UILabel alloc]init];
    attentionLabel.text = @"关注的人";
    attentionLabel.font = kFont(15);
    attentionLabel.textColor = Hex(0x262626);
    [topView addSubview:attentionLabel];
    [attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView).offset(40);
        make.centerY.equalTo(topView);
    }];
    self.attentionLabel = attentionLabel;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kCommonGreenColor;
    [topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nearbyLabel);
        make.bottom.equalTo(topView.mas_bottom);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(4);
    }];
    self.lineView = lineView;
}

- (void)configureSubViews{
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(2);
        make.left.and.right.equalTo(self.view);
        make.bottom.mas_offset(-49);
    }];
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
    if (index == 0&&lastIndex == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.centerX -= CGRectGetWidth(self.attentionLabel.frame)+20;
        }];
        lastIndex = 0;
    }else if(index == 1&&lastIndex == 0){
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.centerX += CGRectGetWidth(self.attentionLabel.frame)+20;
        }];
        lastIndex = 1;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.controllers.count;
}


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
        UMTAttentionController *attention = [[UMTAttentionController alloc]init];
        UMTNearbyController *nearby = [[UMTNearbyController alloc]init];
        _controllers = @[nearby,attention];
    }
    return _controllers;
}

@end
