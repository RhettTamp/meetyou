//
//  UMTAddActivityNavBar.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTAddActivityNavBar.h"

@interface UMTAddActivityNavBar ()

//@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation UMTAddActivityNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *exitButton = [[UIButton alloc]init];
        [exitButton setBackgroundImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:exitButton];
        [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.and.height.mas_equalTo(20);
            make.centerY.equalTo(self);
        }];
        
        UIButton *rightButton = [[UIButton alloc]init];
        [rightButton setTitle:@"发布" forState:UIControlStateNormal];
        [rightButton setTitleColor:kCommonGreenColor forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-8);
            make.centerY.equalTo(self);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)exitButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(exitButtonClicked)]) {
        [self.delegate exitButtonClicked];
    }
}

- (void)rightButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightButtonClicked)]) {
        [self.delegate rightButtonClicked];
    }
}

@end
