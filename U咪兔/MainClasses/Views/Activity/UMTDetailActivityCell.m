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
@property (nonatomic,strong) NSArray *tags;
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
        make.left.mas_offset(8);
        make.top.mas_offset(5);
        make.width.and.height.mas_equalTo(46);
    }];
    self.headImage = img;
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClicked)];
    [titleView addGestureRecognizer:tap];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(img.mas_right).offset(5);
        make.top.mas_offset(5);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = kFont(20);
    titleLabel.text = @"五一厦门三日游";
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView);
        make.right.mas_offset(50);
        make.centerY.equalTo(titleView);
    }];
    self.titleLabel = titleLabel;
    
    UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [titleView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(titleLabel);
        make.width.and.height.mas_equalTo(18);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = kFont(12);
    timeLabel.textColor = kLineColor;
    timeLabel.text = @"2017年05月01日-2017年05月03日";
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(5);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(200);
        make.top.equalTo(titleView.mas_bottom).offset(2);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = kFont(16);
    contentLabel.text = @"一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊一起玩啊";
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(3);
        make.width.mas_equalTo(UMTScreenWidth/2-5);
        make.height.mas_equalTo(80);
        make.top.equalTo(img.mas_bottom).offset(8);
    }];
    self.contentLabel = contentLabel;
    
    UMTCircleView *personCirclr = [[UMTCircleView alloc]initWithRadius:40 circleWidth:10 Progress:0.3];
    personCirclr.circleCocor = kCommonGreenColor;
    [self addSubview:personCirclr];
    [personCirclr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel.mas_right).offset(15);
        make.width.mas_equalTo(80);
        make.top.equalTo(contentLabel.mas_top).offset(15);
        make.height.mas_equalTo(80);
    }];
    self.personCircle = personCirclr;
    
    UMTCircleView *timeCircle = [[UMTCircleView alloc]initWithRadius:28 circleWidth:10 Progress:0.6];
    timeCircle.circleCocor = [UIColor orangeColor];
    [self addSubview:timeCircle];
    [timeCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCirclr.mas_left).offset(12);
        make.width.and.height.mas_equalTo(56);
        make.top.equalTo(personCirclr.mas_top).offset(12);
    }];
    self.timeCircle = timeCircle;
    
    UILabel *personCountLabel = [[UILabel alloc]init];
    personCountLabel.font = kFont(18);
    personCountLabel.textColor = kCommonGreenColor;
    personCountLabel.text = @"64";
    [self addSubview:personCountLabel];
    [personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCirclr.mas_right).offset(8);
        make.top.equalTo(personCirclr.mas_top).offset(15);
//        make.right.mas_offset(-50);
    }];
    self.personCountLabel = personCountLabel;
    UILabel *percentLabel1 = [[UILabel alloc]init];
    percentLabel1.font = kFont(14);
    percentLabel1.textColor = kCommonGreenColor;
    percentLabel1.text = @"%";
    [self addSubview:percentLabel1];
    [percentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCountLabel.mas_right);
        make.bottom.equalTo(personCountLabel.mas_bottom);
    }];
    
    UILabel *timeCountLabel = [[UILabel alloc]init];
    timeCountLabel.font = kFont(18);
    timeCountLabel.textColor = [UIColor orangeColor];
    timeCountLabel.text = @"53";
    [self addSubview:timeCountLabel];
    [timeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personCountLabel.mas_bottom).offset(5);
        make.left.equalTo(personCountLabel.mas_left);
    }];
    UILabel *percentLabel2 = [[UILabel alloc]init];
    percentLabel2.font = kFont(14);
    percentLabel2.textColor = [UIColor orangeColor];
    percentLabel2.text = @"%";
    [self addSubview:percentLabel2];
    [percentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeCountLabel.mas_right);
        make.bottom.equalTo(timeCountLabel.mas_bottom);
    }];
    
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
    siteView.backgroundColor = kLineColor;
    siteView.layer.cornerRadius = 3;
    [self addSubview:siteView];
    [siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel.mas_left);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(28);
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
                    make.left.mas_offset(5);
                    make.bottom.mas_offset(-8);
                    make.height.mas_equalTo(20);
                }];
            }else{
                UMTTagView *v = self.tagsViewArray[i-1];
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(v.mas_right).offset(5);
                    make.bottom.mas_offset(-8);
                    make.height.mas_equalTo(20);
                }];
            }
            
        }
    }
    
    //创建参与者view
    if (self.joinedArray.count > 5) {
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.layer.cornerRadius = 10;
            [self.joinedImgArray addObject:img];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-5*i-i*20);
                make.width.and.height.mas_equalTo(30);
                make.bottom.mas_offset(-8);
            }];
        }
    }else if (self.joinedArray.count > 0){
        for (int i = 0; i < self.joinedArray.count; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.layer.cornerRadius = 10;
            [self.joinedImgArray addObject:img];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-5*i-i*20);
                make.width.and.height.mas_equalTo(30);
                make.bottom.mas_offset(-8);
            }];
        }
    }
    
    //--------------------------------------------------------
    self.tagsViewArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        UMTTagView *tagView = [[UMTTagView alloc]init];
        tagView.tagStr = @"社团活动";
        tagView.backgroundColor = kCommonGreenColor;
        [self.tagsViewArray addObject:tagView];
        [self addSubview:tagView];
        if (i == 0) {
            [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(5);
                make.bottom.mas_offset(-8);
                make.height.mas_equalTo(20);
            }];
        }else{
            UMTTagView *v = self.tagsViewArray[i-1];
            [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v.mas_right).offset(5);
                make.bottom.mas_offset(-8);
                make.height.mas_equalTo(20);
            }];
        }
    }
    
    for (int i = 0; i < 5; i++) {
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.layer.cornerRadius = 10;
            NSString *headImgStr = [NSString stringWithFormat:@"m%d",arc4random()%10];
            img.image = [UIImage imageNamed:headImgStr];
            [self.joinedImgArray addObject:img];
            [self addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-5*i-i*20);
                make.width.and.height.mas_equalTo(20);
                make.bottom.mas_offset(-8);
            }];
        }
    }
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.siteView.site = @"厦门鼓浪屿等";
    [self layoutIfNeeded];
}

- (void)titleClicked{
    
}

@end
