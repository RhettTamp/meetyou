//
//  UMTPublicInfoView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/4.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTPublicInfoView.h"
#import "UMTInfoItemView.h"

@interface UMTPublicInfoView()

@property (nonatomic,strong) UMTInfoItemView *nikNameItem;
@property (nonatomic,strong) UIView *sexItem;
@property (nonatomic,strong) UIView *labelItem;
@property (nonatomic,strong) UMTInfoItemView *sexInfo;
@property (nonatomic,strong) UMTInfoItemView *labelInfo;

@end

@implementation UMTPublicInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initNikNameItem];
        [self initSexItem];
        [self initLabelItem];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)initNikNameItem{
    self.nikNameItem = [[UMTInfoItemView alloc]init];
    self.nikNameItem.leftTitle = @"昵称";
    self.nikNameItem.rightPlaceholder = @"起一个昵称";
    [self addSubview:self.nikNameItem];
    [self.nikNameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(self.height/3);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nikNameItem.mas_bottom);
        make.left.mas_offset(10);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)initSexItem{
    UIView *view = [[UIView alloc]init];
    UMTInfoItemView *item = [[UMTInfoItemView alloc]init];
    item.rightPlaceholder = @"性别";
    item.leftTitle = @"请选择性别";
    item.inputTextField.enabled = NO;
    self.sex = item.textInput;
    self.sexInfo = item;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(sexItemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:item];
    [view addSubview:rightButton];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.mas_offset(-50);
        make.top.bottom.equalTo(view);
    }];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(view);
        make.width.height.mas_equalTo(30);
    }];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.nikNameItem.mas_bottom);
        make.height.mas_equalTo(self.height/3);
    }];
    self.sexItem = view;
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.mas_offset(10);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)initLabelItem{
    UIView *view = [[UIView alloc]init];
    UMTInfoItemView *item = [[UMTInfoItemView alloc]init];
    item.leftTitle = @"标签";
    item.rightPlaceholder = @"让其他人大概了解你";
    item.inputTextField.enabled = NO;
    self.label = item.textInput;
    self.labelInfo = item;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(labelItemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:item];
    [view addSubview:rightButton];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.mas_offset(-50);
        make.top.bottom.equalTo(view);
    }];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(view);
        make.width.height.mas_equalTo(30);
    }];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.sexItem.mas_bottom);
        make.height.mas_equalTo(self.height/3);
    }];
    self.sexItem = view;

}

- (void)sexItemButtonClicked{
    if (self.delegate) {
        [self.delegate sexItemClicked];
    }
}

- (void)labelItemButtonClicked{
    if (self.delegate) {
        [self.delegate labelItemClicked];
    }
}

- (NSString *)nikName{
    return self.nikNameItem.textInput;
}

- (void)setLabel:(NSString *)label{
    _label = label;
    self.labelInfo.textInput = label;
}

- (void)setSex:(NSString *)sex{
    _sex = sex;
    self.sexInfo.textInput = sex;
}

@end
