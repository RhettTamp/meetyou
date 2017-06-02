//
//  UMTDetailActivityController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTDetailActivityController.h"
#import "UMTCircleView.h"
#import "UMTDetailActivityCell.h"
#import "UMTGetActivityListRequest.h"
#import "UMTDetailActivityCellModel.h"
#import "UMTCheckDetailController.h"
#import "UMTUserInfoModel.h"
#import <MJRefresh.h>

@interface UMTDetailActivityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation UMTDetailActivityController
{
    NSInteger page;
}
static NSString *const cellIdentifier = @"UMTDetailActivityCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datalist = [NSMutableArray array];
    [self initTableView];
//    [self refreshData];
    page = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshData];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self refreshData];
//}

- (void)refreshData{
    [UMTGetActivityListRequest GetActivityListWithPage:1 CompletionBlock:^(NSError *erro, id response) {
        [self.tableView.mj_header endRefreshing];
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            page = 1;
            NSArray *datas = response[@"data"];
            [self.datalist removeAllObjects];
            for (int i = 0; i < datas.count; i++) {
                UMTDetailActivityCellModel *model = [UMTDetailActivityCellModel yy_modelWithJSON:datas[i]];
                [self.datalist addObject:model];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)refeshForMoreData{
    [UMTGetActivityListRequest GetActivityListWithPage:page CompletionBlock:^(NSError *erro, id response) {
        [self.tableView.mj_footer endRefreshing];
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            NSArray *datas = response[@"data"];
            if (datas && datas.count > 0) {
                for (int i = 0; i < datas.count; i++) {
                    UMTDetailActivityCellModel *model = [UMTDetailActivityCellModel yy_modelWithJSON:datas[i]];
                    [self.datalist addObject:model];
                    [self.tableView reloadData];
                }
            }else{
                page--;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator =  NO;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
        [tableView.mj_header beginRefreshing];
    }];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self refeshForMoreData];
        [tableView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView = tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 227;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UMTDetailActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UMTDetailActivityCell alloc]initWithFrame:CGRectMake(0, 0, UMTScreenWidth, 227)];
    }
    UMTDetailActivityCellModel *model = self.datalist[indexPath.row];
    cell.title = model.title;
    cell.startTime = model.startTime;
    cell.endTime = model.endTime;
    cell.content = model.content;
    cell.headStr = model.creator.headImgUrl;
    cell.site = model.site;
    cell.tags = model.tags;
    cell.peoplePercent = model.peopleCount;
    cell.applyStartTime = model.applyStartTime;
    cell.applyEndTime = model.applyEndTime;
    [cell resetData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UMTCheckDetailController *checkDetailVc = [[UMTCheckDetailController alloc]init];
    checkDetailVc.activityModel = self.datalist[indexPath.row];
    [self.navigationController pushViewController:checkDetailVc animated:YES];
}


@end
