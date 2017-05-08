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
#import "UIResponder+Extension.h"
#import "UMTRootViewController.h"
#import "UMTSaveUserInfoHelper.h"
#import "UMTAlertView.h"
#import "UMTRegisterHelper.h"
#import "UMTRegesterRequest.h"
#import "UMTKeychainTool.h"

#define kItemHeight 44

@interface UMTBasicInfoController ()<publickInfoViewDelegate,UMTAlertViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTPasswordView *passwordView;
@property (nonatomic,strong) UIButton *certificationButton;
@property (nonatomic,strong) UIButton *commitButton;
@property (nonatomic,strong) UILabel *contactLabel;
@property (nonatomic,strong) UILabel *certificationLabel;
@property (nonatomic,strong) UIView *contactBottomLine;
@property (nonatomic,strong) UMTPublicInfoView *publicInfoView;
@property (nonatomic,strong) UMTInfoContactController *contactVC;
@property (nonatomic,strong) UMTAlertView *sexAlert;
@property (nonatomic,strong) UMTAlertView *labelAlert;

@end

@implementation UMTBasicInfoController
{
    CGFloat tableHeight;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)title{
    return @"基本信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableHeight = kItemHeight*3;
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
    scrollView.backgroundColor = kCommonbackColor;
    scrollView.contentSize = CGSizeMake(UMTScreenWidth, 226+20+kItemHeight*7+kItemHeight*3+18+18+18);
    scrollView.showsVerticalScrollIndicator = NO;
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView addSubview:backControl];
}

- (void)initPasswordView{
    UMTPasswordView *paswdView = [[UMTPasswordView alloc]initWithFrame:CGRectMake(0, 20, UMTScreenWidth, kItemHeight*2)];
    paswdView.backgroundColor = [UIColor whiteColor];
    _passwordView = paswdView;
    [self.scrollView addSubview:_passwordView];
}

- (void)initPublicInfoView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 40+kItemHeight*2, 60, 18)];
    label.text = @"公开信息";
    label.textColor = Hex(0x8f8e94);
    label.font = kFont(13);
    [self.scrollView addSubview:label];
    UMTPublicInfoView *publicView = [[UMTPublicInfoView alloc]initWithFrame:CGRectMake(0, 48+kItemHeight*2+18, UMTScreenWidth, kItemHeight*3)];
    publicView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:publicView];
    publicView.delegate = self;
    self.publicInfoView = publicView;
    
    self.sexAlert = [[UMTAlertView alloc]initWithFuncArray:@[@"女",@"男"]];
    self.labelAlert = [[UMTAlertView alloc]initWithFuncArray:@[@"吃货",@"运动健儿",@"旅游达人"]];
    self.sexAlert.delegate = self;
    self.labelAlert.delegate = self;
}

- (void)initContactTable{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 68+kItemHeight*2+kItemHeight*3+18, 90, 18)];
    label.text = @"隐藏联系方式";
    label.textColor = Hex(0x8f8e94);
    label.font = kFont(13);
    [self.scrollView addSubview:label];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5+76+kItemHeight*2+kItemHeight*3+18+18, UMTScreenWidth, 0.5)];
    topLine.backgroundColor = kLineColor;
    [self.scrollView addSubview:topLine];
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 76+kItemHeight*2+kItemHeight*3+18+18, UMTScreenWidth, kItemHeight*3)];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 76+kItemHeight*2+kItemHeight*3+18+18+kItemHeight*3, UMTScreenWidth, 0.5)];
    bottomLine.backgroundColor = kLineColor;
    [self.scrollView addSubview:bottomLine];
    self.contactBottomLine = bottomLine;
    
    UMTInfoContactController *helper = [[UMTInfoContactController alloc]initWithTableView:tableview];
    self.contactVC = helper;
    [self.scrollView addSubview:tableview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableHeightChanged:) name:@"tableHeightChange" object:nil];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 84+kItemHeight*5+kItemHeight*3+18+18, UMTScreenWidth-30, 36)];
    textLabel.text = @"建议至少填写一项隐藏方式，隐藏联系方式只会在两个人同时想要互相了解对方的前提下才可见";
    textLabel.textColor = Hex(0x8f8e94);
    textLabel.font = kFont(13);
    textLabel.numberOfLines = 0;
    [self.scrollView addSubview:textLabel];
    self.contactLabel = textLabel;
    
}


- (void)initCertificationButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 132+kItemHeight*5+kItemHeight*3+18+18+18, UMTScreenWidth-40, kItemHeight)];
    [button setTitle:@"学籍审核" forState:UIControlStateNormal];
    button.backgroundColor = kCommonGreenColor;
    button.titleLabel.font = kDefaultFont;
    [button addTarget:self action:@selector(certificationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 4;
    [self.scrollView addSubview:button];
    self.certificationButton = button;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 154+kItemHeight*7+kItemHeight*3+18+18+18, UMTScreenWidth-40, 72)];
    label.textColor = Hex(0x8f8e94);
    label.font = kFont(13);
    label.text = @"为了用户们的安全，我们建议您现在就进行实名审核，若未能完成或未通过实名审核，将不能参与和发布任何约玩活动，仅能以游客的身份浏览查看。您也可以之后在应用中进行此项操作。";
    label.numberOfLines = 0;
    [self.scrollView addSubview:label];
    self.certificationLabel = label;
}

- (void)initCommitButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 146+kItemHeight*6+kItemHeight*3+18+18+18, UMTScreenWidth-40, kItemHeight)];
    [button setTitle:@"跳过学籍审核" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"SkipButton"] forState:UIControlStateNormal];
    button.titleLabel.font = kDefaultFont;
    [button setTitleColor:kCommonGreenColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    self.commitButton = button;
    
}

- (void)refreshUI{
    
    self.contactBottomLine.frame = CGRectMake(0, 76+kItemHeight*2+tableHeight+18+18+kItemHeight*3, UMTScreenWidth, 0.5);
    self.scrollView.contentSize = CGSizeMake(UMTScreenWidth, 226+20+kItemHeight*4+tableHeight+kItemHeight*3+18+18+18);
    self.contactLabel.frame = CGRectMake(15, 84+kItemHeight*5+tableHeight+18+18, UMTScreenWidth-30, 36);
    self.certificationButton.frame = CGRectMake(20, 132+kItemHeight*2+tableHeight+kItemHeight*3+18+18+18, UMTScreenWidth-40, kItemHeight);
    self.certificationLabel.frame = CGRectMake(20, 154+kItemHeight*4+tableHeight+kItemHeight*3+18+18+18, UMTScreenWidth-40, 72);
    self.commitButton.frame = CGRectMake(20, 146+kItemHeight*3+tableHeight+kItemHeight*3+18+18+18, UMTScreenWidth-40, kItemHeight);
}


- (void)commitButtonClicked{
    if (self.passwordView.password.length < 6) {
        [[UMTProgressHUD sharedHUD]showWithText:@"密码不能少于六位" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (self.passwordView.isEqualPassword == NO) {
        [[UMTProgressHUD sharedHUD]showWithText:@"密码输入不一致" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!self.publicInfoView.nikName||self.publicInfoView.nikName.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!self.publicInfoView.sex||self.publicInfoView.sex.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!self.publicInfoView.label||self.publicInfoView.label.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    NSDictionary *contactDic = [self.contactVC getContactInfo];
    NSArray *contacts = [contactDic allKeys];
    if (!contacts||contacts.count == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    [self saveInfo];
    [[UMTProgressHUD sharedHUD] rotateWithText:@"注册中" inView:self.view];
    [UMTRegesterRequest RegisterWithCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD] hideAfterDelay:0];
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            if ([response[@"status_code"] isEqualToString:@"2001"]) {
                NSString *token = response[@"token"];
                NSDate *date = [NSDate date];
                [UMTKeychainTool save:kTokenKey data:token];
                [UMTKeychainTool save:@"lastDate" data:date];
                
                [[UMTProgressHUD sharedHUD] hideAfterDelay:0];
                [[UMTProgressHUD sharedHUD] showWithText:@"注册成功" inView:self.view hideAfterDelay:0.5];
                UMTRootViewController *rootVc = [[UMTRootViewController alloc]init];
                [self presentViewController:rootVc animated:YES completion:nil];
            }else{
               [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",response[@"info"]] inView:self.view hideAfterDelay:0.5];
            }
           
        }
    }];
    
}

- (void)saveInfo{
    NSString *password = self.passwordView.password;
    NSString *nikName = self.publicInfoView.nikName;
    NSString *sex = self.publicInfoView.sex;
    NSString *label = self.publicInfoView.label;
    NSDictionary *contactDic = [self.contactVC getContactInfo];
    UMTUserMgr *sharedMgr = [UMTUserMgr sharedMgr];
    sharedMgr.userInfo.userPassword = password;
    sharedMgr.userInfo.userNickname = nikName;
    sharedMgr.userInfo.userSex = sex;
    sharedMgr.userInfo.userLabel = label;
    sharedMgr.userInfo.userContact = contactDic;
    [UMTSaveUserInfoHelper saveUserInfoToDisk];
    
    UMTRegisterHelper *helper = [UMTRegisterHelper sharedHelper];
    helper.nickname = nikName;
    helper.password = password;
    helper.gender = [sex isEqualToString:@"男"]?1:0;
    helper.label = label;

    NSArray *keys = [contactDic allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *contact = keys[i];
        if ([contact isEqualToString:@"QQ"]) {
            helper.QQ = contactDic[contact];
            continue;
        }
        if ([contact isEqualToString:@"微信"]) {
            helper.WeChat = contactDic[contact];
            continue;
        }
        if ([contact isEqualToString:@"新浪微博"]) {
            helper.WeiBo = contactDic[contact];
            continue;
        }
        if ([contact isEqualToString:@"Twitter"]) {
            helper.Twitter = contactDic[contact];
            continue;
        }
        if ([contact isEqualToString:@"Facebook"]) {
            helper.Facebook = contactDic[contact];
            continue;
        }
        if ([contact isEqualToString:@"Instagram"]) {
            helper.Instagram = contactDic[contact];
            continue;
        }
    }
}


- (void)certificationButtonClicked{
    if (self.passwordView.password.length < 6) {
        [[UMTProgressHUD sharedHUD]showWithText:@"密码不能少于六位" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (self.passwordView.isEqualPassword == NO) {
        [[UMTProgressHUD sharedHUD]showWithText:@"密码输入不一致" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!self.publicInfoView.nikName||self.publicInfoView.nikName.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!self.publicInfoView.sex||self.publicInfoView.sex.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!self.publicInfoView.label||self.publicInfoView.label.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请完善基本信息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    [self saveInfo];
    UMTcertificationController *vc = [[UMTcertificationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - publickInfoViewDelegate
- (void)sexItemClicked{
    [self.view endEditing:YES];
    [self.sexAlert show];
}

- (void)labelItemClicked{
    [self.view endEditing:YES];
    [self.labelAlert show];
}

#pragma mark - nitification
- (void)tableHeightChanged:(NSNotification *)notification{
    tableHeight = [notification.userInfo[@"height"] floatValue];
    [self refreshUI];
}


- (void)alertView:(UMTAlertView *)alertView didClickAtIndex:(NSInteger)index{
    if (alertView == self.sexAlert) {
        if (index == 0) {
            self.publicInfoView.sex = @"女";
        }else if(index == 1){
            self.publicInfoView.sex = @"男";
        }
    }else if(alertView == self.labelAlert){
        if (index == 0) {
            self.publicInfoView.label = @"吃货";
        }else if (index == 1){
            self.publicInfoView.label = @"运动健儿";
        }else if (index == 2){
            self.publicInfoView.label = @"旅游达人";
        }
    }
    [alertView hide];
}


#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrameAfterShow = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrameAfterShow.size.height;
    UIView *view = [UIResponder currentFirstResponder];
    CGFloat height = view.bottom-self.scrollView.contentOffset.y;
    UIView *aview = view.superview;
    height += aview.top;
    while ((aview = aview.superview)) {
        height += aview.top;
    }
    
    CGFloat keyboardTop = UMTScreenHeight -64 -keyboardHeight;
    [UIView animateWithDuration:0.2f animations:^{
        if (height > keyboardTop) {
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y+height-keyboardTop);
        }
    }];
    
}




- (void)keyboardWillHide:(NSNotification *)notification
{
    
}


- (void)backClicked{
    [self.view endEditing:YES];
}

@end
