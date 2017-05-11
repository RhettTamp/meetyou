//
//  UMTActivitTopView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTActivitTopView.h"

@interface UMTActivitTopView ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation UMTActivitTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel adjustsFontSizeToFitWidth];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = kFont(20);
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80);
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_equalTo(30);
        }];
        self.titleLabel = titleLabel;
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(200);
            make.top.equalTo(titleLabel.mas_bottom).offset(10);
        }];
        [timeLabel adjustsFontSizeToFitWidth];
        self.timeLabel = timeLabel;
        [self addWhiteView];
    }
    return self;
}

- (void)addWhiteView{
    CGFloat width = UMTScreenWidth/25.0;
    for (int i = 0; i < 12; i++) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.mas_offset(width*(i*2+1));
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(width);
        }];
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTime:(NSString *)time{
    _time = time;
    self.timeLabel.text = time;
    [self.timeLabel adjustsFontSizeToFitWidth];
    [self layoutIfNeeded];
}

@end
