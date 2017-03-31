//
//  UMTProgressHUD.h
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface UMTProgressHUD : MBProgressHUD

+ (instancetype)sharedHUD;

- (void)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

- (void)rotateWithText:(NSString *)text inView:(UIView *)view;

- (void)hideAfterDelay:(NSTimeInterval)delay;

- (void)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay WithCompletionBlock:(void(^)())completionBlock;

@end
