//
//  UMTFindSchoolController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTFindSchoolController.h"
#import <MJRefresh.h>
#import "UMTSearchSchoolRequest.h"

@interface UMTFindSchoolController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *schoolArray;
@property (nonatomic,strong) UITableView *searchTableView;
@property (nonatomic,strong) NSString *choisedSchool;
@property (nonatomic,strong) NSString *searchText;
@property (nonatomic,strong) NSDictionary *currentSchool;

@end

@implementation UMTFindSchoolController

- (NSString *)title{
    return @"选择学校";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.searchController.active = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.searchController.active = NO;
}

- (void)initUI{
    self.schoolArray = [NSMutableArray array];
    [self initSearchView];
}

- (void)initSearchView{
    UITableView *tableView= [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    self.searchTableView = tableView;
    //    tableView.hidden = YES;
    
    UISearchController *searchVc = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchVc.searchResultsUpdater = self;
    searchVc.delegate = self;
    searchVc.searchBar.frame = CGRectMake(0, 0, UMTScreenWidth, 44);
    searchVc.searchBar.placeholder = @"请输入学校的完整名称";
    searchVc.searchBar.delegate = self;
    searchVc.hidesNavigationBarDuringPresentation = NO;
    searchVc.dimsBackgroundDuringPresentation = NO;
    self.searchController = searchVc;
    //    [self.view addSubview:searchVc.view];
    tableView.tableHeaderView = searchVc.searchBar;
    tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        if (self.schoolArray.count > 10) {
            [self.searchTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self requestMoreData];
    }];
}

#pragma mark -- tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.schoolArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.schoolArray[indexPath.row][@"school_name"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.searchController.active = NO;
    self.searchController.searchBar.text = self.schoolArray[indexPath.row][@"school_name"];
    self.choisedSchool = self.schoolArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.getSchoolBlock(self.schoolArray[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (self.searchController.active == YES) {
        self.searchText = self.searchController.searchBar.text;
        if (self.searchText&&![self.searchText isEqualToString:@""]) {
            self.searchTableView.hidden = NO;
            [self requestMoreData];
            
        }else{
            [self.schoolArray removeAllObjects];
            [self.searchTableView reloadData];
        }
    }else{
        
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [[UMTProgressHUD sharedHUD] rotateWithText:@"获取数据中" inView:self.view];
    [UMTSearchSchoolRequest getMoreSchoolWithKey:self.searchText andCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD] hideAfterDelay:0];
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            NSArray *arr = response[@"data"];
            for (NSDictionary *dic in arr) {
                [self.schoolArray addObject:dic];
            }
        }
    }];
    [self.searchTableView reloadData];
    self.searchController.active = NO;
}

- (void)requestMoreData{
    [UMTSearchSchoolRequest getMoreSchoolWithKey:self.searchText andCompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            NSArray *arr = response[@"data"];
            for (NSDictionary *dic in arr) {
                [self.schoolArray addObject:dic];
            }
            [self.searchTableView reloadData];
        }
    }];
}

#pragma mark--location


//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    //    switch (status) {
    //
    //        casekCLAuthorizationStatusNotDetermined:
    //            if ([self.locationManagerrespondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //                [self.locationManagerrequestWhenInUseAuthorization];
    //            }break;
    //        default:break;
    //    }
//}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    
//    
//    
//    CLLocation *newLocation = locations[0];
//    
//    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
//    
//    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
//    
//    _searcher =[[BMKPoiSearch alloc]init];
//    _searcher.delegate = self;
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageIndex = 1;
//    option.pageCapacity = 10;
//    option.location = oldCoordinate;
//    option.keyword = @"学校";
//    option.radius = 1000;
//    option.sortType = BMK_POI_SORT_BY_DISTANCE;
//    BOOL flag = [_searcher poiSearchNearBy:option];
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }
//    else
//    {
//        NSLog(@"周边检索发送失败");
//    }
//    
//    [manager stopUpdatingLocation];
//    
//    
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
//        
//        
//        
//        for (CLPlacemark *place in placemarks) {
//            
//            NSLog(@"name,%@",place.name);                      // 位置名
//            
//            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
//            
//            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
//            
//            NSLog(@"locality,%@",place.locality);              // 市
//            
//            NSLog(@"subLocality,%@",place.subLocality);        // 区
//            
//            NSLog(@"country,%@",place.country);                // 国家
//            
//            
//        }
//        
//    }];
//    
//}

//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    if ([error code] == kCLErrorDenied) {
//        NSLog(@"访问被拒绝");
//    }
//    if ([error code] == kCLErrorLocationUnknown) {
//        NSLog(@"无法获取位置信息");
//    }
//}
//
//#pragma mark--BMKPoiSearchDelegate
//- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
//    NSLog(@"%@",poiResult);
//}

@end
