//
//  UMTNearbyController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/22.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTNearbyController.h"
#import "UMTFindfTableViewCell.h"
#import "UMTFindCellModel.h"

@interface UMTNearbyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *datalist;

@end

@implementation UMTNearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.datalist = [NSArray array];
    [self addTableView];
}

- (void)addTableView{
    _tableview = [[UITableView alloc]init];
    _tableview.delegate = self;
    _tableview.dataSource = self;
//    [_tableview registerClass:[UMTFindfTableViewCell class] forCellReuseIdentifier:@"UMTFindfTableViewCell"];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self.view);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UMTFindfTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 430;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UMTFindfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UMTFindfTableViewCell"];
    if (cell == nil) {
        cell = [[UMTFindfTableViewCell alloc]init];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UMTFindfTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.model = self.datalist[indexPath.row];
//    return cell.contentView.frame.size.height+1;
//}

@end
