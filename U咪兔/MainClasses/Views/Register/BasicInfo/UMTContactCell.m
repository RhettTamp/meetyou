//
//  UMTContactCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTContactCell.h"

@interface UMTContactCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation UMTContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (void)setLabelTitle:(NSString *)labelTitle{
    _labelTitle = labelTitle;
    _label.text = labelTitle;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textFiled.placeholder = placeholder;
}

- (void)setTextInput:(NSString *)textInput{
    self.textInput = textInput;
    _textFiled.text = textInput;
}

- (NSString *)textInput{
    return self.textFiled.text;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    self.textFiled.te
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
