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


@interface UMTDetailActivityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation UMTDetailActivityController

static NSString *const cellIdentifier = @"UMTDetailActivityCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datalist = [NSMutableArray array];
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//    UMTCircleView *cir = [[UMTCircleView alloc]initWithRadius:50 circleWidth:20 Progress:0.7];
//    cir.frame = CGRectMake(50, 80, 100, 100);
//    [self.view addSubview:cir];
    [self initTableView];
    [self refreshData];
}

- (void)refreshData{
    [UMTGetActivityListRequest GetActivityListWithCompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            NSArray *datas = response[@"data"];
            for (int i = 0; i < datas.count; i++) {
                UMTDetailActivityCellModel *model = [UMTDetailActivityCellModel yy_modelWithJSON:datas[i]];
                [self.datalist addObject:model];
            }
        }
    }];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UMTDetailActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UMTDetailActivityCell alloc]initWithFrame:CGRectMake(0, 0, UMTScreenWidth, 220)];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UMTCheckDetailController *checkDetailVc = [[UMTCheckDetailController alloc]init];
    [self.navigationController pushViewController:checkDetailVc animated:YES];
}


@end
