//
//  UMTMeViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/2.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTMeViewController.h"
#import "UMTSettingController.h"
#import "UMTMeHeadView.h"
#import "UMTMeItemView.h"

@interface UMTMeViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTMeHeadView *headView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *schoolLabel;

@end

@implementation UMTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUi];

}

- (void)initUi{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    self.title = @"我";
    [self addRightButton];
    [self addScrollView];
    [self addtopView];
    [self addItemView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)addRightButton{
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleDone target:self action:@selector(settingButtonClicked)];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStyleDone target:self action:@selector(editButtonClicked)];
    self.navigationItem.rightBarButtonItems = @[settingItem,editItem];
}

- (void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = self.view.size;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)addtopView{
    UMTMeHeadView *headImageView = [[UMTMeHeadView alloc]init];
    headImageView.headImage = [UIImage imageNamed:@"g1"];
    headImageView.progress = 0.5;
    CGFloat width = 86.0/375*UMTScreenWidth;
    [self.scrollView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(width);
        make.top.mas_offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    nameLabel.textColor = Hex(0x333333);
    nameLabel.text = @"很酷的名字";
    [self.scrollView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(headImageView.mas_bottom).offset(16);
    }];
    
    UILabel *schoolLabel = [[UILabel alloc]init];
    schoolLabel.font = kFont(11);
    schoolLabel.textColor = Hex(0xbbbbbb);
    schoolLabel.text = @"重庆邮电大学";
    [self.scrollView addSubview:schoolLabel];
    [schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameLabel.mas_bottom).offset(2);
    }];
    self.schoolLabel = schoolLabel;
}

- (void)addItemView{
    CGFloat width = UMTScreenWidth/4;
    UMTMeItemView *focusingItemView = [[UMTMeItemView alloc]init];
    focusingItemView.labelText = @"我关注的人";
    focusingItemView.number = 0;
    [self.scrollView addSubview:focusingItemView];
    [focusingItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(64);
        make.top.equalTo(self.schoolLabel.mas_bottom).offset(20);
    }];
    UMTMeItemView *focusedItemView = [[UMTMeItemView alloc]init];
    focusedItemView.labelText = @"关注我的人";
    focusedItemView.number = 0;
    [self.scrollView addSubview:focusedItemView];
    [focusedItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(focusingItemView.mas_right);
        make.top.equalTo(focusingItemView.mas_top);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(64);
    }];
    UMTMeItemView *joinedItemView = [[UMTMeItemView alloc]init];
    joinedItemView.labelText = @"参与的活动";
    joinedItemView.number = 0;
    [self.scrollView addSubview:joinedItemView];
    [joinedItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(focusedItemView.mas_right);
        make.top.equalTo(focusingItemView.mas_top);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(64);
    }];
    UMTMeItemView *createdItemView = [[UMTMeItemView alloc]init];
    createdItemView.labelText = @"发起的活动";
    createdItemView.number = 0;
    [self.scrollView addSubview:createdItemView];
    [createdItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(joinedItemView.mas_right);
        make.top.equalTo(focusingItemView.mas_top);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(64);
    }];
}

- (void)editButtonClicked{
    
}

- (void)settingButtonClicked{
    UMTSettingController *settingVc = [[UMTSettingController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

@end
