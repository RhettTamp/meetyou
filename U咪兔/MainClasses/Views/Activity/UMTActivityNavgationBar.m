//
//  UMTActivityNavgationBar.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTActivityNavgationBar.h"

#define kButtonWidth 100

@interface UMTActivityNavgationBar ()

@property (nonatomic,strong) UIButton *lastSelectedButton;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIButton *detailButton;
@property (nonatomic,strong) UIButton *simpleButton;

@end

@implementation UMTActivityNavgationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addNavgationItem];
    }
    return self;
}

- (void)addNavgationItem{
    UIButton *leftBbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-kButtonWidth, 5, kButtonWidth, CGRectGetHeight(self.frame)-15)];
    [leftBbtn setTitle:@"精心计划" forState:UIControlStateNormal];
    leftBbtn.titleLabel.font = kFont(18);
    [leftBbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBbtn.tag = UMTActivityNavgationBarDetailed;
    [leftBbtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBbtn.selected = YES;
    self.lastSelectedButton = leftBbtn;
    [self addSubview:leftBbtn];
    self.detailButton = leftBbtn;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2, 5, kButtonWidth, CGRectGetHeight(self.frame)-15)];
    [rightBtn setTitle:@"说走就走" forState:UIControlStateNormal];
    rightBtn.tag = UMTActivityNavgationBarSimple;
    [rightBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = kFont(18);
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:rightBtn];
    self.simpleButton = rightBtn;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-5, kButtonWidth-25, 5)];
    lineView.backgroundColor = kCommonGreenColor;
    lineView.centerX = leftBbtn.centerX;
    self.lineView = lineView;
    [self addSubview:lineView];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-.5, CGRectGetWidth(self.frame), 0.5)];
    bottomLine.backgroundColor = kLineColor;
    [self addSubview:bottomLine];
}

- (void)buttonClicked:(UIButton *)button{
    self.lineView.centerX = button.centerX;
    if (self.lastSelectedButton) {
        self.lastSelectedButton.titleLabel.font = kFont(18);
    }
    button.selected = YES;
    button.titleLabel.font = kFont(20);
    self.lastSelectedButton = button;
    if (self.block) {
        self.block(button.tag);
    }
}

- (void)selectedAtIndex:(UMTActivityNavgationBarIndex)index{
    if (index == UMTActivityNavgationBarDetailed) {
        [self buttonClicked:self.detailButton];
    }else{
        [self buttonClicked:self.simpleButton];
    }
}

@end
