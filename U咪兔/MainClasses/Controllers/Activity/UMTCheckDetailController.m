//
//  UMTCheckDetailController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTCheckDetailController.h"
#import "UMTActivitTopView.h"
#import "UMTSiteView.h"
#import "UMTCircleView.h"
#import "UMTDetailActicityView.h"
#import "UMTTagView.h"

@interface UMTCheckDetailController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTActivitTopView *topView;
@property (nonatomic,strong) UMTSiteView *siteView;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UMTCircleView *personCircle;
@property (nonatomic,strong) UMTCircleView *timeCircle;
@property (nonatomic,strong) UILabel *timeProgressLabel;
@property (nonatomic,strong) UILabel *personProgressLabel;
@property (nonatomic,strong) UMTDetailActicityView *detailView;
@property (nonatomic,strong) UMTTagView *tagView;

@end

@implementation UMTCheckDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = kCommonGreenColor;
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initUI{
    [self addScroolView];
    [self addTopView];
    [self addContentView];
    [self addDetailView];
}

- (void)addScroolView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth,810);
    NSLog(@"%f",UMTScreenWidth);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)addTopView{
    UMTActivitTopView *topView = [[UMTActivitTopView alloc]initWithFrame:CGRectMake(0, -64, UMTScreenWidth, 180)];
    topView.backgroundColor = kCommonGreenColor;
    topView.title = @"五一厦门三日游";
    topView.time = @"2017年05月01日-2017年05月03日";
    topView.timeLabel.font = kFont(12);
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
        make.height.mas_equalTo(120);
        make.right.equalTo(self.view).offset(-8);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"·号外·";
    label.font = [UIFont boldSystemFontOfSize:18];
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(mapView.mas_bottom).offset(10);
    }];
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈放哪哦法国不能惹果然不浓不够热";
    contentLabel.numberOfLines = 0;
    contentLabel.font = kFont(14);
    [self.scrollView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.height.mas_lessThanOrEqualTo(120);
    }];
    self.contentLabel = contentLabel;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kLineColor;
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(1);
        make.top.equalTo(contentLabel.mas_bottom).offset(20);
    }];
    self.line1 = line;
}

- (void)addDetailView{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"进度";
    label.font = kFont(18);
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.equalTo(self.line1.mas_bottom).offset(30);
    }];
    
    UMTCircleView *timeCircle = [[UMTCircleView alloc]initWithRadius:40 circleWidth:10 Progress:0.68];
    timeCircle.circleCocor = kCommonGreenColor;
    [self.scrollView addSubview:timeCircle];
    [timeCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(15);
        make.top.equalTo(self.line1.mas_bottom).offset(30);
        make.height.and.width.mas_equalTo(80);
    }];
    self.timeCircle = timeCircle;
    
    UMTCircleView *personCircle = [[UMTCircleView alloc]initWithRadius:28 circleWidth:10 Progress:0.5];
    personCircle.circleCocor = [UIColor orangeColor];
    [self.scrollView addSubview:personCircle];
    [personCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeCircle.mas_top).offset(10);
        make.left.equalTo(timeCircle.mas_left).offset(10);
        make.height.and.width.mas_equalTo(60);
    }];
    self.personCircle = personCircle;
    
    UILabel *tLabel = [[UILabel alloc]init];
    tLabel.text = @"报名时间已过";
    tLabel.textColor = kCommonGreenColor;
    [self.scrollView addSubview:tLabel];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeCircle.mas_right).offset(20);
        make.top.equalTo(timeCircle.mas_top).offset(15);
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = kCommonGreenColor;
    timeLabel.text = @"68";
    timeLabel.font = kFont(22);
    [self.scrollView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tLabel.mas_right);
        make.bottom.equalTo(tLabel.mas_bottom);
    }];
    self.timeProgressLabel = timeLabel;
    UILabel *timePercentLabel = [[UILabel alloc]init];
    timePercentLabel.text = @"%";
    timePercentLabel.textColor = kCommonGreenColor;
    [self.scrollView addSubview:timePercentLabel];
    [timePercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_right);
        make.bottom.equalTo(timeLabel.mas_bottom);
    }];
    
    UILabel *pLabel = [[UILabel alloc]init];
    pLabel.text = @"完成目标人数";
    pLabel.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:pLabel];
    [pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tLabel.mas_left);
        make.top.equalTo(tLabel.mas_bottom).offset(15);
    }];
    UILabel *personProgress = [[UILabel alloc]init];
    personProgress.textColor = [UIColor orangeColor];
    personProgress.text = @"50";
    personProgress.font = kFont(22);
    [self.scrollView addSubview:personProgress];
    [personProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pLabel.mas_right);
        make.bottom.equalTo(pLabel.mas_bottom);
    }];
    self.personProgressLabel = personProgress;
    UILabel *personPercentLabel = [[UILabel alloc]init];
    personPercentLabel.text = @"%";
    personPercentLabel.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:personPercentLabel];
    [personPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personProgress.mas_right);
        make.bottom.equalTo(pLabel.mas_bottom);
    }];
    
    UMTDetailActicityView *detailView = [[UMTDetailActicityView alloc]init];
    [self.scrollView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(timeCircle.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(180);
    }];
    self.detailView = detailView;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kLineColor;
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(1);
        make.top.equalTo(detailView.mas_bottom).offset(15);
    }];
    
    UMTTagView *tagView = [[UMTTagView alloc]init];
    tagView.tagStr = @"旅游";
    tagView.backgroundColor = [UIColor blueColor];
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
//        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-30);
    }];
}

- (void)issueActivity{
    
}

@end
