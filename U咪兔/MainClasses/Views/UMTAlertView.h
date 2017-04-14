//
//  UMTAlertView.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UMTAlertView;

typedef NS_ENUM(NSInteger,UMTAlertViewStyle){
    UMTAlertViewStyleComme, //默认
    UMTAlertViewStyleDelete,
};

@protocol UMTAlertViewDelegate <NSObject>

@required
- (void)alertView:(UMTAlertView *)alertView didClickAtIndex:(NSInteger)index;

@optional
- (void)cancelButtonDidClick;

@end

@interface UMTAlertView : UIView

- (instancetype)initWithFuncArray:(NSArray *)funcArray;

@property (nonatomic, assign) UMTAlertViewStyle alertStyle;
@property (nonatomic, weak) id <UMTAlertViewDelegate>delegate;

- (void)show;

- (void)hide;

@end
