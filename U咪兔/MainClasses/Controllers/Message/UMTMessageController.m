//
//  UMTMessageController.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTMessageController.h"
#import "UMTMessageTableCell.h"


@interface UMTMessageController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation UMTMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UMTMessageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UMTMessageTableCell"];
    if (cell == nil) {
        cell = [[UMTMessageTableCell alloc]init];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
