//
//  UMTInfoContactController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTInfoContactController.h"
#import "UMTContactCell.h"
#define kRowHeight 40

@interface UMTInfoContactController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contacTableView;
@property (nonatomic,strong) NSMutableArray *datas;

@end

@implementation UMTInfoContactController
{
    NSInteger currentrows;
    CGFloat selfHeight;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        currentrows = 2;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.editing = YES;
        selfHeight = tableView.height;
        [tableView registerNib:[UINib nibWithNibName:@"UMTContactCell" bundle:nil] forCellReuseIdentifier:@"contactCell"];
        self.datas = [[NSMutableArray alloc]init];
        [self.datas addObjectsFromArray:@[@"QQ",@"微信",@"新浪微博",@"Facebook",@"Instagram",@"Twitter"]];
        self.contacTableView = tableView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return currentrows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UMTContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    NSString *title = self.datas[indexPath.row];
    cell.labelTitle = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self footerView];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (currentrows <= 1) {
            return;
        }
        currentrows -= 1;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *str = [self.datas[indexPath.row] copy];
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.datas addObject:str];
        [self reloadTableView];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)footerView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(18, 0, UMTScreenWidth-20, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 160, 40)];
    label.text = @"添加其他联系方式...";
    label.textColor = [UIColor redColor];
    [view addSubview:imgView];
    [view addSubview:label];
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addContactCell)];
    [view addGestureRecognizer:tapgesture];
    return view;
}

- (void)addContactCell{
    if (currentrows >= self.datas.count) {
        return;
    }
    currentrows += 1;
    [self reloadTableView];
}

- (void)reloadTableView{
    self.contacTableView.height = kRowHeight*(currentrows+1);
    selfHeight = self.contacTableView.height;
    NSNumber *number = [NSNumber numberWithFloat:selfHeight];
    NSDictionary *dic = @{@"height":number};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableHeightChange" object:nil userInfo:dic];
    [self.contacTableView reloadData];
}

- (NSDictionary *)getContactInfo{
    NSArray *cells = self.contacTableView.visibleCells;
    NSInteger rows = cells.count;
    NSArray *titles = [self.datas subarrayWithRange:NSMakeRange(0, rows)];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < titles.count; i++) {
        UMTContactCell *cell = cells[i];
        [dic setObject:cell.textInput forKey:self.datas[i]];
    }
    return [dic copy];
}

@end
