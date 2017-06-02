//
//  UMTFindfTableViewCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/23.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTFindfTableViewCell.h"
#import "UMTFindCellImageVIew.h"
#import "UMTFindCellModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UMTFindfTableViewCell ()

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *monthLabel;
@property (nonatomic,strong) UILabel *dayLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UMTFindCellImageVIew *imagesView;
@property (nonatomic,strong) UILabel *activityLabel;
@property (nonatomic,strong) UIButton *praiseButton;
@property (nonatomic,strong) UIButton *commentButton;
@property (nonatomic,strong) UILabel *praiseLabel;
@property (nonatomic,strong) UILabel *commentLabel;

@end

@implementation UMTFindfTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self initUI];
//}

- (void)initUI{
    _headImage = [[UIImageView alloc]init];
    _headImage.image = [UIImage imageNamed:@"m1"];
    [self.contentView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.width.and.height.mas_equalTo(42.0/375*UMTScreenWidth);
        make.top.mas_offset(12);
    }];
    _nameLabel = [UILabel new];
    _nameLabel.text = @"很酷的昵称";
    _nameLabel.font = kFont(11);
    _nameLabel.textColor = Hex(0x666666);
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(24);
        make.top.mas_offset(12);
    }];
    _titleLabel = [UILabel new];
    _titleLabel.textColor = Hex(0x262626);
    _titleLabel.text = @"厦门，一个容易触动人心的地方";
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(2);
        make.right.mas_offset(-30);
    }];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = kFont(15);
    _contentLabel.textColor = Hex(0x666666);
    _contentLabel.text = @"本次厦门之行可以说是一场蓄谋已久的旅行，几个月就和胖州商量着：要不要再报个名试试，一起跑个马拉松？（去年的深";
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.right.mas_offset(-13);
    }];
    
    UIButton *moreButton = [[UIButton alloc]init];
    [moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [moreButton setTitleColor:Hex(0x3eb964) forState:UIControlStateNormal];
    [moreButton setTitle:@"收起" forState:UIControlStateSelected];
    [moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_contentLabel.mas_bottom).offset(8);
    }];
    
    _imagesView = [[UMTFindCellImageVIew alloc]init];
    _imagesView.images = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
    [self.contentView addSubview:_imagesView];
    [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreButton.mas_bottom).offset(10);
        make.left.equalTo(_nameLabel.mas_left);
    }];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = Hex(0xf0f0f0);
    backView.layer.cornerRadius = 4;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_imagesView.mas_bottom).offset(20);
//        make.bottom.mas_offset(-20);
        make.height.mas_equalTo(22);
    }];
    
    _activityLabel = [[UILabel alloc]init];
    _activityLabel.layer.cornerRadius = 4;
    _activityLabel.textColor = Hex(0x666666);
    _activityLabel.font = kFont(11);
    _activityLabel.text = @"五一厦门三日游";
    [backView addSubview:_activityLabel];
    [_activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(6);
        make.right.mas_offset(-6);
        make.top.mas_offset(3);
        make.bottom.mas_offset(-3);
    }];
    
    _praiseButton = [UIButton new];
    [_praiseButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    [self.contentView addSubview:_praiseButton];
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(backView.mas_bottom).offset(15);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(17);
    }];
    _praiseLabel = [UILabel new];
    _praiseLabel.font = kFont(13);
    _praiseLabel.textColor = Hex(0x8e8e8e);
    _praiseLabel.text = @"66";
    [self.contentView addSubview:_praiseLabel];
    [_praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_praiseButton.mas_right).offset(10);
        make.centerY.equalTo(_praiseButton);
    }];
    
    _commentButton = [UIButton new];
    [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [self.contentView addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_praiseLabel.mas_right).offset(34);
        make.centerY.equalTo(_praiseButton);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(16);
    }];
    _commentLabel = [UILabel new];
    _commentLabel.textColor = Hex(0x8e8e8e);
    _commentLabel.font = kFont(13);
    _commentLabel.text = @"99";
    [self.contentView addSubview:_commentLabel];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentButton.mas_right).offset(6);
        make.centerY.equalTo(_commentButton);
    }];
}

- (void)moreButtonClicked{
    
}

- (void)setModel:(UMTFindCellModel *)model{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl] placeholderImage:[UIImage imageNamed:@"m1"]];
    self.nameLabel.text = model.name;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.imagesView.images = model.contentImageArray;
}

@end
