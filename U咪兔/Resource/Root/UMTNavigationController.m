//
//  UMTNavigationController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTNavigationController.h"

@interface UMTNavigationController ()

@end

@implementation UMTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.tintColor = kCommonGreenColor;
//    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    self.navigationBar.barTintColor = [UIColor whiteColor];
}



@end
