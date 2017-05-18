//
//  UMTTagChooseController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTTagChooseController.h"
#import "UMTSearchTagRequest.h"
#import "UMTTagCell.h"
#import "UIImage+Extension.h"

@interface UMTTagChooseController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *searchTags;
@property (nonatomic,strong) NSMutableArray *choicedTags;
@property (nonatomic,strong) UITableView *searchTable;
@property (nonatomic,strong) NSString *searchText;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation UMTTagChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.searchController.active = NO;
}

- (void)initUI{
    self.title = @"选择标签";
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightBar;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self addCollectionView];
    [self initSearchView];
}

- (void)initSearchView{
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.obscuresBackgroundDuringPresentation = NO;
    searchController.definesPresentationContext = YES;
    searchController.searchResultsUpdater = self;
    searchController.delegate = self;
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, UMTScreenWidth-52, 44)];
    
    UISearchBar *searchBar = searchController.searchBar;
    searchBar.backgroundColor = [UIColor whiteColor];
    [searchBar setBackgroundImage:[UIImage imageWithColor:kCommonbackColor size:searchBar.frame.size]];
    UITextField *searchField= [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = kLineColor;
    searchBar.showsCancelButton = NO;
    searchBar.delegate = self;
    [searchView addSubview:searchBar];
    [self.view addSubview:searchView];
    [searchBar sizeToFit];

    UIButton *addButton = [[UIButton alloc]init];
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-14);
        make.height.and.width.mas_equalTo(24);
        make.centerY.equalTo(searchView);
    }];
    self.addButton = addButton;

    self.searchController = searchController;
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(searchView.mas_bottom).offset(10);
    }];
    tableView.alpha = 0;
    self.searchTable = tableView;
    
    self.searchTags = [NSMutableArray array];
    self.choicedTags = [NSMutableArray array];
}

- (void)addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = kCommonbackColor;
    [collectionView registerClass:[UMTTagCell class] forCellWithReuseIdentifier:@"tagCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.top.mas_offset(44);
    }];
    self.collectionView = collectionView;
}

- (void)rightButtonClicked{
    if (!self.choicedTags||self.choicedTags.count == 0) {
        return;
    }
    self.block(self.choicedTags);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.choicedTags.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UMTTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tagCell" forIndexPath:indexPath];
    cell.tagName = self.choicedTags[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((UMTScreenWidth-30)/2, 44);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark -- search

- (void)willPresentSearchController:(UISearchController *)searchController{
    if (self.searchTable.alpha == 0) {
        self.searchTable.alpha = 1;
    }
    self.searchText = searchController.searchBar.text;
    [self requestForData];
}

- (void)didDismissSearchController:(UISearchController *)searchController{
    self.searchTable.alpha = 0;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    self.searchText = searchController.searchBar.text;
    [self requestForData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchText = searchBar.text;
    [self requestForData];
}



#pragma -- tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchTags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.searchTags[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.choicedTags addObject:self.searchTags[indexPath.row]];
    self.searchController.active = NO;
    [self.collectionView reloadData];
}

- (void)requestForData{
    [UMTSearchTagRequest searchTagWithKeyValue:self.searchText andCompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            NSMutableArray *tagArray = [NSMutableArray array];
            NSArray *datas = response[@"tags"];
            if (datas && datas.count>0) {
                for (NSDictionary *dic in datas) {
                    [tagArray addObject:dic[@"name"]];
                }
                self.searchTags = tagArray;
                [self.searchTable reloadData];
            }
            
            
        }
    }];
}

- (void)addButtonClicked{
    if (!self.searchController.searchBar.text || self.searchController.searchBar.text.length == 0) {
        return;
    }
    [self.choicedTags addObject:self.searchController.searchBar.text];
    self.searchController.active = NO;
    [self.collectionView reloadData];
}

@end



