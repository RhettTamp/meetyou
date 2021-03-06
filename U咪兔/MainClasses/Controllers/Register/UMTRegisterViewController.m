//
//  UMTRegisterViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRegisterViewController.h"
#import <BmobMessageSDK/Bmob.h>
#import "UMTBasicInfoController.h"
#import "UMTSaveUserInfoHelper.h"
#import "UMTRegisterHelper.h"

@interface UMTRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
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

- (NSString *)title{
    return @"验证手机号";
}

- (IBAction)getScurityClicked:(UIButton *)sender {
    NSString *phoneNumber = self.phoneNumber.text;
    if (phoneNumber.length != 11) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的手机号码" inView:self.view hideAfterDelay:1];
        return;
    }
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumber andTemplate:@"U咪兔账号注册	" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            
        }
    }];
    self.getSecurityButton.enabled = NO;
    self.getSecurityButton.backgroundColor = kGrayFontColor;
    [self.getSecurityButton setTitle:@"60秒" forState:UIControlStateDisabled];
    self.getSecurityButton.titleLabel.font = kFont(20);
    [self addCurDowntimerWithSecond:60];
}

- (IBAction)registerClicked:(UIButton *)sender {
    //获取手机号、验证码
    NSString *mobilePhoneNumber = self.phoneNumber.text;
    NSString *smsCode = self.security.text;
    
    if (mobilePhoneNumber.length != 11) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的手机号" inView:self.view hideAfterDelay:1];
        return;
    }
    if (smsCode.length != 6) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的验证码" inView:self.view hideAfterDelay:1];
        return;
    }
    
    //验证
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andSMSCode:smsCode resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [[UMTProgressHUD sharedHUD] showWithText:@"验证成功" inView:self.view hideAfterDelay:0.5];
            UMTRegisterHelper *helper = [UMTRegisterHelper sharedHelper];
            helper.phone = mobilePhoneNumber;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UMTBasicInfoController *vc = [[UMTBasicInfoController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            });
            
        } else {
            NSLog(@"%@",error);
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",error] inView:self.view hideAfterDelay:1];
        }
    }];
}

- (void)addCurDowntimerWithSecond:(NSInteger)second{
    __block NSInteger timeSecond = second;
    __weak typeof(self) weakSelf = self;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_main_queue(), ^{
            timeSecond -= 1;
            NSString *buttonTitle = [NSString stringWithFormat:@"%lu秒",timeSecond];
            [self.getSecurityButton setTitle:buttonTitle forState:UIControlStateDisabled];
            if (timeSecond == 0) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.secondTimer invalidate];
                strongSelf.secondTimer = nil;
                strongSelf.getSecurityButton.enabled = YES;
                strongSelf.getSecurityButton.selected = NO;
                [strongSelf.getSecurityButton setTitle:@"60秒" forState:UIControlStateDisabled];
                strongSelf.getSecurityButton.backgroundColor = kCommonGreenColor;
                strongSelf.getSecurityButton.titleLabel.font = kFont(17);
            }
        });
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.secondTimer = timer;
}

- (IBAction)backTaped:(UIControl *)sender {
    [self.view endEditing:YES];
}
@end
