//
//  UMTTagCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/12.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTTagCell.h"

@interface UMTTagCell ()

@property (nonatomic,strong) UILabel *tagLabel;

@end

@implementation UMTTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *tagColors = @[kTagRedColor,kTagBlueColor,kTagGreenColor,kTagOrangeColor,kTagPurpleColor];
        self.layer.cornerRadius = 4;
        self.backgroundColor = [UIColor whiteColor];
        UIView *circleView = [[UIView alloc]init];
        circleView.layer.cornerRadius = 11;
        circleView.backgroundColor = tagColors[random()%5];
        [self addSubview:circleView];
        [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.width.and.height.mas_equalTo(22);
            make.centerY.equalTo(self);
        }];
        
        UILabel *tagLabel = [[UILabel alloc]init];
        [tagLabel adjustsFontSizeToFitWidth];
        [self addSubview:tagLabel];
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(circleView.mas_right).offset(14);
            make.right.mas_offset(-8);
            make.centerY.equalTo(self);
        }];
        self.tagLabel = tagLabel;
    }
    return self;
}

- (void)setTagName:(NSString *)tagName{
    _tagName = tagName;
    self.tagLabel.text = tagName;
    [self.tagLabel adjustsFontSizeToFitWidth];
}

@end
