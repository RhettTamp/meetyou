//
//  UMTCheckSimpleController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTCheckSimpleController.h"
#import "UMTActivitTopView.h"
#import "UMTSiteView.h"
#import "UMTCircleView.h"
#import "UMTSimpleActivityView.h"
#import "UMTTagView.h"
#import "UMTDetailActivityCellModel.h"
#import "UMTTimeHelper.h"
#import "UMTJoinActivityRequest.h"
#import <CoreLocation/CoreLocation.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UMTCheckSimpleController ()<CLLocationManagerDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTActivitTopView *topView;
@property (nonatomic,strong) UMTSiteView *siteView;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UILabel *perdsonCountLable;
@property (nonatomic,strong) UMTSimpleActivityView *detailView;
@property (nonatomic,strong) UMTTagView *tagView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UMTCircleView *personCircle;
@property (nonatomic,strong) UIView *mapView;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) CLLocationManager *localManage;

@end

@implementation UMTCheckSimpleController

{
    double nowLat,nowLng;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    [self initUI];
    [self reloadData];
    CLLocationManager *locationManage = [[CLLocationManager alloc]init];
    locationManage.delegate = self;
    locationManage.desiredAccuracy = kCLLocationAccuracyBest;
    locationManage.distanceFilter = 100;
    [locationManage requestWhenInUseAuthorization];
    [locationManage startUpdatingLocation];//开启定位
    self.localManage = locationManage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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
    scrollView.contentSize = CGSizeMake(UMTScreenWidth,700);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)addTopView{
    UMTActivitTopView *topView = [[UMTActivitTopView alloc]initWithFrame:CGRectMake(0, -64, UMTScreenWidth, 180)];
    topView.backgroundColor = kCommonGreenColor;
    topView.title = @"五一厦门三日游";
    topView.time = @"00:30:22 以内";
    [self.scrollView addSubview:topView];
    self.topView = topView;
}

- (void)addContentView{
    UMTSiteView *siteView = [[UMTSiteView alloc]init];
    siteView.site = @"重庆邮电大学风雨操场";
    siteView.backgroundColor = kLineColor;
    [self.scrollView addSubview:siteView];
    [siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(self.topView.mas_bottom).offset(20);
        make.height.mas_equalTo(22);
    }];
    self.siteView = siteView;
    
    UIView *mapView = [[UIView alloc]init];
    mapView.backgroundColor = kCommonGreenColor;
    [self.scrollView addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(siteView.mas_bottom).offset(10);
        make.height.and.width.mas_equalTo(UMTScreenWidth*148.0/375);
    }];
    self.mapView = mapView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"号外";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.scrollView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mapView.mas_right).offset(8);
        make.top.equalTo(mapView.mas_top);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"晚上78节，风雨操场约羽毛球。菜鸟一枚，求带";
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    [self.scrollView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.bottom.mas_lessThanOrEqualTo(mapView.mas_bottom);
    }];
    self.contentLabel = contentLabel;
    
    UILabel *hintLabel = [[UILabel alloc]init];
    hintLabel.text = @"距你的位置";
    hintLabel.font = [UIFont boldSystemFontOfSize:11];
    hintLabel.textColor = Hex(0x7b7b7b);
    [self.scrollView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(mapView.mas_bottom).offset(10);
    }];
    
    UILabel *distanceLabel = [[UILabel alloc]init];
    distanceLabel.font = [UIFont boldSystemFontOfSize:11];
    distanceLabel.textColor = kCommonGreenColor;
    distanceLabel.text = @"500m-1km";
    [self.scrollView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintLabel.mas_right).offset(6);
        make.centerY.equalTo(hintLabel);
    }];
    self.distanceLabel = distanceLabel;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kLineColor;
    [self.scrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view).mas_offset(-8);
        make.height.mas_equalTo(1);
        make.top.equalTo(hintLabel.mas_bottom).offset(30);
    }];
    self.line1 = lineView;
}

- (void)addDetailView{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"进度";
//    label.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.equalTo(self.line1.mas_bottom).offset(15);
    }];
    
    UMTCircleView *circleView = [[UMTCircleView alloc]initWithRadius:30 circleWidth:10 Progress:.2];
    circleView.fillColor = Hex(0xececec);
    circleView.circleCocor = kCircleOrangeColor;
    [self.scrollView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(60);
        make.top.equalTo(label.mas_top);
        make.left.equalTo(label.mas_right).offset(25);
    }];
    self.personCircle = circleView;
    
    UILabel *hintLable = [[UILabel alloc]init];
    hintLable.textColor = kCircleOrangeColor;
    hintLable.text = @"完成目标人数";
    hintLable.font = kFont(15);
    [self.scrollView addSubview:hintLable];
    [hintLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).offset(UMTScreenWidth*52.0/375);
        make.centerY.equalTo(circleView);
    }];
    UILabel *personCountLabel = [[UILabel alloc]init];
    personCountLabel.font = [UIFont boldSystemFontOfSize:24];
    personCountLabel.text = @"20";
    personCountLabel.textColor = kCircleOrangeColor;
    [self.scrollView addSubview:personCountLabel];
    [personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintLable.mas_right);
        make.bottom.equalTo(hintLable.mas_bottom);
    }];
    self.perdsonCountLable = personCountLabel;
    
    UILabel *percentLabel = [[UILabel alloc]init];
    percentLabel.textColor = kCircleOrangeColor;
    percentLabel.text = @"%";
    [self.scrollView addSubview:percentLabel];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCountLabel.mas_right);
        make.bottom.equalTo(hintLable.mas_bottom);
    }];
    
//    UILabel *percentLabel = [[UILabel alloc]init];
//    percentLabel.textColor = [UIColor orangeColor];
//    percentLabel.text = @"%";
//    [self.scrollView addSubview:percentLabel];
//    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view.mas_right).offset(-20);
//        make.centerY.equalTo(circleView);
//    }];
//    
//    UILabel *personCountLabel = [[UILabel alloc]init];
//    personCountLabel.font = kFont(22);
//    personCountLabel.text = @"20";
//    personCountLabel.textColor = [UIColor orangeColor];
//    [self.scrollView addSubview:personCountLabel];
//    [personCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(percentLabel.mas_left);
//        make.bottom.equalTo(percentLabel.mas_bottom);
//    }];
//    
//    UILabel *hintLable = [[UILabel alloc]init];
//    hintLable.textColor = [UIColor orangeColor];
//    hintLable.text = @"完成目标人数";
//    [self.scrollView addSubview:hintLable];
//    [hintLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(personCountLabel.mas_left);
//        make.bottom.equalTo(percentLabel.mas_bottom);
//    }];
    
    UMTSimpleActivityView *detaiView = [[UMTSimpleActivityView alloc]init];
    [self.scrollView addSubview:detaiView];
    [detaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(150);
        make.top.equalTo(circleView.mas_bottom).offset(30);
    }];
    self.detailView = detaiView;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kLineColor;
    [self.scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detaiView.mas_bottom).offset(15);
        make.left.mas_equalTo(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.height.mas_equalTo(1);
    }];
    
    UMTTagView *tagView = [[UMTTagView alloc]init];
    tagView.tagStr = @"运动";
    tagView.backgroundColor = kCommonGreenColor;
    [self.scrollView addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.equalTo(line.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    self.tagView = tagView;
    
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
        make.height.mas_equalTo(44);
        make.top.equalTo(tagView.mas_bottom).offset(30);
    }];
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
                NSLog(@"place--%@", [aPlacemark locality]);
                NSLog(@"lat--%f--lon--%f",aPlacemark.location.coordinate.latitude,aPlacemark.location.coordinate.longitude);
                NSString *urlString = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?center=%f,%f&markers=%f,%f&width=148&height=148&zoom=18",lng,lat,lng,lat];
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

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    nowLng = newLocation.coordinate.longitude;
    //将纬度现实到label上
    nowLat = newLocation.coordinate.latitude;
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.activityModel.site completionHandler:^(NSArray* placemarks, NSError* error){
        if (!error) {
            
            for (CLPlacemark* aPlacemark in placemarks)
            {
                double lng = aPlacemark.location.coordinate.longitude;
                double lat = aPlacemark.location.coordinate.latitude;
                double distance = [self distanceBetweenOrderBy:nowLat :lat :nowLng :lng];
                if (distance > 5000) {
                    self.distanceLabel.text = @">5km";
                }else if (distance > 1000){
                    self.distanceLabel.text = [NSString stringWithFormat:@"%1.2fkm",distance];
                }else{
                    self.distanceLabel.text = [NSString stringWithFormat:@"%2.0fm",distance];
                }
            }
            
        }
        else{
            NSLog(@"error--%@",[error localizedDescription]);
        }
    }];
}

-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    return  distance;
}

- (void)reloadData{
    UMTDetailActivityCellModel *model = self.activityModel;
    self.topView.title = model.title;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *endDate = [format dateFromString:model.applyEndTime];
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [endDate timeIntervalSinceDate:now];

    if (interval > 0) {
        NSString *timeStr = [UMTTimeHelper timeFromTimeInterval:interval];
        self.topView.time = [NSString stringWithFormat:@"%@ 以内",timeStr];
        self.detailView.timeString = @"00小时00分钟00秒";
    }else{
        self.topView.time = @"00:00:00 以内";
        NSString *timeString = [[UMTTimeHelper timeFromTimeInterval:interval] stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:@"小时"];
        timeString = [timeString stringByReplacingCharactersInRange:NSMakeRange(6, 1) withString:@"分钟"];
        timeString = [timeString stringByAppendingString:@"秒"];
         self.detailView.timeString = timeString;
    }
    self.siteView.site = model.site;
    self.contentLabel.text = model.content;
    self.personCircle.progress = model.peopleCount;
    self.perdsonCountLable.text = [NSString stringWithFormat:@"%2.0f",model.peopleCount*100];
    self.detailView.limitPerson = model.peopleLimit;
    self.detailView.joinedPerson = model.joinedPeople;
    self.detailView.state = model.status;
   
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
            }else{
                [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",response[@"info"]] inView:self.view hideAfterDelay:0.5];
            }
            
        }
    }];
}

@end
