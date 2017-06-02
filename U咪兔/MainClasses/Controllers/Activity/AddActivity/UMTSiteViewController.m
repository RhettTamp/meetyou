//
//  UMTSiteViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSiteViewController.h"
#import "UMTSearchSiteCell.h"
#import "UMTSiteModel.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKSuggestionSearchOption.h>
#import <BaiduMapAPI_Search/BMKSuggestionSearch.h>


@interface UMTSiteViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKSuggestionSearchDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITextField *siteText;
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKLocationService *service;
@property (nonatomic,strong) UITableView *searchTableView;
@property (nonatomic,strong) NSMutableArray *siteArray;
@property (nonatomic,strong) BMKSuggestionSearch *suggestionSearch;
@property (nonatomic,strong) UILabel *cityLabel;

@end

@implementation UMTSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self addRightButton];
    _siteArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initMapView];
    [self.mapView viewWillAppear];
    [self addSearchView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.service.delegate = nil;
}

- (void)dealloc{
    if (self.mapView) {
        self.mapView = nil;
    }
    self.suggestionSearch.delegate = nil;
//    self.poiSearch.delegate = nil;
    self.service.delegate = nil;
}

- (void)addSearchView{
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor = Hex(0xffffff);
    searchView.layer.cornerRadius = 4;
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(77);
        make.height.mas_equalTo(44);
    }];
    
    UIView *cityView = [[UIView alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(cityChoice)];
    [cityView addGestureRecognizer:tap];
    [searchView addSubview:cityView];
    [cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(searchView);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *cityLabel = [[UILabel alloc]init];
    cityLabel.text = @"重庆市";
    cityLabel.font = kFont(15);
    cityLabel.textColor = Hex(0x333333);
    [searchView addSubview:cityLabel];
    [cityView addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityView.mas_left);
        make.centerY.equalTo(cityView);
    }];
    self.cityLabel = cityLabel;
    
    UIImageView *triangleImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle"]];
    [cityView addSubview:triangleImage];
    [triangleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityLabel.mas_right).offset(2);
        make.centerY.equalTo(cityLabel);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(5);
        make.right.equalTo(cityView.mas_right);
    }];
    
    UITextField *text = [[UITextField alloc]init];
    [text addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.delegate = self;
    [searchView addSubview:text];
    self.siteText = text;
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityView.mas_right).offset(5);
        make.centerY.equalTo(searchView);
        make.height.mas_equalTo(30);
        make.right.mas_offset(-55);
        make.width.mas_greaterThanOrEqualTo(150);
    }];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:Hex(0xadadad) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelSearchClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchView);
        make.right.mas_offset(-10);
    }];
    
    UITableView *searchTable = [[UITableView alloc]init];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.alpha = 0;
    [self.view addSubview:searchTable];
    [searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(searchView.mas_bottom).offset(10);
        make.bottom.mas_offset(-30);
    }];
    self.searchTableView = searchTable;
}


- (void)initMapView{
    self.mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    self.mapView.mapType = BMKMapTypeStandard;
    
    self.mapView.trafficEnabled = YES;
    self.mapView.showMapPoi = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.zoomLevel = 17;
    _mapView.rotation = YES;
    self.mapView.scrollEnabled = YES;
    [self.view addSubview:_mapView];
    
    self.service = [[BMKLocationService alloc]init];
    _service.desiredAccuracy = kCLLocationAccuracyBest;
    _service.delegate = self;
    [_service startUserLocationService];
}

- (void)addRightButton{
    self.title = @"选择地点";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(commitButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)commitButtonClicked{
    self.block(self.siteText.text);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--BMKLocationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    self.mapView.showsUserLocation = YES;
    [self.mapView updateLocationData:userLocation];
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

#pragma mark--UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.siteArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UMTSearchSiteCell *cell = [[UMTSearchSiteCell alloc]init];
    UMTSiteModel *model = self.siteArray[indexPath.row];
    cell.site = model.site;
    cell.detailSite = model.detaiSite;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UMTSiteModel *model = self.siteArray[indexPath.row];
    self.siteText.text = model.site;
    tableView.alpha = 0;
    [self.view endEditing:YES];
}


- (void)textFieldChanged{
    _suggestionSearch  = [[BMKSuggestionSearch alloc]init];
    _suggestionSearch.delegate = self;
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc]init];
    option.cityname = self.cityLabel.text;
    option.keyword = self.siteText.text;
    
    BOOL flag = [_suggestionSearch suggestionSearch:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}

- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        for (int i = 0; i < result.keyList.count; i++) {
            UMTSiteModel *model = [[UMTSiteModel alloc]init];
            model.site = result.keyList[i];
            model.detaiSite = [NSString stringWithFormat:@"%@%@%@",result.cityList[i],result.districtList[i],result.keyList[i]];
            [self.siteArray addObject:model];
        }
        self.searchTableView.alpha = 1;
        [self.searchTableView reloadData];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


- (void)cancelSearchClicked{
    [self.view endEditing:YES];
    self.searchTableView.alpha = 0;
}

- (void)cityChoice{
    
}

@end
