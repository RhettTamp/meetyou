//
//  UMTMeItemView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/19.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTMeItemView.h"

@interface UMTMeItemView ()

@property (nonatomic,strong) UIButton *countButton;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation UMTMeItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _countButton = [[UIButton alloc]init];
        [_countButton setTitleColor:kCommonGreenColor forState:UIControlStateNormal];
        _countButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_countButton];
        [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_offset(10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(21);
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(11);
        _nameLabel.textColor = Hex(0x8e8e8e);
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_countButton.mas_bottom).offset(2);
        }];
    }
    return self;
}

- (void)setNumber:(NSInteger)number{
    [self.countButton setTitle:[NSString stringWithFormat:@"%lu",number] forState:UIControlStateNormal];
    _number = number;
}

- (void)setLabelText:(NSString *)labelText{
    self.nameLabel.text = labelText;
    _labelText = labelText;
}

@end
