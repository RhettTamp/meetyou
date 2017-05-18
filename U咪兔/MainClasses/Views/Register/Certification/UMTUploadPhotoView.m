//
//  UMTUploadPhotoView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTUploadPhotoView.h"

@interface UMTUploadPhotoView ()

@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)UIImageView *firstImageView;
@property (nonatomic,strong)UIImageView *secondImageView;

@end

@implementation UMTUploadPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.addButton = [[UIButton alloc]init];
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"UploadPhotoIcon"] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(uploadPhotoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(9);
            make.width.and.height.mas_equalTo(79);
        }];
    }
    return self;
}

- (void)layoutSubviews{
    
}

- (void)addImage:(UIImage *)imge index:(NSInteger)index{
    UIImageView *imagView = [[UIImageView alloc]init];
    imagView.tag = 100 + index;
    imagView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
    [imagView addGestureRecognizer:tap];
    imagView.image = imge;
    [self addSubview:imagView];
    if (index == 1) {
        self.firstImageView = imagView;
    }else if(index == 2){
        self.secondImageView = imagView;
    }
    [imagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*index+79*(index-1));
        make.top.mas_offset(9);
        make.width.and.height.mas_equalTo(79);
    }];

    [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(79*index+15*(index+1));
        make.top.mas_offset(9);
        make.width.and.height.mas_equalTo(79);
    }];
    [self layoutIfNeeded];
}

- (void)deleteImageView:(NSInteger)index imageCount:(NSInteger)imgCount{
    
    if (index == 1) {
        [self.firstImageView removeFromSuperview];
        if (self.secondImageView&&self.secondImageView.image) {
            [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15*index+79*(index-1));
                make.top.mas_offset(9);
                make.width.and.height.mas_equalTo(79);
            }];
        }
    }else if (index == 2){
        [self.secondImageView removeFromSuperview];
        self.secondImageView = nil;
    }
    [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(79*imgCount+15*(imgCount+1));
        make.top.mas_offset(9);
        make.width.and.height.mas_equalTo(79);
    }];
    
}

- (void)changeImage:(UIImage *)image index:(NSInteger)index{
    if (index == 1) {
        self.firstImageView.image = image;
    }else if (index == 2){
        self.secondImageView.image = image;
    }
}

- (void)imageTaped:(UITapGestureRecognizer *)reg{
    if (self.delegate) {
        [self.delegate imageTaped:(UIImageView *)reg.view index:reg.view.tag-100];
    }
}

- (void)uploadPhotoButtonClicked{
    if (self.buttonClickedblock) {
        self.buttonClickedblock();
    }
}

- (NSArray *)pictures{
    NSMutableArray *arr = [NSMutableArray array];
    if (self.firstImageView.image) {
        [arr addObject:self.firstImageView.image];
    }
    if (self.secondImageView.image) {
        [arr addObject:self.secondImageView.image];
    }
    return [arr copy];
}

@end
