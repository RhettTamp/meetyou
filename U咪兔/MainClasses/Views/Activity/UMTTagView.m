//
//  UMTTagView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTTagView.h"

@interface UMTTagView ()

@property (nonatomic,strong) UILabel *tagLabel;

@end

@implementation UMTTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         NSArray *tagColors = @[kTagRedColor,kTagBlueColor,kTagGreenColor,kTagOrangeColor,kTagPurpleColor];
        self.backgroundColor = tagColors[random()%5];
        self.layer.cornerRadius = 4;
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.layer.cornerRadius = 1.5;
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(6);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(2);
            make.height.mas_equalTo(10);
        }];
        
        UILabel *tagLabel = [[UILabel alloc]init];
        tagLabel.font = kFont(11);
        tagLabel.textColor = [UIColor whiteColor];
        self.tagLabel = tagLabel;
        [tagLabel sizeToFit];
        [self addSubview:tagLabel];
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteView.mas_right).offset(6);
            make.right.mas_offset(-6);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
////    [self.tagLabel sizeToFit];
//    [self layoutIfNeeded];
//}

- (void)setTagStr:(NSString *)tagStr{
    _tagStr = tagStr;
    self.tagLabel.text = tagStr;
}



@end
