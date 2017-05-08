//
//  UMTSiteView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSiteView.h"

@interface UMTSiteView ()

@property (nonatomic,strong) UILabel *siteLabel;

@end

@implementation UMTSiteView
@synthesize site = _site;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 4;
        UIImageView *siteImg = [[UIImageView alloc]init];
        siteImg.image = [UIImage imageNamed:@"Pin"];
        [self addSubview:siteImg];
        [siteImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(3);
            make.centerY.equalTo(self);
            make.width.and.height.mas_equalTo(16);
        }];
        UILabel *siteLabel = [[UILabel alloc]init];
        siteLabel.font = kFont(14);
        [siteLabel sizeToFit];
        [self addSubview:siteLabel];
        [siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(siteImg.mas_right).offset(3);
            make.right.equalTo(self.mas_right).offset(-2);
            make.centerY.equalTo(self);
        }];
        self.siteLabel = siteLabel;
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self.siteLabel sizeToFit];
//    [self layoutIfNeeded];
//}

- (void)setSite:(NSString *)site{
    _site = site;
    self.siteLabel.text = site;
}

- (NSString *)site{
    return self.siteLabel.text;
}

@end
