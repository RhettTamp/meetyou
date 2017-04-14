//
//  UMTFindPasswordController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTFindPasswordController.h"
#import "UMTResetPasswordController.h"

@interface UMTFindPasswordController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (weak, nonatomic) IBOutlet UITextField *securityText;

@end

@implementation UMTFindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backTaped:(UIControl *)sender {
    [self.view endEditing:YES];
}

- (IBAction)getSecurityClicked:(UIButton *)sender {
}

- (IBAction)nextStationClicked:(UIButton *)sender {
    UMTResetPasswordController *resetVc = [[UMTResetPasswordController alloc]init];
    [self.navigationController pushViewController:resetVc animated:YES];
}


@end
