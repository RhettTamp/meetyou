//
//  UMTInfoItemView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTInfoItemView.h"

@interface UMTInfoItemView ()<UITextFieldDelegate>


@property (nonatomic,assign) CGRect myRect;

@end

@implementation UMTInfoItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = kDefaultFont;
        self.titleLabel.textColor = Hex(0x030303);
        [self addSubview:self.titleLabel];
        self.inputTextField = [[UITextField alloc]init];
        self.inputTextField.font = kDefaultFont;
        [self addSubview:self.inputTextField];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(self);
        make.width.mas_offset(90);
    }];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.right.mas_offset(-5);
    }];
    
}

-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    _titleLabel.text = leftTitle;
}

- (void)setRightPlaceholder:(NSString *)rightPlaceholder{
    _rightPlaceholder = rightPlaceholder;
    _inputTextField.placeholder = rightPlaceholder;
}

- (NSString *)textInput{
    return self.inputTextField.text;
}

- (void)setTextInput:(NSString *)textInput{
    _inputTextField.text = textInput;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.textInput = textField.text;
}

@end
