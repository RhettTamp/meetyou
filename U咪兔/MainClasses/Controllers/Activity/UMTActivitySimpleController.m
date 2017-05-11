//
//  UMTActivitySimpleController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTActivitySimpleController.h"
#import "UMTSimpleActivityCell.h"
#import "UMTCheckSimpleController.h"
#import "UMTGetSimpleActivityListRequest.h"
#import "UMTDetailActivityCellModel.h"
#import "UMTUserInfoModel.h"

#define kCellWidth (UMTScreenWidth-29)/2

@interface UMTActivitySimpleController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation UMTActivitySimpleController

static NSString *const cellId = @"UMTSimpleActivityCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initCollectionView];
    self.datalist = [NSMutableArray array];
    [self reloadData];
}

- (void)reloadData{
    [UMTGetSimpleActivityListRequest GetActivityListWithCompletionBlock:^(NSError *erro, id response) {
        if (erro) {
            NSLog(@"%@",erro);
        }else{
            NSArray *datas = response[@"data"];
            for (int i = 0; i < datas.count; i++) {
                UMTDetailActivityCellModel *model = [UMTDetailActivityCellModel yy_modelWithJSON:datas[i]];
                [self.datalist addObject:model];
                
            }
            [self.collectionView reloadData];
        }
    }];
}

- (void)initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 9;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self.view);
    }];
    [collectionView registerClass:[UMTSimpleActivityCell class] forCellWithReuseIdentifier:cellId];
    self.collectionView = collectionView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UMTSimpleActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    UMTDetailActivityCellModel *model = self.datalist[indexPath.row];
//    cell.title = model.title;
//    cell.content = model.content;
//    cell.endTime = model.endTime;
//    cell.persenCount = model.peopleCount;
//    cell.site = model.site;
//    cell.tags = model.tags;
//    cell.headUrl = model.creator.headImgUrl;
//    [cell reloadData];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kCellWidth, 340);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UMTCheckSimpleController *checkSimpleVC = [[UMTCheckSimpleController alloc]init];
    [self.navigationController pushViewController:checkSimpleVC animated:YES];
}

@end
