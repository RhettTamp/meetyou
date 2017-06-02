//
//  UMTAttentionController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/22.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTAttentionController.h"
#import "UMTFindCellModel.h"
#import "UMTFindfTableViewCell.h"

@interface UMTAttentionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation UMTAttentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
}

- (void)addTableView{
    _tableview = [[UITableView alloc]init];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.estimatedRowHeight = 300;
    _tableview.rowHeight = UITableViewAutomaticDimension;
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
    
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UMTFindfTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.model = self.datalist[indexPath.row];
//    return cell.contentView.frame.size.height+1;
//}

@end
