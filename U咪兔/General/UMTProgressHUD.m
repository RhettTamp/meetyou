//
//  UMTProgressHUD.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTProgressHUD.h"

@interface UMTProgressHUD ()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation UMTProgressHUD

+ (instancetype)sharedHUD
{
    static UMTProgressHUD *progressHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progressHUD = [[UMTProgressHUD alloc] init];
    });
    return progressHUD;
}

- (void)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay
{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.label.text = text;
    self.hud.mode = MBProgressHUDModeText;
    [self.hud hideAnimated:YES afterDelay:delay];
}

- (void)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay WithCompletionBlock:(void(^)())completionBlock
{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.label.text = text;
    self.hud.mode = MBProgressHUDModeText;
//    [self.hud showAnimated:YES whileExecutingBlock:^{
//        [NSThread sleepForTimeInterval:delay];
//    } completionBlock:^{
//        if (completionBlock)
//            completionBlock();
//    }];
    [self.hud showAnimated:YES];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.hud hideAnimated:YES];
        if (completionBlock) {
            completionBlock();
        }
    });
}

- (void)rotateWithText:(NSString *)text inView:(UIView *)view
{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.label.text = text;
    self.hud.mode = MBProgressHUDModeIndeterminate;
}

- (void)hideAfterDelay:(NSTimeInterval)delay
{
    [self.hud hideAnimated:YES afterDelay:delay];
}

@end
