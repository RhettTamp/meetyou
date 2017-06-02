//
//  UMTShareViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/29.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTShareViewController.h"

@interface UMTShareViewController ()

@property (nonatomic,strong) UITextField *contentText;

@end

@implementation UMTShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享点滴";
    [self addBarButton];
    [self initUI];
}

- (void)initUI{
    self.contentText = [[UITextField alloc]init];
    _contentText.placeholder = @"写点儿活动点滴";
    [self.view addSubview:_contentText];
    [_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(8);
        make.height.mas_equalTo(200);
    }];
    
    UIView *addImageView = [[UIView alloc]init];
    addImageView.layer.borderColor = kLineColor.CGColor;
    addImageView.layer.borderWidth = 0.5;
    addImageView.layer.cornerRadius = 4;
    [self.view addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(_contentText.mas_bottom).offset(20);
    }];
    
    CGFloat imageWidth = (UMTScreenWidth-20-8*4)/3.0;
    UIButton *addImageButton = [[UIButton alloc]init];
    [addImageButton setImage:[UIImage imageNamed:@"UploadPhotoIcon"] forState:UIControlStateNormal];
    [addImageButton addTarget:self action:@selector(addImageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [addImageView addSubview:addImageButton];
    [addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(imageWidth);
        make.top.mas_offset(8);
        make.left.mas_offset(8);
        make.bottom.mas_offset(-8);
    }];
    
}

- (void)addImageButtonClicked{
    
}


- (void)addBarButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sharedButtonClicked)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)sharedButtonClicked{
    
}

@end
