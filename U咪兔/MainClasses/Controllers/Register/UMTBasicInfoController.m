//
//  UMTBasicInfoController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBasicInfoController.h"
#import "UMTPasswordView.h"
#import "UMTPublicInfoView.h"
#import "UMTInfoContactController.h"
#import "UMTcertificationController.h"

#define kItemHeight 40

@interface UMTBasicInfoController ()<publickInfoViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTPasswordView *passwordView;
@property (nonatomic,strong) UIButton *certificationButton;
@property (nonatomic,strong) UIButton *commitButton;
@property (nonatomic,strong) UILabel *contactLabel;
@property (nonatomic,strong) UILabel *certificationLabel;
@property (nonatomic,strong) UMTPublicInfoView *publicInfoView;
@property (nonatomic,strong) UMTInfoContactController *contactVC;

@end

@implementation UMTBasicInfoController
{
    CGFloat tableHeight;
}
- (NSString *)title{
    return @"基本信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableHeight = 120;
    [self initBackScroll];
    [self initPasswordView];
    [self initCertificationButton];
    [self initPublicInfoView];
    [self initContactTable];
    [self initCommitButton];
}

- (void)initBackScroll{
    UIControl *backControl = [[UIControl alloc]initWithFrame:self.view.bounds];
    [backControl addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, UMTScreenWidth, UMTScreenHeight-64)];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth, 840);
    scrollView.showsVerticalScrollIndicator = NO;
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView addSubview:backControl];
}

- (void)initPasswordView{
    UMTPasswordView *paswdView = [[UMTPasswordView alloc]initWithFrame:CGRectMake(0, 20, UMTScreenWidth, 80)];
    paswdView.backgroundColor = [UIColor whiteColor];
    _passwordView = paswdView;
    [self.scrollView addSubview:_passwordView];
}

- (void)initPublicInfoView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 80, 30)];
    label.text = @"公开信息";
    [self.scrollView addSubview:label];
    UMTPublicInfoView *publicView = [[UMTPublicInfoView alloc]initWithFrame:CGRectMake(0, 160, UMTScreenWidth, kItemHeight*3)];
    publicView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:publicView];
    publicView.delegate = self;
    self.publicInfoView = publicView;
}

- (void)initContactTable{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 320, 130, 30)];
    label.text = @"隐藏联系方式";
    [self.scrollView addSubview:label];
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 360, UMTScreenWidth, tableHeight)];
    UMTInfoContactController *helper = [[UMTInfoContactController alloc]initWithTableView:tableview];
    self.contactVC = helper;
    [self.scrollView addSubview:tableview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableHeightChanged:) name:@"tableHeightChange" object:nil];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 360+tableHeight, UMTScreenWidth-20, 80)];
    textLabel.text = @"建议至少填写一项隐藏方式，隐藏联系方式只会在两个人同时想要互相了解对方的前提下才可见";
    textLabel.numberOfLines = 0;
    [self.scrollView addSubview:textLabel];
    self.contactLabel = textLabel;
}


- (void)initCertificationButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 460+tableHeight, UMTScreenWidth-40, 40)];
    [button setTitle:@"实名认证" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(certificationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    self.certificationButton = button;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 520+tableHeight, UMTScreenWidth-40, 110)];
    label.text = @"为了用户们的安全，我们建议您现在就进行实名审核，若未能完成或未通过实名审核，将不能参与和发布任何约玩活动，仅能以游客的身份浏览查看。您也可以之后在应用中进行此项操作。";
    label.numberOfLines = 0;
    [self.scrollView addSubview:label];
    self.certificationLabel = label;
}

- (void)initCommitButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 650+tableHeight, UMTScreenWidth-40, 40)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    self.commitButton = button;
    
}

- (void)refreshUI{
    
    self.scrollView.contentSize = CGSizeMake(UMTScreenWidth, 710+tableHeight);
    self.contactLabel.frame = CGRectMake(10, 360+tableHeight, UMTScreenWidth-20, 80);
    self.certificationButton.frame = CGRectMake(20, 460+tableHeight, UMTScreenWidth-40, 40);
    self.certificationLabel.frame = CGRectMake(20, 520+tableHeight, UMTScreenWidth-40, 110);
    self.commitButton.frame = CGRectMake(20, 650+tableHeight, UMTScreenWidth-40, 40);
    [self.view layoutSubviews];
}


- (void)commitButtonClicked{
    
}

- (void)certificationButtonClicked{
    NSLog(@"%d",self.passwordView.isEqualPassword);
    NSLog(@"%@",self.publicInfoView.nikName);
    UMTcertificationController *vc = [[UMTcertificationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - publickInfoViewDelegate
- (void)sexItemClicked{
    self.publicInfoView.sex = @"11";
}

- (void)labelItemClicked{
    self.publicInfoView.label = @"22";
}

#pragma mark - nitification
- (void)tableHeightChanged:(NSNotification *)notification{
    tableHeight = [notification.userInfo[@"height"] floatValue];
    [self refreshUI];
}


- (void)backClicked{
    [self.view endEditing:YES];
}

@end
