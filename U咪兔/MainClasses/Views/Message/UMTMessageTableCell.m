//
//  UMTMessageTableCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/28.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTMessageTableCell.h"

@interface UMTMessageTableCell ()

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
//@property (nonatomic,strong) 

@end

@implementation UMTMessageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUi];
    }
    return self;
}

- (void)initUi{
    _headImage = [[UIImageView alloc]init];
    _headImage.image = [UIImage imageNamed:@"m3"];
    _headImage.layer.cornerRadius = 24;
    _headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(48);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = Hex(0x333333);
    _titleLabel.font = kFont(17);
    _titleLabel.text = @"五一厦门小分队";
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImage.mas_top);
        make.left.equalTo(_headImage.mas_right).offset(16);
        make.width.mas_lessThanOrEqualTo(200.0*UMTScreenWidth/375);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = Hex(0x8e8e8e);
    _contentLabel.font = kFont(13);
    _contentLabel.text = @"明天好像要下雨";
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_headImage.mas_bottom);
        make.left.equalTo(_titleLabel.mas_left);
        make.width.mas_lessThanOrEqualTo(225.0*UMTScreenWidth/375);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = Hex(0x8e8e8e);
    _timeLabel.font = kFont(13);
    _timeLabel.text = @"14:00";
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.top.equalTo(_headImage.mas_top);
    }];
    
    UIView *messageView = [[UIView alloc]init];
    messageView.backgroundColor = Hex(0xff6656);
    messageView.layer.cornerRadius = 8;
    [self.contentView addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.right.mas_offset(-12);
        make.centerY.equalTo(_contentLabel);
    }];
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.font = kFont(11);
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = @"1";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(messageView);
        make.centerY.equalTo(messageView);
    }];
}

@end
