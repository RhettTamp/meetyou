//
//  UMTActivitySimpleController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTActivitySimpleController.h"
#import "UMTSimpleActivityCell.h"
#import "UMTCheckSimpleController.h"
#import "UMTGetSimpleActivityListRequest.h"
#import "UMTDetailActivityCellModel.h"
#import "UMTUserInfoModel.h"
#import <MJRefresh.h>
#import <CoreLocation/CoreLocation.h>

@interface UMTActivitySimpleController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,strong) CLLocationManager *localManage;
@property (nonatomic,strong) NSMutableArray *siteArray;

@end

@implementation UMTActivitySimpleController
{
    NSInteger page;
    CGFloat kCellWidth;
    double nowLat,nowLng;
}
static NSString *const cellId = @"UMTSimpleActivityCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    kCellWidth = UMTScreenWidth<375?(UMTScreenWidth-15)/2: (UMTScreenWidth-29)/2;
    [self initCollectionView];
    self.datalist = [NSMutableArray array];
    _localManage = [[CLLocationManager alloc]init];
    _localManage.delegate = self;
    _localManage.distanceFilter = 100;
    self.siteArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData{
    [UMTGetSimpleActivityListRequest GetActivityListWithPage:1 CompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            [self.datalist removeAllObjects];
            [self.collectionView.mj_header endRefreshing];
            page = 1;
            NSArray *datas = response[@"data"];
            for (int i = 0; i < datas.count; i++) {
                UMTDetailActivityCellModel *model = [UMTDetailActivityCellModel yy_modelWithJSON:datas[i]];
                [self.datalist addObject:model];
                
            }
            [self.collectionView reloadData];
        }
    }];
}

- (void)refreshForMoreData{
    [UMTGetSimpleActivityListRequest GetActivityListWithPage:page CompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            NSArray *datas = response[@"data"];
            if (datas && datas.count > 0) {
                for (int i = 0; i < datas.count; i++) {
                    UMTDetailActivityCellModel *model = [UMTDetailActivityCellModel yy_modelWithJSON:datas[i]];
                    [self.datalist addObject:model];
                    [self.collectionView reloadData];
                }
            }else{
                page--;
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }

        }
    }];
}

- (void)initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadData];
        [collectionView.mj_header beginRefreshing];
    }];
    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self refreshForMoreData];
        [collectionView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self.view);
    }];
    [collectionView registerClass:[UMTSimpleActivityCell class] forCellWithReuseIdentifier:cellId];
    self.collectionView = collectionView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (UMTScreenWidth < 375) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UMTSimpleActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    UMTDetailActivityCellModel *model = self.datalist[indexPath.row];
    cell.title = model.title;
    cell.content = model.content;
    cell.applyEndTime = model.applyEndTime;
    cell.persenCount = model.peopleCount;
    cell.site = model.site;
    cell.tags = model.tags;
    cell.headUrl = model.creator.headImgUrl;
    if (self.siteArray.count > indexPath.row) {
        cell.distanceString = self.siteArray[indexPath.row];
    }
    [cell reloadData];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kCellWidth, 320);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UMTCheckSimpleController *checkSimpleVC = [[UMTCheckSimpleController alloc]init];
    checkSimpleVC.activityModel = self.datalist[indexPath.row];
    [self.navigationController pushViewController:checkSimpleVC animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    nowLng = newLocation.coordinate.longitude;
    //将纬度现实到label上
    nowLat = newLocation.coordinate.latitude;
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    for (int i = 0; i < self.datalist.count; i++) {
        UMTDetailActivityCellModel *model = self.datalist[i];[geocoder geocodeAddressString:model.site completionHandler:^(NSArray* placemarks, NSError* error){
            if (!error) {
                
                for (CLPlacemark* aPlacemark in placemarks)
                {
                    double lng = aPlacemark.location.coordinate.longitude;
                    double lat = aPlacemark.location.coordinate.latitude;
                    double distance = [self distanceBetweenOrderBy:nowLat :lat :nowLng :lng];
                    if (distance > 5000) {
                        [self.siteArray addObject:@">5km"];
                    }else if (distance > 1000){
                        [self.siteArray addObject:[NSString stringWithFormat:@"%1.2fkm",distance]];
                    }else{
                        [self.siteArray addObject:[NSString stringWithFormat:@"%2.0fm",distance]];
                    }
                }
                [self.collectionView reloadData];
            }
            else{
                NSLog(@"error--%@",[error localizedDescription]);
            }
        }];
    }
    
}

-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    return  distance;
}

@end
