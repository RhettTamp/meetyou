//
//  UMTDetailActivityCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTDetailActivityCell.h"
#import "UMTCircleView.h"
#import "UMTTagView.h"
#import "UMTSiteView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UMTDetailActivityCell ()

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UMTSiteView *siteView;
@property (nonatomic,strong) UMTCircleView *personCircle;
@property (nonatomic,strong) UMTCircleView *timeCircle;
@property (nonatomic,strong) UILabel *personCountLabel;
@property (nonatomic,strong) UILabel *timeCountLabel;
@property (nonatomic,strong) NSMutableArray *tagsViewArray;
@property (nonatomic,strong) NSArray *joinedArray;
@property (nonatomic,strong) NSMutableArray *joinedImgArray;

@end

@implementation UMTDetailActivityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        self.tags = [NSArray array];
    }
    return self;
}

- (void)initSubView{
    UIImageView *img = [[UIImageView alloc]init];
    img.layer.cornerRadius = 23;
    img.image = [UIImage imageNamed:@"m1"];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.width.and.height.mas_equalTo(40);
    }];
    self.headImage = img;
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor clearColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClicked)];
//    [titleView addGestureRecognizer:tap];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(img.mas_right).offset(10);
        make.top.mas_offset(5);
        make.height.mas_equalTo(28);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"五一厦门三日游";
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView);
        make.right.mas_offset(-80);
        make.centerY.equalTo(titleView);
    }];
    self.titleLabel = titleLabel;
    
    UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [titleView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-23);
        make.centerY.equalTo(titleLabel);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = kFont(11);
    timeLabel.textColor = Hex(0x8E8E8E);
    timeLabel.text = @"2017年05月01日-2017年05月03日";
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(200);
        make.top.equalTo(titleView.mas_bottom);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = kFont(15);
    NSString *content = @"一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊";

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:kFont(15), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [attributedString addAttributes:dic range:NSMakeRange(0, [content length])];
    contentLabel.attributedText = attributedString;
    
    contentLabel.textColor = Hex(0x333333);
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_equalTo(UMTScreenWidth/2-5);
        make.height.mas_equalTo(96);
        make.top.equalTo(timeLabel.mas_bottom).offset(10);
    }];
    self.contentLabel = contentLabel;
    
    
    
    UMTCircleView *personCirclr = [[UMTCircleView alloc]initWithRadius:42 circleWidth:16 Progress:0.3];
    personCirclr.circleCocor = kCommonGreenColor;
    [self addSubview:personCirclr];
    [personCirclr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel.mas_right).offset(14);
        make.width.and.height.mas_equalTo(84);
        make.top.equalTo(timeLabel.mas_bottom).offset(22);
    }];
    self.personCircle = personCirclr;
    
    UMTCircleView *timeCircle = [[UMTCircleView alloc]initWithRadius:22 circleWidth:16 Progress:0.6];
    timeCircle.circleCocor = Hex(0xFFB33A);
    [self addSubview:timeCircle];
    [timeCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCirclr.mas_left).offset(20);
        make.width.and.height.mas_equalTo(44);
        make.top.equalTo(personCirclr.mas_top).offset(20);
    }];
    self.timeCircle = timeCircle;
    
    UILabel *personCountLabel = [[UILabel alloc]init];
    personCountLabel.font = [UIFont boldSystemFontOfSize:24];
    personCountLabel.textColor = kCommonGreenColor;
    personCountLabel.text = @"64";
    [self addSubview:personCountLabel];
    [personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCirclr.mas_right).offset(15);
        make.top.equalTo(contentLabel.mas_top).offset(39);
//        make.right.mas_offset(-50);
    }];
    self.personCountLabel = personCountLabel;
    UILabel *percentLabel1 = [[UILabel alloc]init];
    percentLabel1.font = kFont(10);
    percentLabel1.textColor = kCommonGreenColor;
    percentLabel1.text = @"%";
    [self addSubview:percentLabel1];
    [percentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCountLabel.mas_right);
        make.bottom.equalTo(personCountLabel.mas_bottom).offset(-2);
//        make.right.mas_offset(14);
    }];
    
    UILabel *timeCountLabel = [[UILabel alloc]init];
    timeCountLabel.font = [UIFont boldSystemFontOfSize:24];
    timeCountLabel.textColor = [UIColor orangeColor];
    timeCountLabel.text = @"53";
    [self addSubview:timeCountLabel];
    [timeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personCountLabel.mas_bottom).offset(8);
        make.left.equalTo(personCountLabel.mas_left);
    }];
    self.timeCountLabel = timeCountLabel;
    UILabel *percentLabel2 = [[UILabel alloc]init];
    percentLabel2.font = kFont(10);
    percentLabel2.textColor = [UIColor orangeColor];
    percentLabel2.text = @"%";
    [self addSubview:percentLabel2];
    [percentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeCountLabel.mas_right);
        make.bottom.equalTo(timeCountLabel.mas_bottom).offset(-2);
    }];
    
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
    siteView.backgroundColor = Hex(0xF3f3f3);
    siteView.layer.cornerRadius = 3;
    [self addSubview:siteView];
    [siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel.mas_left);
        make.height.mas_equalTo(22);
        make.top.equalTo(contentLabel.mas_bottom).offset(8);
    }];
    self.siteView = siteView;
    
    //创建标签view
    if (self.tags && self.tags.count > 0) {
        self.tagsViewArray = [NSMutableArray array];
        for (int i = 0; i < self.tags.count; i++) {
            UMTTagView *tagView = [[UMTTagView alloc]init];
            tagView.tagStr = self.tags[i];
            [self.tagsViewArray addObject:tagView];
            [self addSubview:tagView];
            if (i == 0) {
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.bottom.mas_offset(-12);
                    make.height.mas_equalTo(22);
                }];
            }else{
                UMTTagView *v = self.tagsViewArray[i-1];
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(v.mas_right).offset(10);
                    make.bottom.mas_offset(-12);
                    make.height.mas_equalTo(22);
                }];
            }
            
        }
    }
    
    //创建参与者view
    
    
    //--------------------------------------------------------
//    self.tagsViewArray = [NSMutableArray array];
//    for (int i = 0; i < 2; i++) {
//        UMTTagView *tagView = [[UMTTagView alloc]init];
//        tagView.tagStr = @"社团活动";
//        tagView.backgroundColor = kCommonGreenColor;
//        [self.tagsViewArray addObject:tagView];
//        [self addSubview:tagView];
//        if (i == 0) {
//            [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(10);
//                make.bottom.mas_offset(-12);
//                make.height.mas_equalTo(22);
//            }];
//        }else{
//            UMTTagView *v = self.tagsViewArray[i-1];
//            [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(v.mas_right).offset(10);
//                make.bottom.mas_offset(-12);
//                make.height.mas_equalTo(22);
//            }];
//        }
//    }
//    
//    for (int i = 0; i < 5; i++) {
//        for (int i = 0; i < 5; i++) {
//            UIImageView *img = [[UIImageView alloc] init];
//            img.layer.cornerRadius = 10;
//            NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
//            img.image = [UIImage imageNamed:headImgStr];
//            [self.joinedImgArray addObject:img];
//            [self addSubview:img];
//            [img mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_offset(-10*(i+1)-i*26);
//                make.width.and.height.mas_equalTo(26);
//                make.bottom.mas_offset(-12);
//            }];
//        }
//    }
    
    
}

- (void)resetData{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *startDate = [format dateFromString:self.startTime];
    NSDate *endDate = [format dateFromString:self.endTime];
    NSDate *applyStartTime = [format dateFromString:self.applyStartTime];
    NSDate *applyEndTime = [format dateFromString:self.applyEndTime];
    NSDate *now = [NSDate date];
    CGFloat timePercent = [now timeIntervalSinceDate:applyStartTime]/[applyEndTime timeIntervalSinceDate:applyStartTime];
    self.timeCircle.progress = timePercent;
    self.timeCountLabel.text = [NSString stringWithFormat:@"%d",(int)timePercent*100];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://xbbbbbb.cn/MeetU/%@",self.headStr]] placeholderImage:[UIImage imageNamed:@"m1"]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = @"yyyy年MM月dd日";
    NSString *starStr = [dateFormat stringFromDate:startDate];
    NSString *endStr = [dateFormat stringFromDate:endDate];
    NSString *timeStr = [NSString stringWithFormat:@"%@-%@",starStr,endStr];
    self.timeLabel.text = timeStr;
    self.personCircle.progress = self.peoplePercent;
    self.personCountLabel.text = [NSString stringWithFormat:@"%d",(int)self.peoplePercent*100];
    self.titleLabel.text = self.title;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:kFont(15), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.content];
    [attributedString addAttributes:dic range:NSMakeRange(0, [self.content length])];
    self.contentLabel.attributedText = attributedString;
    self.siteView.site = self.site;
    self.tagsViewArray = [NSMutableArray array];
    NSInteger count = self.tags.count;
    if (count > 2) {
        for (int i = 0; i < 2; i++) {
            UMTTagView *tagView = [[UMTTagView alloc]init];
            tagView.tagStr = self.tags[i];
            tagView.backgroundColor = kCommonGreenColor;
            [self.tagsViewArray addObject:tagView];
            [self addSubview:tagView];
            if (i == 0) {
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.bottom.mas_offset(-12);
                    make.height.mas_equalTo(22);
                }];
            }else{
                UMTTagView *v = self.tagsViewArray[i-1];
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(v.mas_right).offset(10);
                    make.bottom.mas_offset(-12);
                    make.height.mas_equalTo(22);
                }];
            }
        }
    }else{
        for (int i = 0; i < count; i++) {
            UMTTagView *tagView = [[UMTTagView alloc]init];
            tagView.tagStr = self.tags[i];
            tagView.backgroundColor = kCommonGreenColor;
            [self.tagsViewArray addObject:tagView];
            [self addSubview:tagView];
            if (i == 0) {
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.bottom.mas_offset(-12);
                    make.height.mas_equalTo(22);
                }];
            }else{
                UMTTagView *v = self.tagsViewArray[i-1];
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(v.mas_right).offset(10);
                    make.bottom.mas_offset(-12);
                    make.height.mas_equalTo(22);
                }];
            }
        }
    }
    
    
    if (self.joinedArray.count > 5) {
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.layer.cornerRadius = 10;
            [self.joinedImgArray addObject:img];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-10*(i+1)-i*26);
                make.width.and.height.mas_equalTo(26);
                make.bottom.mas_offset(-12);
            }];
        }
    }else if (self.joinedArray.count > 0){
        for (int i = 0; i < self.joinedArray.count; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.layer.cornerRadius = 10;
            [self.joinedImgArray addObject:img];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-10*(i+1)-i*26);
                make.width.and.height.mas_equalTo(26);
                make.bottom.mas_offset(-12);
            }];
        }
    }
}


@end
