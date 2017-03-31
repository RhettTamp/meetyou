//
//  UMTRegisterViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRegisterViewController.h"
//#import <BmobMessageSDK/Bmob.h>
#import "UMTRootViewController.h"

@interface UMTRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *security;

@end

@implementation UMTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
//- (IBAction)getScurityClicked:(UIButton *)sender {
//    NSString *phoneNumber = self.phoneNumber.text;
//    if (phoneNumber.length != 11) {
//        [[UMTProgressHUD sharedHUD] showWithText:@"请输入正确的手机号码" inView:self.view hideAfterDelay:1];
//        return;
//    }
////    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:(NSString *) andTemplate:(NSString *) resultBlock:^(int number, NSError *error) {
////    code
////}]
//    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumber andTemplate:@"test" resultBlock:^(int number, NSError *error) {
//        
//    }];
//}
//
//- (IBAction)registerClicked:(UIButton *)sender {
//    //获取手机号、验证码
//    NSString *mobilePhoneNumber = self.phoneNumber.text;
//    NSString *smsCode = self.security.text;
//    
//    //验证
//    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:mobilePhoneNumber andSMSCode:smsCode resultBlock:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            [[UMTProgressHUD sharedHUD] showWithText:@"注册成功" inView:self.view hideAfterDelay:1];
//            UMTRootViewController *rootVC = [[UMTRootViewController alloc]init];
//            self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//            [self presentViewController:rootVC animated:YES completion:nil];
//        } else {
//            NSLog(@"%@",error);
//            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",error] inView:self.view hideAfterDelay:1];
//        }
//    }];
//}

@end
