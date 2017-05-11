//
//  UMTCheckSimpleController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTCheckSimpleController.h"
#import "UMTActivitTopView.h"
#import "UMTSiteView.h"
#import "UMTCircleView.h"
#import "UMTSimpleActivityView.h"
#import "UMTTagView.h"

@interface UMTCheckSimpleController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTActivitTopView *topView;
@property (nonatomic,strong) UMTSiteView *siteView;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UILabel *perdsonCountLable;
@property (nonatomic,strong) UMTSimpleActivityView *detailView;
@property (nonatomic,strong) UMTTagView *tagView;

@end

@implementation UMTCheckSimpleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.barTintColor = kCommonGreenColor;
    //    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)initUI{
    
    [self addScroolView];
    [self addTopView];
    [self addContentView];
    [self addDetailView];
}

- (void)addScroolView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth,700);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)addTopView{
    UMTActivitTopView *topView = [[UMTActivitTopView alloc]initWithFrame:CGRectMake(0, -64, UMTScreenWidth, 180)];
    topView.backgroundColor = kCommonGreenColor;
    topView.title = @"五一厦门三日游";
    topView.time = @"00:30:22 以内";
    topView.timeLabel.font = kFont(15);
    [self.scrollView addSubview:topView];
    self.topView = topView;
}

- (void)addContentView{
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
    siteView.site = @"重庆邮电大学风雨操场";
    siteView.backgroundColor = kLineColor;
    [self.scrollView addSubview:siteView];
    [siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.mas_offset(180-64+20);
        make.height.mas_equalTo(20);
    }];
    
    UIView *mapView = [[UIView alloc]init];
    mapView.backgroundColor = kCommonGreenColor;
    [self.scrollView addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(siteView.mas_bottom).offset(10);
        make.height.and.width.mas_equalTo(120);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"号外";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.scrollView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mapView.mas_right).offset(5);
        make.top.equalTo(mapView.mas_top);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"晚上78节，风雨操场约羽毛球。菜鸟一枚，求带";
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    [self.scrollView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.bottom.mas_lessThanOrEqualTo(mapView.mas_bottom);
    }];
    
    UILabel *hintLabel = [[UILabel alloc]init];
    hintLabel.text = @"距你的位置";
    hintLabel.font = kFont(13);
    [self.scrollView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(mapView.mas_bottom).offset(10);
    }];
    
    UILabel *distanceLabel = [[UILabel alloc]init];
    distanceLabel.font = kFont(13);
    distanceLabel.textColor = kCommonGreenColor;
    distanceLabel.text = @"500m-1km";
    [self.scrollView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintLabel.mas_right).offset(10);
        make.top.equalTo(hintLabel.mas_top);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kLineColor;
    [self.scrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view).mas_offset(-8);
        make.height.mas_equalTo(1);
        make.top.equalTo(hintLabel.mas_bottom).offset(30);
    }];
    self.line1 = lineView;
}

- (void)addDetailView{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"进度";
    label.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.equalTo(self.line1.mas_bottom).offset(15);
    }];
    
    UMTCircleView *circleView = [[UMTCircleView alloc]initWithRadius:30 circleWidth:10 Progress:.2];
    circleView.circleCocor = [UIColor orangeColor];
    [self.scrollView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(60);
        make.top.equalTo(label.mas_top);
        make.left.equalTo(label.mas_right).offset(25);
    }];
    
    UILabel *hintLable = [[UILabel alloc]init];
    hintLable.textColor = [UIColor orangeColor];
    hintLable.text = @"完成目标人数";
    [self.scrollView addSubview:hintLable];
    [hintLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).offset(25);
        make.centerY.equalTo(circleView);
    }];
    UILabel *personCountLabel = [[UILabel alloc]init];
    personCountLabel.font = kFont(22);
    personCountLabel.text = @"20";
    personCountLabel.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:personCountLabel];
    [personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintLable.mas_right);
        make.bottom.equalTo(hintLable.mas_bottom);
    }];
    UILabel *percentLabel = [[UILabel alloc]init];
    percentLabel.textColor = [UIColor orangeColor];
    percentLabel.text = @"%";
    [self.scrollView addSubview:percentLabel];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCountLabel.mas_right);
        make.bottom.equalTo(hintLable.mas_bottom);
    }];
    
//    UILabel *percentLabel = [[UILabel alloc]init];
//    percentLabel.textColor = [UIColor orangeColor];
//    percentLabel.text = @"%";
//    [self.scrollView addSubview:percentLabel];
//    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view.mas_right).offset(-20);
//        make.centerY.equalTo(circleView);
//    }];
//    
//    UILabel *personCountLabel = [[UILabel alloc]init];
//    personCountLabel.font = kFont(22);
//    personCountLabel.text = @"20";
//    personCountLabel.textColor = [UIColor orangeColor];
//    [self.scrollView addSubview:personCountLabel];
//    [personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(percentLabel.mas_left);
//        make.bottom.equalTo(percentLabel.mas_bottom);
//    }];
//    
//    UILabel *hintLable = [[UILabel alloc]init];
//    hintLable.textColor = [UIColor orangeColor];
//    hintLable.text = @"完成目标人数";
//    [self.scrollView addSubview:hintLable];
//    [hintLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(personCountLabel.mas_left);
//        make.bottom.equalTo(percentLabel.mas_bottom);
//    }];
    
    UMTSimpleActivityView *detaiView = [[UMTSimpleActivityView alloc]init];
    [self.scrollView addSubview:detaiView];
    [detaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(150);
        make.top.equalTo(circleView.mas_bottom).offset(30);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kLineColor;
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detaiView.mas_bottom).offset(15);
        make.left.mas_equalTo(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(1);
    }];
    
    UMTTagView *tagView = [[UMTTagView alloc]init];
    tagView.tagStr = @"运动";
    tagView.backgroundColor = kCommonGreenColor;
    [self.scrollView addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(line.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    self.tagView = tagView;
    
    UIButton *issueButton = [[UIButton alloc]init];
    [issueButton setTitle:@"报名" forState:UIControlStateNormal];
    [issueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    issueButton.backgroundColor = kCommonGreenColor;
    issueButton.layer.cornerRadius = 4;
    [issueButton addTarget:self action:@selector(issueActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:issueButton];
    [issueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
        make.top.equalTo(tagView.mas_bottom).offset(30);
    }];
}

- (void)issueActivity{
    
}

@end
