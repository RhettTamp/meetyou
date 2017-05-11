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
#import "UMTTimeHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
@property (nonatomic,strong) UIView *cuttingLine;

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
    
    UMTCircleView *cir = [[UMTCircleView alloc]initWithRadius:22 circleWidth:16 Progress:0.6];
    cir.circleCocor = Hex(0xffb33a);
    [self addSubview:cir];
    [cir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(15);
        make.width.and.height.mas_equalTo(44);
    }];
    self.timeCircle = cir;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"00:09:48";
    timeLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cir.mas_right).offset(14);
        make.top.mas_offset(29);
//        make.right.mas_offset(10);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *joinLabel = [[UILabel alloc]init];
    joinLabel.textColor = [UIColor orangeColor];
    joinLabel.font = [UIFont boldSystemFontOfSize:24];
    joinLabel.text = @"75";
    [self addSubview:joinLabel];
    [joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_left);
        make.top.equalTo(timeLabel.mas_bottom).offset(2);
    }];
    self.joinedProgressLabel = joinLabel;
    UILabel *percentLabel = [[UILabel alloc]init];
    percentLabel.textColor = [UIColor orangeColor];
    percentLabel.text = @"%";
    percentLabel.font = kFont(10);
    [self addSubview:percentLabel];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(joinLabel.mas_right);
        make.bottom.equalTo(joinLabel.mas_bottom).mas_offset(-2);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(cir.mas_bottom).offset(21);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"拼车回重邮";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(lineView).offset(12);
        make.height.mas_equalTo(28);
    }];
    self.titleLabel = titleLabel;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(titleLabel);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(15);
    }];
    
    UIImageView *headImg = [[UIImageView alloc]init];
    NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
    headImg.image = [UIImage imageNamed:headImgStr];
//    headImg.layer.cornerRadius = 9;
    [self addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.and.height.mas_equalTo(28);
        make.top.equalTo(titleLabel.mas_bottom).offset(2);
    }];
    self.sponsorHead = headImg;
    
    UIView *cuttingLineView = [[UIView alloc]init];
    cuttingLineView.backgroundColor = Hex(0xdedfe0);
    cuttingLineView.layer.cornerRadius = 0.5;
    [self addSubview:cuttingLineView];
    [cuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImg.mas_right).offset(6);
        make.centerY.equalTo(headImg);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(6);
    }];
    self.cuttingLine = cuttingLineView;
    
    NSInteger count = 3;//self.joinedArray.count;
    self.joinedImgs = [NSMutableArray array];
    if (count > 4) {
        for (int i = 0; i < 4; i ++) {
            UIImageView *img = [[UIImageView alloc]init];
            img.layer.cornerRadius = 8;
            NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
            img.image = [UIImage imageNamed:headImgStr];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cuttingLineView.mas_right).offset(8*(i+1)+20*i);
                make.width.and.height.mas_equalTo(20);
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
                make.left.equalTo(cuttingLineView.mas_right).offset(8*(i+1)+20*i);
                make.width.and.height.mas_equalTo(20);
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
    self.contentLabel = contentLabel;
    
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
    siteView.backgroundColor = kLineColor;
    siteView.site = @"重庆邮电大学";
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

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.tagView.tagStr = @"滴滴打车";
////    CGSize size = [NSString getAttributeSizeWithText:@"滴滴打车" fontSize:13];
////    self.tagView.size = CGSizeMake(size.width+12, self.tagView.frame.size.height);
//    
//    self.siteView.site = @"重庆邮电大学";
////    CGSize size2 = [NSString getAttributeSizeWithText:@"重庆邮电大学" fontSize:13];
////    self.siteView.size = CGSizeMake(size2.width+30, self.tagView.frame.size.height);
//    
//    [self layoutIfNeeded];
//}

- (void)reloadData{
    self.titleLabel.text = self.title;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *endDate = [format dateFromString:self.endTime];
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [endDate timeIntervalSinceDate:now];
//    NSDateFormatter *timeFormate = [[NSDateFormatter alloc]init];
//    format.dateFormat = @"HH:mm:ss";
    if (interval > 0) {
        NSString *timeStr = [UMTTimeHelper timeFromTimeInterval:interval];
        self.timeLabel.text = timeStr;
    }
    //设置字间距 NSKernAttributeName:@1.5f
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary *dic = @{NSFontAttributeName:kFont(15), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.content];
    [attributedString addAttributes:dic range:NSMakeRange(0, [self.content length])];
    self.contentLabel.attributedText = attributedString;
    self.timeCircle.progress = self.persenCount;
    self.joinedProgressLabel.text = [NSString stringWithFormat:@"%lu",(NSInteger)self.persenCount*100];
    self.siteView.site = self.site;
//    self.tagView.tagStr = self.tags[0];
    NSString *url = [NSString stringWithFormat:@"https://xbbbbbb.cn/MeetU/%@",self.headUrl];
    [self.sponsorHead sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"m1"]];
    NSInteger count = 3;//self.joinedArray.count;
    self.joinedImgs = [NSMutableArray array];
    if (count > 4) {
        for (int i = 0; i < 4; i ++) {
            UIImageView *img = [[UIImageView alloc]init];
            img.layer.cornerRadius = 8;
            NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
            img.image = [UIImage imageNamed:headImgStr];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cuttingLine.mas_right).offset(8*(i+1)+20*i);
                make.width.and.height.mas_equalTo(20);
                make.bottom.equalTo(self.sponsorHead.mas_bottom);
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
                make.left.equalTo(self.cuttingLine.mas_right).offset(8*(i+1)+20*i);
                make.width.and.height.mas_equalTo(20);
                make.bottom.equalTo(_sponsorHead.mas_bottom);
            }];
            [self.joinedImgs addObject:img];
        }
    }
}


@end
