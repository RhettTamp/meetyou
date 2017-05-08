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
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation UMTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    self.accountText.text = phone;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)registerClicked:(UIButton *)sender {
    UMTRegisterViewController *vc = [[UMTRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)fogotClicked:(UIButton *)sender {
    UMTFindPasswordController *vc = [[UMTFindPasswordController alloc]init];
    vc.title = @"找回密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)LoginClicked:(UIButton *)sender {
    
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

- (IBAction)backTaped:(UIControl *)sender {
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
