//
//  UMTCheckDetailController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTCheckDetailController.h"
#import "UMTActivitTopView.h"
#import "UMTSiteView.h"
#import "UMTCircleView.h"
#import "UMTDetailActicityView.h"
#import "UMTTagView.h"
#import "UMTDetailActivityCellModel.h"
#import "UMTJoinActivityRequest.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <CoreLocation/CoreLocation.h>

@interface UMTCheckDetailController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTActivitTopView *topView;
@property (nonatomic,strong) UMTSiteView *siteView;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UMTCircleView *personCircle;
@property (nonatomic,strong) UMTCircleView *timeCircle;
@property (nonatomic,strong) UILabel *timeProgressLabel;
@property (nonatomic,strong) UILabel *personProgressLabel;
@property (nonatomic,strong) UMTDetailActicityView *detailView;
@property (nonatomic,strong) NSMutableArray *tagsViewArray;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIView *mapView;

@end

@implementation UMTCheckDetailController
{
    double nowLat,nowLng;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self addMapImage];
    [self reloadData];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initUI{
    [self addScroolView];
    [self addTopView];
    [self addContentView];
    [self addDetailView];
    [self addMapImage];
}

- (void)addScroolView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth,0);
    NSLog(@"%f",UMTScreenWidth);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)addTopView{
    UMTActivitTopView *topView = [[UMTActivitTopView alloc]initWithFrame:CGRectMake(0, -64, UMTScreenWidth, 180)];
    topView.backgroundColor = Hex(0x20a0d8);
//    topView.title = @"五一厦门三日游";
//    topView.time = @"2017年05月01日-2017年05月03日";
    [self.scrollView addSubview:topView];
    self.topView = topView;
}

- (void)addContentView{
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
//    siteView.site = @"重庆邮电大学风雨操场";
    siteView.backgroundColor = kLineColor;
    [self.scrollView addSubview:siteView];
    [siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(180-64+20);
        make.height.mas_equalTo(20);
    }];
    self.siteView = siteView;
    
    UIView *mapView = [[UIView alloc]init];
    CGFloat width = UMTScreenWidth - 20;
    CGFloat height = width*148/355;
    [self.scrollView addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(siteView.mas_bottom).offset(10);
        make.height.mas_equalTo(height);
        make.right.equalTo(self.view).offset(-10);
    }];
    self.mapView = mapView;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"号外";
    label.font = [UIFont boldSystemFontOfSize:17];
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(mapView.mas_bottom).offset(12);
    }];
    UIView *leftPoint = [[UIView alloc]init];
    leftPoint.backgroundColor = [UIColor blackColor];
    leftPoint.layer.cornerRadius = 2;
    [self.scrollView addSubview:leftPoint];
    [leftPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label.mas_left).offset(-8);
        make.width.and.height.mas_equalTo(4);
        make.centerY.equalTo(label);
    }];
    UIView *rightPoint = [[UIView alloc]init];
    rightPoint.backgroundColor = [UIColor blackColor];
    rightPoint.layer.cornerRadius = 2;
    [self.scrollView addSubview:rightPoint];
    [rightPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(8);
        make.width.and.height.mas_equalTo(4);
        make.centerY.equalTo(label);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈放哪哦法国不能惹果然不浓不够热";
    contentLabel.numberOfLines = 0;
    contentLabel.font = kFont(15);
    contentLabel.textColor = Hex(0x333333);
    [self.scrollView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.top.equalTo(label.mas_bottom).offset(6);
        make.height.mas_lessThanOrEqualTo(120);
    }];
    self.contentLabel = contentLabel;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kLineColor;
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(1);
        make.top.equalTo(contentLabel.mas_bottom).offset(20);
    }];
    self.line1 = line;
}

- (void)addDetailView{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"进度";
    label.font = kFont(18);
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.line1.mas_bottom).offset(30);
    }];

    int side = (int)UMTScreenWidth*0.15;
    int lineWidth = 16.0/375*UMTScreenWidth;
    UMTCircleView *timeCircle = [[UMTCircleView alloc]initWithRadius:side circleWidth:lineWidth Progress:0.68];
    timeCircle.fillColor = Hex(0xececec);
    timeCircle.circleCocor = kCommonGreenColor;
    [self.scrollView addSubview:timeCircle];
    [timeCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(10);
        make.top.equalTo(self.line1.mas_bottom).offset(30);
        make.height.and.width.mas_equalTo(side*2);
    }];
    self.timeCircle = timeCircle;
    
    UMTCircleView *personCircle = [[UMTCircleView alloc]initWithRadius:side-lineWidth-4 circleWidth:lineWidth Progress:0.5];
    personCircle.fillColor = Hex(0xececec);
    personCircle.circleCocor = kCircleOrangeColor;
    [self.scrollView addSubview:personCircle];
    [personCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeCircle.mas_top).offset(lineWidth+4);
        make.left.equalTo(timeCircle.mas_left).offset(lineWidth+4);
        make.height.and.width.mas_equalTo(side*2-lineWidth*2-8);
    }];
    self.personCircle = personCircle;
    
    UILabel *tLabel = [[UILabel alloc]init];
    tLabel.text = @"报名时间已过";
    tLabel.font = kFont(15);
    tLabel.textColor = kCommonGreenColor;
    [self.scrollView addSubview:tLabel];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeCircle.mas_right).offset(20);
        make.centerY.equalTo(timeCircle).offset(-15);
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = kCommonGreenColor;
    timeLabel.text = @"68";
    timeLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.scrollView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tLabel.mas_right);
        make.bottom.equalTo(tLabel.mas_bottom);
    }];
    self.timeProgressLabel = timeLabel;
    UILabel *timePercentLabel = [[UILabel alloc]init];
    timePercentLabel.text = @"%";
    timePercentLabel.font = kFont(15);
    timePercentLabel.textColor = kCommonGreenColor;
    [self.scrollView addSubview:timePercentLabel];
    [timePercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_right);
        make.bottom.equalTo(timeLabel.mas_bottom);
    }];
    
    UILabel *pLabel = [[UILabel alloc]init];
    pLabel.text = @"完成目标人数";
    pLabel.font = kFont(15);
    pLabel.textColor = kCircleOrangeColor;
    [self.scrollView addSubview:pLabel];
    [pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tLabel.mas_left);
//        make.top.equalTo(tLabel.mas_bottom).offset(15);
        make.centerY.equalTo(timeCircle).offset(15);
    }];
    UILabel *personProgress = [[UILabel alloc]init];
    personProgress.textColor = kCircleOrangeColor;
    personProgress.text = @"50";
    personProgress.font = [UIFont boldSystemFontOfSize:24];
    [self.scrollView addSubview:personProgress];
    [personProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pLabel.mas_right);
        make.bottom.equalTo(pLabel.mas_bottom);
    }];
    self.personProgressLabel = personProgress;
    UILabel *personPercentLabel = [[UILabel alloc]init];
    personPercentLabel.text = @"%";
    personPercentLabel.font = kFont(15);
    personPercentLabel.textColor = kCircleOrangeColor;
    [self.scrollView addSubview:personPercentLabel];
    [personPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personProgress.mas_right);
        make.bottom.equalTo(pLabel.mas_bottom);
    }];
    
    UMTDetailActicityView *detailView = [[UMTDetailActicityView alloc]init];
    [self.scrollView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(timeCircle.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(180);
    }];
    self.detailView = detailView;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kLineColor;
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(1);
        make.top.equalTo(detailView.mas_bottom).offset(15);
    }];
    self.bottomLine = line;
//    UMTTagView *tagView = [[UMTTagView alloc]init];
//    tagView.tagStr = @"旅游";
//    tagView.backgroundColor = [UIColor blueColor];
//    [self.scrollView addSubview:tagView];
//    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(8);
//        make.top.equalTo(line.mas_bottom).offset(20);
//        make.height.mas_equalTo(20);
//    }];
//    self.tagView = tagView;
    
    UIButton *issueButton = [[UIButton alloc]init];
    [issueButton setTitle:@"报名" forState:UIControlStateNormal];
    [issueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    issueButton.backgroundColor = kCommonGreenColor;
    issueButton.layer.cornerRadius = 4;
    [issueButton addTarget:self action:@selector(issueActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:issueButton];
    [issueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
        make.top.equalTo(line.mas_bottom).offset(64);
        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-10);
//        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-30);
    }];
}

- (void)reloadData{
    UMTDetailActivityCellModel *model = self.activityModel;
    self.topView.title = model.title;
   
    self.siteView.site = model.site;
    self.contentLabel.text = model.content;
    self.personCircle.progress = model.peopleCount;
    self.personProgressLabel.text = [NSString stringWithFormat:@"%2.0f",model.peopleCount*100];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *startDate = [format dateFromString:model.startTime];
    NSDate *endDate = [format dateFromString:model.endTime];
    NSDate *applyStartTime = [format dateFromString:model.applyStartTime];
    NSDate *applyEndTime = [format dateFromString:model.applyEndTime];
    NSDate *now = [NSDate date];
    CGFloat timePercent;
    if ([now timeIntervalSinceDate:applyStartTime] > 0) {
        if ([now timeIntervalSinceDate:applyStartTime]>[applyEndTime timeIntervalSinceDate:applyStartTime]) {
            timePercent = 1;
        }else{
            timePercent = [now timeIntervalSinceDate:applyStartTime]/[applyEndTime timeIntervalSinceDate:applyStartTime];
        }
    }else{
        timePercent = 0;
    }
    
    self.timeCircle.progress = timePercent;
    self.timeProgressLabel.text = [NSString stringWithFormat:@"%2.0f",timePercent*100];
    NSDateFormatter *timeStrFormat = [[NSDateFormatter alloc]init];
    timeStrFormat.dateFormat = @"yyyy年MM月dd日";
    NSString *starTimeStr = [timeStrFormat stringFromDate:startDate];
    NSString *endTimeStr = [timeStrFormat stringFromDate:endDate];
    NSString *startApllyTimeStr = [timeStrFormat stringFromDate:applyStartTime];
    NSString *endApplyTimeStr = [timeStrFormat stringFromDate:applyEndTime];
    NSString *timeString = [NSString stringWithFormat:@"%@-%@",starTimeStr,endTimeStr];
    self.topView.time = timeString;
    self.detailView.limitPerson = model.peopleLimit;
    self.detailView.joinedPerson = model.joinedPeople;
    self.detailView.startTime = startApllyTimeStr;
    self.detailView.endTime = endApplyTimeStr;
    self.detailView.state = model.status;
    [self addTagView];
}

- (void)addTagView{
    self.tagsViewArray = [NSMutableArray array];
    NSArray *tags = self.activityModel.tags;
    NSInteger count = tags.count;
    if (count > 2) {
        for (int i = 0; i < 2; i++) {
            UMTTagView *tagView = [[UMTTagView alloc]init];
            tagView.tagStr = tags[i];
            [self.tagsViewArray addObject:tagView];
            [self.scrollView addSubview:tagView];
            if (i == 0) {
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.top.equalTo(self.bottomLine.mas_bottom).offset(12);
                    make.height.mas_equalTo(22);
                }];
            }else{
                UMTTagView *v = self.tagsViewArray[i-1];
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(v.mas_right).offset(10);
                    make.top.equalTo(self.bottomLine.mas_bottom).offset(12);
                    make.height.mas_equalTo(22);
                }];
            }
        }
    }else{
        for (int i = 0; i < count; i++) {
            UMTTagView *tagView = [[UMTTagView alloc]init];
            tagView.tagStr = tags[i];
            [self.tagsViewArray addObject:tagView];
            [self.scrollView addSubview:tagView];
            if (i == 0) {
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.top.equalTo(self.bottomLine.mas_bottom).offset(12);
                    make.height.mas_equalTo(22);
                }];
            }else{
                UMTTagView *v = self.tagsViewArray[i-1];
                [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(v.mas_right).offset(10);
                    make.top.equalTo(self.bottomLine.mas_bottom).offset(12);
                    make.height.mas_equalTo(22);
                }];
            }
        }
    }
}

- (void)addMapImage{
    __block CGFloat lat = 116.403874;
    __block CGFloat lng = 39.914888;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.activityModel.site completionHandler:^(NSArray* placemarks, NSError* error){
        if (!error) {
            
            for (CLPlacemark* aPlacemark in placemarks)
            {
                lng = aPlacemark.location.coordinate.longitude;
                lat = aPlacemark.location.coordinate.latitude;
//                NSLog(@"place--%@", [aPlacemark locality]);
//                NSLog(@"lat--%f--lon--%f",aPlacemark.location.coordinate.latitude,aPlacemark.location.coordinate.longitude);
                NSString *urlString = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?center=%f,%f&markers=%f,%f&width=355&height=148&zoom=18",lng,lat,lng,lat];
                NSLog(@"%@",urlString);
                UIImageView *mapImage = [[UIImageView alloc]initWithFrame:self.mapView.bounds];
                [mapImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@""]];
                [self.mapView addSubview:mapImage];
            }
        
        }
        else{
            
            NSLog(@"error--%@",[error localizedDescription]);
            
        }
    }];
}


- (void)issueActivity{
    if (![self.activityModel.status isEqualToString:@"报名进行中"]) {
        [[UMTProgressHUD sharedHUD]showWithText:[NSString stringWithFormat:@"%@",self.activityModel.status] inView:self.view hideAfterDelay:0.5];
        return;
    }
    [UMTJoinActivityRequest JoinActivityWithActivityId:self.activityModel.activityId CompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            if ([response[@"status_code"] isEqualToString:@"2000"]) {
                [[UMTProgressHUD sharedHUD] showWithText:@"参加成功" inView:self.view hideAfterDelay:0.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",response[@"info"]] inView:self.view hideAfterDelay:0.5];
            }
            
        }
    }];
}

@end
