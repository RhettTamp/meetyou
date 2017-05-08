//
//  UMTCircleView.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/21.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UMTCircleView : UIView

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat circleWidth;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,strong) UIColor *circleCocor;

- (instancetype)initWithRadius:(CGFloat)radius circleWidth:(CGFloat)width Progress:(CGFloat)progress;

@end
