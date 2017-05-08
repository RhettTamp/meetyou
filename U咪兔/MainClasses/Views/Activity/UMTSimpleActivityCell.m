//
//  UMTSimpleActivityCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSimpleActivityCell.h"
#import "UMTCircleView.h"
#import "UMTSiteView.h"
#import "UMTTagView.h"
#import "NSString+Extension.h"

@interface UMTSimpleActivityCell ()

@property (nonatomic,strong) UMTCircleView *timeCircle;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *joinedProgressLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *sponsorHead;
@property (nonatomic,strong) NSArray *joinedArray;
@property (nonatomic,strong) NSMutableArray *joinedImgs;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UMTSiteView *siteView;
//@property (nonatomic,strong) NSArray *tags;
//@property (nonatomic,strong) NSMutableArray *tagViews;
@property (nonatomic,strong) UMTTagView *tagView;

@end

@implementation UMTSimpleActivityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    [self addborder];
    UMTCircleView *cir = [[UMTCircleView alloc]initWithRadius:20 circleWidth:10 Progress:0.6];
    cir.circleCocor = [UIColor orangeColor];
    [self addSubview:cir];
    [cir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(15);
        make.width.and.height.mas_equalTo(40);
    }];
    self.timeCircle = cir;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"00:09:48";
    timeLabel.font = kFont(15);
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cir.mas_right).offset(8);
        make.top.equalTo(cir.mas_top).offset(5);
        make.right.mas_offset(10);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *joinLabel = [[UILabel alloc]init];
    joinLabel.textColor = [UIColor orangeColor];
    joinLabel.font = kFont(17);
    joinLabel.text = @"75";
    [self addSubview:joinLabel];
    [joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_left);
        make.top.equalTo(timeLabel.mas_bottom).offset(3);
    }];
    self.joinedProgressLabel = joinLabel;
    UILabel *percentLabel = [[UILabel alloc]init];
    percentLabel.textColor = [UIColor orangeColor];
    percentLabel.text = @"%";
    percentLabel.font = kFont(13);
    [self addSubview:percentLabel];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(joinLabel.mas_right);
        make.bottom.equalTo(joinLabel.mas_bottom);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.top.equalTo(cir.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = kFont(19);
    titleLabel.text = @"拼车回重邮";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.equalTo(lineView).offset(5);
        make.height.mas_equalTo(20);
    }];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.centerY.equalTo(titleLabel);
        make.width.and.right.mas_equalTo(18);
    }];
    
    UIImageView *headImg = [[UIImageView alloc]init];
    NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
    headImg.image = [UIImage imageNamed:headImgStr];
    headImg.layer.cornerRadius = 9;
    [self addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.width.and.height.mas_equalTo(18);
        make.top.equalTo(titleLabel.mas_bottom).offset(3);
    }];
    self.sponsorHead = headImg;
    
    UIView *cuttingLineView = [[UIView alloc]init];
    cuttingLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:cuttingLineView];
    [cuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImg.mas_right).offset(3);
        make.centerY.equalTo(headImg);
        make.width.mas_equalTo(1);
    }];
    
    NSInteger count = self.joinedArray.count;
    self.joinedImgs = [NSMutableArray array];
    if (count > 4) {
        for (int i = 0; i < 4; i ++) {
            UIImageView *img = [[UIImageView alloc]init];
            img.layer.cornerRadius = 8;
            NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
            img.image = [UIImage imageNamed:headImgStr];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cuttingLineView.mas_right).offset(5*i+16*i);
                make.width.and.height.mas_equalTo(16);
                make.bottom.equalTo(headImg.mas_bottom);
            }];
            [self.joinedImgs addObject:img];
        }
    }else if (count > 0){
        for (int i = 0; i < count; i ++) {
            UIImageView *img = [[UIImageView alloc]init];
            img.layer.cornerRadius = 8;
            NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
            img.image = [UIImage imageNamed:headImgStr];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cuttingLineView.mas_right).offset(5*i+16*i);
                make.width.and.height.mas_equalTo(16);
                make.bottom.equalTo(headImg.mas_bottom);
            }];
            [self.joinedImgs addObject:img];
        }
    }
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = kFont(15);
    contentLabel.text = @"一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊";
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImg.mas_left);
        make.top.equalTo(headImg.mas_bottom).offset(3);
        make.right.mas_offset(-5);
        make.height.mas_equalTo(20*3);
    }];
    
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
    siteView.backgroundColor = kLineColor;
    [self addSubview:siteView];
    [siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.equalTo(contentLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(120);
    }];
    self.siteView = siteView;
    
    UILabel *hintLabel = [[UILabel alloc]init];
    hintLabel.text = @"距你的位置";
    hintLabel.font = kFont(13);
    hintLabel.textColor = kLineColor;
    [self addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.equalTo(siteView.mas_bottom).offset(2);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.textColor = kCommonGreenColor;
    distanceLabel.text = @"<100m";
    distanceLabel.font = kFont(13);
    [self addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintLabel.mas_right).offset(5);
        make.top.equalTo(hintLabel.mas_top);
        make.height.equalTo(hintLabel);
    }];
    
    UMTTagView *tagView = [[UMTTagView alloc]init];
    tagView.backgroundColor = kCommonGreenColor;
    [self addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.equalTo(hintLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(100);
    }];
    self.tagView = tagView;
}

- (void)addborder{
    UIView *borderView = [[UIView alloc]init];
    borderView.layer.borderWidth = 1;
    borderView.layer.borderColor = [kLineColor CGColor];
    borderView.layer.cornerRadius = 4;
    [self addSubview:borderView];
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tagView.tagStr = @"滴滴打车";
//    CGSize size = [NSString getAttributeSizeWithText:@"滴滴打车" fontSize:13];
//    self.tagView.size = CGSizeMake(size.width+12, self.tagView.frame.size.height);
    
    self.siteView.site = @"重庆邮电大学";
//    CGSize size2 = [NSString getAttributeSizeWithText:@"重庆邮电大学" fontSize:13];
//    self.siteView.size = CGSizeMake(size2.width+30, self.tagView.frame.size.height);
    
    [self layoutIfNeeded];
}

@end
