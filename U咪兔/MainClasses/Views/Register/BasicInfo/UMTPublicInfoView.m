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
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = kLineColor;
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    self.nikNameItem = [[UMTInfoItemView alloc]init];
    self.nikNameItem.leftTitle = @"昵称";
    self.nikNameItem.rightPlaceholder = @"起一个昵称";
    self.nikName = self.nikNameItem.textInput;
    [self addSubview:self.nikNameItem];
    [self.nikNameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(self.height/3);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = Hex(0xd5d4d8);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nikNameItem.mas_bottom);
        make.left.mas_offset(15);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)initSexItem{
    UIView *view = [[UIView alloc]init];
    UMTInfoItemView *item = [[UMTInfoItemView alloc]init];
    item.rightPlaceholder = @"请选择性别";
    item.leftTitle = @"性别";
    item.inputTextField.enabled = NO;
    self.sex = item.textInput;
    self.sexInfo = item;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
    [view addSubview:item];
    [view addSubview:rightButton];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.mas_offset(-50);
        make.top.bottom.equalTo(view);
    }];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.nikNameItem.mas_bottom);
        make.height.mas_equalTo(self.height/3);
    }];
    self.sexItem = view;
    
    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexItemButtonClicked)];
    [clearView addGestureRecognizer:tap];
    [self addSubview:clearView];
    [clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(100);
        make.right.equalTo(self);
        make.top.equalTo(self.nikNameItem.mas_bottom);
        make.height.mas_equalTo(self.height/3);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = Hex(0xd5d4d8);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.mas_offset(15);
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
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
    [view addSubview:item];
    [view addSubview:rightButton];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.mas_offset(-25);
        make.top.bottom.equalTo(view);
    }];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.sexItem.mas_bottom);
        make.height.mas_equalTo(self.height/3);
    }];
    self.sexItem = view;

    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelItemButtonClicked)];
    [clearView addGestureRecognizer:tap];
    [self addSubview:clearView];
    [clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(100);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(self.height/3);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = kLineColor;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
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
