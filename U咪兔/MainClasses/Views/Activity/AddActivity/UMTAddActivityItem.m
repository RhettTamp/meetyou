//
//  UMTAddActivityItem.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTAddActivityItem.h"

#define kItemHeight CGRectGetHeight(self.frame)/self.numberofItems

@interface UMTAddActivityItem ()

@property (nonatomic,strong) NSMutableArray *nameLabels;

@end

@implementation UMTAddActivityItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        self.layer.borderColor = kLineColor.CGColor;
        self.backgroundColor = [UIColor whiteColor];
        _numberofItems = 1;
        _itemNames = [NSArray array];
        _nameLabels = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.numberofItems > 1) {
        NSInteger lineCount = self.numberofItems - 1;
        CGFloat itemHeight = CGRectGetHeight(self.frame)/self.numberofItems;
        for (int i = 0; i < lineCount; i++) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = kLineColor;
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(self);
                make.height.mas_equalTo(1);
                make.top.mas_offset((i+1)*itemHeight);
            }];
        }
    }
    
    for (int i = 0; i < self.numberofItems; i++) {
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = kFont(17);
        nameLabel.textColor = [UIColor colorWithRGB:51 green:51 blue:51];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.height.mas_equalTo(kItemHeight);
            make.top.mas_offset(i*kItemHeight);
        }];
        [self.nameLabels addObject:nameLabel];
    }
}

- (void)setNumberofItems:(NSInteger)numberofItems{
    _numberofItems = numberofItems;
    [self layoutIfNeeded];
}

- (void)setItemNames:(NSMutableArray<NSString *> *)itemNames{
    _itemNames = itemNames;
    NSInteger count = itemNames.count;
    for (int i = 0; i < count; i++) {
        UILabel *label = self.nameLabels[i];
        label.text = itemNames[i];
    }
}

@end
