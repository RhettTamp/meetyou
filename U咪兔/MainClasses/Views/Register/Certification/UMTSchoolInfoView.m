//
//  UMTSchoolInfoView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSchoolInfoView.h"
#import "UMTInfoItemView.h"

@interface UMTSchoolInfoView ()

@property (nonatomic,strong) UIView *schoolItemView;
@property (nonatomic,strong) UMTInfoItemView *schoolNameView;
@property (nonatomic,strong) UMTInfoItemView *nameView;
@property (nonatomic,strong) UMTInfoItemView *snoItemView;

@end

@implementation UMTSchoolInfoView
@synthesize schoolName = _schoolName;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSchoolItemView];
        [self initNameView];
        [self initSnoItemView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}



- (void)initSchoolItemView{
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = kLineColor;
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *view = [[UIView alloc]init];
    UMTInfoItemView *item = [[UMTInfoItemView alloc]init];
    item.rightPlaceholder = @"请选择学校";
    item.leftTitle = @"学校";
    item.inputTextField.enabled = NO;
    self.schoolName = item.textInput;
    self.schoolNameView = item;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(schoolItemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
        make.top.equalTo(self);
        make.height.mas_equalTo(self.height/3);
    }];
    self.schoolItemView = view;
    
    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(schoolItemButtonClicked)];
    [clearView addGestureRecognizer:tap];
    [self addSubview:clearView];
    [clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(100);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(self.height/3);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.mas_offset(15);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)initNameView{
    UMTInfoItemView *view = [[UMTInfoItemView alloc]init];
    view.leftTitle = @"姓名";
    view.rightPlaceholder = @"请输入真实姓名";
    self.userName = view.textInput;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.schoolItemView.mas_bottom);
        make.height.mas_equalTo(self.height/3);
    }];
    self.nameView = view;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(view.mas_bottom);
    }];
}

- (void)initSnoItemView{
    self.snoItemView = [[UMTInfoItemView alloc]init];
    self.snoItemView.leftTitle = @"学号";
    self.snoItemView.rightPlaceholder = @"请输入学号";
    self.userSchoolId = self.snoItemView.textInput;
    [self addSubview:self.snoItemView];
    [self.snoItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.nameView.mas_bottom);
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

- (void)setSchoolName:(NSString *)schoolName{
    _schoolName = schoolName;
    self.schoolNameView.textInput = schoolName;
}

- (NSString *)schoolName{
    return self.schoolNameView.textInput;
}

- (NSString *)userName{
    return self.nameView.textInput;
}

- (NSString *)userSchoolId{
    return self.snoItemView.textInput;
}



- (void)schoolItemButtonClicked{
    if (self.delegate) {
        [self.delegate chooseSchool];
    }
}



@end
