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
#import "UMTEditViewController.h"
#import "UMTShareViewController.h"
#import "UMTFindfTableViewCell.h"

@interface UMTMeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTMeHeadView *headView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *schoolLabel;
@property (nonatomic,strong) UIImageView *sexImage;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UMTMeItemView *focusingItemView;

@end

@implementation UMTMeViewController
{
    BOOL isShowHiddenView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUi];
    isShowHiddenView = NO;
}

- (void)initUi{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    self.navigationItem.title = @"我";
//    [self.tabBarItem setTitle:@""];
    [self addRightButton];
    [self addScrollView];
    [self addtopView];
    [self addItemView];
    [self addTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = Hex(0x030303);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.tintColor = kCommonGreenColor;
}

- (void)addRightButton{
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleDone target:self action:@selector(settingButtonClicked)];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStyleDone target:self action:@selector(editButtonClicked)];
    self.navigationItem.rightBarButtonItems = @[settingItem,editItem];
    
    UIBarButtonItem *lauchItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"launch"] style:UIBarButtonItemStyleDone target:self action:@selector(launchButtonClicked)];
    self.navigationItem.leftBarButtonItem = lauchItem;
}

- (void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth, UMTScreenHeight*2);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)addTableView{
    self.tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UMTScreenWidth, 25)];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = Hex(0x040404);
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = @"点滴";
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.centerY.equalTo(headView);
    }];
    UIView *circleView = [[UIView alloc]init];
    circleView.backgroundColor = Hex(0x000000);
    circleView.layer.cornerRadius = 2;
    [headView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(4);
        make.centerY.equalTo(headView);
        make.right.equalTo(label.mas_left).offset(-12);
    }];
    UIView *circleView2 = [[UIView alloc]init];
    circleView2.backgroundColor = Hex(0x000000);
    circleView2.layer.cornerRadius = 2;
    [headView addSubview:circleView2];
    [circleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(4);
        make.centerY.equalTo(headView);
        make.right.equalTo(label.mas_right).offset(12);
    }];
    _tableView.tableHeaderView = headView;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.focusingItemView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

- (void)addhideView{
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.image = [UIImage imageNamed:@"m5"];
    CGFloat width = 68.0/375*UMTScreenWidth;
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
    
    UIImageView *sexImage = [[UIImageView alloc]init];
    sexImage.image = [UIImage imageNamed:@"boy"];
    [self.scrollView addSubview:sexImage];
    [sexImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(8);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
        make.centerY.equalTo(nameLabel);
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
}

- (void)addtopView{
    UMTMeHeadView *headImageView = [[UMTMeHeadView alloc]init];
    headImageView.headImage = [UIImage imageNamed:@"m4"];
    headImageView.progress = 0.5;
    CGFloat width = 80.0/375*UMTScreenWidth;
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
    
    _sexImage = [[UIImageView alloc]init];
    _sexImage.image = [UIImage imageNamed:@"boy"];
    [self.scrollView addSubview:_sexImage];
    [_sexImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(8);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
        make.centerY.equalTo(nameLabel);
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
    self.focusingItemView = focusingItemView;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 430;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UMTFindfTableViewCell alloc]init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)editButtonClicked{
    UMTEditViewController *editVC = [[UMTEditViewController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)settingButtonClicked{
    UMTSettingController *settingVc = [[UMTSettingController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (void)launchButtonClicked{
    UMTShareViewController *shareVC = [[UMTShareViewController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",_scrollView.contentOffset.y);
    if (scrollView == _tableView) {
        if (_tableView.contentOffset.y < 280) {
            _scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y-64);
        }
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (scrollView.contentOffset.y < -200.0/668*UMTScreenHeight&&isShowHiddenView==NO) {
//        _scrollView.frame = CGRectMake(0, UMTScreenHeight-250, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
//        self.navigationController.navigationBar.hidden = YES;
//        isShowHiddenView = YES;
//    }
//    if (scrollView.contentOffset.y > -UMTScreenHeight+100.0/668&&scrollView.contentOffset.y < -UMTScreenHeight+200.0/668&&isShowHiddenView==YES) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//        self.navigationController.navigationBar.hidden = NO;
//        isShowHiddenView = NO;
//    }
//}

@end
