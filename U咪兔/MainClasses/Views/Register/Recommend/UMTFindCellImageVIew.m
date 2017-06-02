//
//  UMTFindCellImageVIew.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/23.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTFindCellImageVIew.h"

@interface UMTFindCellImageVIew ()

@end

@implementation UMTFindCellImageVIew

- (instancetype)initWithImages:(NSArray *)images{
    if (self = [super init]) {
        CGFloat width = 88.0/375*UMTScreenWidth;
        NSInteger count = images.count;
        if (count > 3) {
            for (int i = 0; i < count; i ++) {
                UIImageView *im = [[UIImageView alloc]init];
                im.tag = i;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
                [im addGestureRecognizer:tap];
                im.image = images[i];
                [self addSubview:im];
                if (i == count-1) {
                    [im mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset((width+4)*(i%3));
                        make.top.mas_offset(i/3*(width+4));
                        make.width.and.height.mas_equalTo(width);
                        make.bottom.equalTo(self.mas_bottom);
                    }];
                }else if(i == 2){
                    [im mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset((width+4)*(i%3));
                        make.top.mas_offset(i/3*(width+4));
                        make.width.and.height.mas_equalTo(width);
                        make.right.equalTo(self.mas_right);
                    }];
                }else{
                    [im mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset((width+4)*(i%3));
                        make.top.mas_offset(i/3*(width+4));
                        make.width.and.height.mas_equalTo(width);
                    }];
                }
            }
            
        }else{
            for (int i = 0; i < count; i ++) {
                UIImageView *im = [[UIImageView alloc]init];
                im.tag = i;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
                [im addGestureRecognizer:tap];
                im.image = images[i];
                [self addSubview:im];
                if (i == count-1) {
                    [im mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset((width+4)*(i%3));
                        make.top.mas_offset(i/3*(width+4));
                        make.width.and.height.mas_equalTo(width);
                        make.bottom.equalTo(self.mas_bottom);
                        make.right.equalTo(self.mas_right);
                    }];
                }
                [im mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset((width+4)*(i%3));
                    make.top.mas_offset(i/3*(width+4));
                    make.width.and.height.mas_equalTo(width);
                    make.bottom.equalTo(self.mas_bottom);
                }];
            }
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = 88.0/375*UMTScreenWidth;
    NSInteger count = self.images.count;
    if (count > 3) {
        for (int i = 0; i < count; i ++) {
            UIImageView *im = [[UIImageView alloc]init];
            im.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
            [im addGestureRecognizer:tap];
            im.image = self.images[i];
            [self addSubview:im];
            if (i == count-1) {
                [im mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset((width+4)*(i%3));
                    make.top.mas_offset(i/3*(width+4));
                    make.width.and.height.mas_equalTo(width);
                    make.bottom.equalTo(self.mas_bottom);
                }];
            }else if(i == 2){
                [im mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset((width+4)*(i%3));
                    make.top.mas_offset(i/3*(width+4));
                    make.width.and.height.mas_equalTo(width);
                    make.right.equalTo(self.mas_right);
                }];
            }else{
                [im mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset((width+4)*(i%3));
                    make.top.mas_offset(i/3*(width+4));
                    make.width.and.height.mas_equalTo(width);
                }];
            }
        }
        
    }else{
        for (int i = 0; i < count; i ++) {
            UIImageView *im = [[UIImageView alloc]init];
            im.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
            [im addGestureRecognizer:tap];
            im.image = self.images[i];
            [self addSubview:im];
            if (i == count-1) {
                [im mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset((width+4)*(i%3));
                    make.top.mas_offset(i/3*(width+4));
                    make.width.and.height.mas_equalTo(width);
                    make.bottom.equalTo(self.mas_bottom);
                    make.right.equalTo(self.mas_right);
                }];
            }
            [im mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset((width+4)*(i%3));
                make.top.mas_offset(i/3*(width+4));
                make.width.and.height.mas_equalTo(width);
                make.bottom.equalTo(self.mas_bottom);
            }];
        }
    }
}

- (void)setImages:(NSArray *)images{
    _images = images;
    [self layoutSubviews];
}

- (void)imageTaped:(UITapGestureRecognizer *)tap{
    
}

@end
