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

@interface UMTLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation UMTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)registerClicked:(UIButton *)sender {
    UMTRegisterViewController *vc = [[UMTRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)fogotClicked:(UIButton *)sender {
    UMTFindPasswordController *vc = [[UMTFindPasswordController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)LoginClicked:(UIButton *)sender {
    
    NSString *phoneNumber = self.accountText.text;
    NSString *password = self.passwordText.text;
    UMTUserMgr *sharedMgr = [UMTUserMgr sharedMgr];
    [sharedMgr removeAllUserInfomation];
    sharedMgr.userInfo.userPhoneNumber = phoneNumber;
    [UMTSaveUserInfoHelper saveUserInfoToDisk];
    UMTRootViewController *vc = [[UMTRootViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)backTaped:(UIControl *)sender {
    [self.view endEditing:YES];
}

@end
