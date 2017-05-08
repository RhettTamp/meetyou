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
        self.layer.cornerRadius = 3;
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.top.mas_offset(5);
            make.bottom.mas_offset(-5);
            make.width.mas_equalTo(2);
        }];
        
        UILabel *tagLabel = [[UILabel alloc]init];
        tagLabel.font = kFont(13);
        self.tagLabel = tagLabel;
        [tagLabel sizeToFit];
        [self addSubview:tagLabel];
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteView.mas_right).offset(3);
            make.right.mas_offset(-3);
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
