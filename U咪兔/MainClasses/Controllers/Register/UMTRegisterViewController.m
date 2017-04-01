//
//  UMTRegisterViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRegisterViewController.h"
#import <BmobMessageSDK/Bmob.h>
#import "UMTRealInfoViewController.h"
#import "UMTRealInfoViewController.h"
#import "UMTSaveUserInfoHelper.h"

@interface UMTRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *security;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityButton;
@property (nonatomic,strong) NSTimer *secondTimer;

@end

@implementation UMTRegisterViewController

NSInteger timeOut;

- (void)dealloc{
    if (self.secondTimer) {
        [self.secondTimer invalidate];
        self.secondTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)getScurityClicked:(UIButton *)sender {
    NSString *phoneNumber = self.phoneNumber.text;
    NSString *password = self.password.text;
    if (phoneNumber.length != 11) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的手机号码" inView:self.view hideAfterDelay:1];
        return;
    }
    if (password.length < 8) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请至少输入8位密码" inView:self.view hideAfterDelay:1];
        return;
    }
//    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumber andTemplate:@"U咪兔账号注册	" resultBlock:^(int number, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            
//        }
//    }];
    self.getSecurityButton.enabled = NO;
    self.getSecurityButton.backgroundColor = [UIColor lightGrayColor];
    [self addCurDowntimerWithSecond:60];
}

- (IBAction)registerClicked:(UIButton *)sender {
    //获取手机号、验证码
    
    
    NSString *mobilePhoneNumber = self.phoneNumber.text;
    NSString *smsCode = self.security.text;
    NSString *password = self.password.text;
    
    if (mobilePhoneNumber.length != 11) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的手机号" inView:self.view hideAfterDelay:1];
        return;
    }
    if (smsCode.length != 4) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的验证码" inView:self.view hideAfterDelay:1];
        return;
    }
    if (password.length < 8) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请至少输入8位密码" inView:self.view hideAfterDelay:1];
        return;
    }
    UMTUserMgr *sharedMgr = [UMTUserMgr sharedMgr];
    sharedMgr.userInfo.userPhoneNumber = mobilePhoneNumber;
    sharedMgr.userInfo.userPassword = password;
    [UMTSaveUserInfoHelper saveUserInfoToDisk];
    
    [[UMTProgressHUD sharedHUD] showWithText:@"注册成功" inView:self.view hideAfterDelay:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UMTRealInfoViewController *vc = [[UMTRealInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    });
    
    //验证
//    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andSMSCode:smsCode resultBlock:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            [[UMTProgressHUD sharedHUD] showWithText:@"注册成功" inView:self.view hideAfterDelay:1];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                UMTRootViewController *rootVC = [[UMTRootViewController alloc]init];
//                self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//                [self presentViewController:rootVC animated:YES completion:nil];
//            });
//           
//        } else {
//            NSLog(@"%@",error);
//            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",error] inView:self.view hideAfterDelay:1];
//        }
//    }];
}

- (void)addCurDowntimerWithSecond:(NSInteger)second{
    __block NSInteger timeSecond = second;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *buttonTitle = [NSString stringWithFormat:@"%lu",timeSecond];
            [self.getSecurityButton setTitle:buttonTitle forState:UIControlStateDisabled];
            timeSecond -= 1;
            if (timeSecond == 0) {
                [self.secondTimer invalidate];
                self.secondTimer = nil;
                self.getSecurityButton.enabled = YES;
                self.getSecurityButton.selected = NO;
                [self.getSecurityButton setTitle:@"" forState:UIControlStateDisabled];
                self.getSecurityButton.backgroundColor = [UIColor whiteColor];
            }
        });
        
    }];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60];
//    NSTimer *timer = [[NSTimer alloc]initWithFireDate:date interval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSString *buttonTitle = [NSString stringWithFormat:@"%lu",second];
//        self.getSecurityButton.titleLabel.text = buttonTitle;
//        timeSecond -= 1;
//    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.secondTimer = timer;
}

- (IBAction)backTaped:(UIControl *)sender {
    [self.view endEditing:YES];
}
@end
