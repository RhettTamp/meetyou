//
//  UMTActivityTypeView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/14.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTActivityTypeView.h"

@interface UMTActivityTypeView ()

@property (nonatomic,strong) UIButton *conerButton;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation UMTActivityTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *conerButton = [[UIButton alloc]init];
        [conerButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:conerButton];
        [conerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(55);
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self);
        }];
        self.conerButton = conerButton;
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = Hex(0x8e8e8e);
        nameLabel.font = kFont(13);
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(conerButton.mas_bottom).offset(8);
            make.centerX.equalTo(self);
        }];
        self.nameLabel = nameLabel;
    }
    return self;
}

- (void)setButtonImage:(UIImage *)buttonImage{
    _buttonImage = buttonImage;
    [self.conerButton setImage:buttonImage forState:UIControlStateNormal];
}

- (void)setName:(NSString *)name{
    _name = name;
    self.nameLabel.text = name;
}

- (void)buttonClicked:(UIButton *)button{
    self.block(button);
}

@end
