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
@property (nonatomic,strong) UMTInfoItemView *snoItemView;

@end

@implementation UMTSchoolInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSchoolItemView];
        [self initSnoItemView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}



- (void)initSchoolItemView{
    UIView *view = [[UIView alloc]init];
    UMTInfoItemView *item = [[UMTInfoItemView alloc]init];
    item.rightPlaceholder = @"请选择学校";
    item.leftTitle = @"学校";
    item.inputTextField.enabled = NO;
    self.schoolItemView = item;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton addTarget:self action:@selector(schoolItemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
        make.top.equalTo(self);
        make.height.mas_equalTo(self.height/2);
    }];
    self.schoolItemView = view;
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

- (void)initSnoItemView{
    self.snoItemView = [[UMTInfoItemView alloc]init];
    self.snoItemView.leftTitle = @"学号";
    self.snoItemView.rightPlaceholder = @"请输入学号";
    [self addSubview:self.snoItemView];
    [self.snoItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.schoolItemView.mas_bottom);
        make.height.mas_equalTo(self.height/2);
    }];
    
}

- (void)setSchoolName:(NSString *)schoolName{
    self.schoolName = schoolName;
    self.schoolNameView.textInput = schoolName;
}

- (NSString *)schoolName{
    return self.schoolNameView.textInput;
}

- (void)schoolItemButtonClicked{
    if (self.delegate) {
        [self.delegate chooseSchool];
    }
}



@end
