//
//  UMTLoginViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTLoginViewController.h"
#import "UMTRegisterViewController.h"
#import "UMTFindPasswordController.h"
#import "UMTRootViewController.h"
#import "UMTSaveUserInfoHelper.h"
#import "UMTNavigationController.h"
#import "UMTLoginRequest.h"
#import "UMTKeychainTool.h"
#import "UMTCircleView.h"
#import "UMTBaseRequest.h"

@interface UMTLoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *iconView;
@property (strong, nonatomic) UITextField *accountText;
@property (strong, nonatomic) UITextField *passwordText;
@property (strong, nonatomic) UIView *loginView;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *forgotPasswordButton;
@property (nonatomic,strong) UIButton *registerButton;

@end

@implementation UMTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    UIControl *backControl = [[UIControl alloc]initWithFrame:self.view.bounds];
    [backControl addTarget:self action:@selector(backTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backControl];
    
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:@"icon"];
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(UMTScreenHeight*124.0/667);
        make.width.and.height.mas_equalTo(UMTScreenWidth*88.0/375);
        make.centerX.equalTo(self.view);
    }];
    self.iconView = iconView;
    [self addLoginView];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    self.accountText.text = phone;

}

- (void)addLoginView{
    self.loginView = [[UIView alloc]init];
    _loginView.layer.cornerRadius = 4;
    _loginView.layer.borderWidth = 1;
    _loginView.layer.borderColor = kCommonGreenColor.CGColor;
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(97);
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.equalTo(_iconView.mas_bottom).offset(UMTScreenHeight*76.0/667);
    }];
    
    UIImageView *phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TelphoneIcon"]];
    [_loginView addSubview:phoneImage];
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(14);
    }];
    _accountText = [[UITextField alloc]init];
    _accountText.delegate = self;
    _accountText.placeholder = @"请输入手机号";
    _accountText.keyboardType = UIKeyboardTypeNumberPad;
    _accountText.font = kFont(17);
    [_loginView addSubview:_accountText];
    [_accountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImage.mas_right).offset(20);
        make.height.mas_equalTo(24);
        make.top.mas_offset(13);
        make.right.mas_offset(-20);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kCommonGreenColor;
    [_loginView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(6);
        make.right.mas_offset(-6);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(_loginView);
    }];
    UIImageView *passwordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LockIcon"]];
    [_loginView addSubview:passwordImage];
    [passwordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImage.mas_left);
        make.top.equalTo(lineView.mas_bottom).offset(14);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(20);
    }];
    _passwordText = [[UITextField alloc]init];
    _passwordText.delegate = self;
    _passwordText.secureTextEntry = YES;
    [_loginView addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_accountText.mas_left);
        make.right.equalTo(_accountText.mas_right);
        make.centerY.equalTo(passwordImage);
    }];
    
    _loginButton = [[UIButton alloc]init];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginButton setTitleColor:Hex(0xffffff) forState:UIControlStateNormal];
    _loginButton.titleLabel.font = kFont(17);
    _loginButton.layer.cornerRadius = 4;
    _loginButton.backgroundColor = Hex(0x57d980);
    [_loginButton addTarget:self action:@selector(LoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(44);
        make.top.equalTo(_loginView.mas_bottom).offset(20.0/667*UMTScreenHeight);
    }];
    
    _forgotPasswordButton = [[UIButton alloc]init];
    [_forgotPasswordButton setTitleColor:Hex(0x48c277) forState:UIControlStateNormal];
    [_forgotPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgotPasswordButton addTarget:self action:@selector(fogotClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotPasswordButton];
    [_forgotPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_loginButton.mas_bottom).offset(30/667.0*UMTScreenHeight);
    }];
    
    _registerButton = [[UIButton alloc]init];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:Hex(0x4bd56d) forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    _registerButton.layer.cornerRadius = 4;
    _registerButton.layer.borderColor = Hex(0x4bd56d).CGColor;
    _registerButton.layer.borderWidth = 1;
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.top.equalTo(_forgotPasswordButton.mas_bottom).offset(50/667.0*UMTScreenHeight);
        make.centerX.equalTo(self.view);
    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)registerClicked:(UIButton *)sender {
    UMTRegisterViewController *vc = [[UMTRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fogotClicked:(UIButton *)sender {
    UMTFindPasswordController *vc = [[UMTFindPasswordController alloc]init];
    vc.title = @"找回密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)LoginClicked:(UIButton *)sender {
    
    NSString *phoneNumber = self.accountText.text;
    NSString *password = self.passwordText.text;
    __weak typeof(self) weakSelf = self;
    if (phoneNumber.length != 11) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的手机号" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (password.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入密码" inView:self.view hideAfterDelay:0.5];
        return;
    }
    [[UMTProgressHUD sharedHUD] rotateWithText:@"登录中" inView:self.view];
    [UMTLoginRequest getUserTokenWithUserPhone:phoneNumber andPassword:password andCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD] hideAfterDelay:0];
        __strong typeof(self) strongSelf = weakSelf;
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:@"账号或密码错误" inView:strongSelf.view hideAfterDelay:0.5];
        }else{
            NSString *status = response[@"status_code"];
            if ([status isEqualToString:@"2000"]) {
//                UMTUserMgr *sharedMgr = [UMTUserMgr sharedMgr];
                NSString *token = response[@"token"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:phoneNumber forKey:@"phoneNumber"];
                NSDate *date = [NSDate date];
                [defaults synchronize];
                UMTBaseRequest *sharedRequest = [UMTBaseRequest sharedRequest];
                sharedRequest.requestToken = token;
                [UMTKeychainTool save:kTokenKey data:token];
                [UMTKeychainTool save:@"lastDate" data:date];
                UMTRootViewController *vc = [[UMTRootViewController alloc]init];
                [self presentViewController:vc animated:YES completion:nil];
                
            }else{
                [[UMTProgressHUD sharedHUD] showWithText:@"账号或密码错误" inView:self.view hideAfterDelay:0.5];
            }
        }
    }];
    
}

- (void)backTaped:(UIControl *)sender {
    [self.view endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -50.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
}

@end
