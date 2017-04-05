//
//  UMTContactCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTContactCell.h"

@interface UMTContactCell()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;


@end

@implementation UMTContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    _textInput = textInput;
    _textFiled.text = textInput;
}

- (NSString *)inputText{
    return self.textFiled.text;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
