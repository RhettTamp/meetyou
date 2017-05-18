//
//  UMTSiteViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSiteViewController.h"

@interface UMTSiteViewController ()

@property (nonatomic,strong) UITextField *siteText;

@end

@implementation UMTSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 80, 40)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text];
    self.siteText = text;
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 150, 50, 40)];
    commitButton.backgroundColor = [UIColor redColor];
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
}

- (void)commitButtonClicked{
    self.block(self.siteText.text);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
