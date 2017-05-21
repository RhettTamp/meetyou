//
//  UMTTabBar.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/19.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTTabBar.h"

@interface UMTTabBar ()

@property (nonatomic,strong)UIImageView *tabImage;
@property (nonatomic,strong)NSArray *datalist;
@property (nonatomic,strong)UIButton *lastItem;
@property (nonatomic,strong)UIButton *addButton;

@end



@implementation UMTTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addItem];
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.top.equalTo(self.mas_top);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)addItem{
    [self addSubview:self.tabImage];
    float itemWidth = UMTScreenWidth/self.datalist.count;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, CGRectGetMaxY(self.bounds))];
        [button setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"selected%@",self.datalist[i]]] forState:UIControlStateSelected];
        button.tag = UMTItemActivity+i;
        if (i == 2) {
            button.tag = UMTItemAddActivity;
        }
        if (i > 2) {
            button.tag = UMTItemActivity+i-1;
        }
        [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.lastItem = button;
        }
        [self addSubview:button];
    }
}

- (void)itemClicked:(UIButton *)button{
    NSInteger index = button.tag;
    if (self.delegate) {
        [self.delegate tabBar:self Clickeditem:index];
    }
    if (index == UMTItemAddActivity) {
        return;
    }
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (UIImageView *)tabImage{
    if (!_tabImage) {
        
    }
    return _tabImage;
}

- (NSArray *)datalist{
    if (!_datalist) {
        _datalist = @[@"home",@"discover",@"PlusButton",@"messege",@"user"];
    }
    return _datalist;
}



@end
