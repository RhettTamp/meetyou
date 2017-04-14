//
//  UMTInfoContactController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTInfoContactController.h"
#import "UMTContactCell.h"
#define kRowHeight 44

@interface UMTInfoContactController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contacTableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableDictionary *allContacts;

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
        self.allContacts = [NSMutableDictionary dictionaryWithDictionary:@{@"QQ":@"QQ",@"微信":@"WeChat",@"新浪微博":@"WeiBo",@"Facebook":@"Facebook",@"Instagram":@"Instagram",@"Twitter":@"Twitter"}];
        self.datas = [NSMutableArray arrayWithArray:[self.allContacts allKeys]];
        self.contacTableView = tableView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return currentrows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kRowHeight;
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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, kRowHeight)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 11, 22, 22)];
    imgView.image = [UIImage imageNamed:@"Contact_Add"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(46, 0, 160, kRowHeight)];
    label.text = @"添加其他联系方式...";
    label.textColor = kCommonGreenColor;
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
        NSString *text = cell.textInput;
        if (text && text.length > 0) {
            [dic setObject:text forKey:self.allContacts[titles[i]]];
        }
    }
    return [dic copy];
}

@end
