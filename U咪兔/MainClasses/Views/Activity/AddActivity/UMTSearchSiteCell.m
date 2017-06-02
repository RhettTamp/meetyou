//
//  UMTSearchSiteCell.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/22.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSearchSiteCell.h"

@interface UMTSearchSiteCell ()

@property (nonatomic,strong) UILabel *siteLabel;
@property (nonatomic,strong) UILabel *detaiLabel;

@end

@implementation UMTSearchSiteCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *siteImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"site"]];
        [self addSubview:siteImage];
        [siteImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(18);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(14.4);
            make.centerY.equalTo(self);
        }];
        
        _siteLabel = [[UILabel alloc]init];
        _siteLabel.font = kFont(15);
        _siteLabel.textColor = Hex(0x262626);
        [self addSubview:_siteLabel];
        [_siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(siteImage.mas_right).offset(18);
            make.top.offset(10);
        }];
        _detaiLabel = [[UILabel alloc]init];
        _detaiLabel.font = kFont(11);
        _detaiLabel.textColor = Hex(0xbbbbbb);
        [self addSubview:_detaiLabel];
        [_detaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_siteLabel.mas_left);
            make.top.equalTo(_siteLabel.mas_bottom).offset(1);
        }];
    }
    return self;
}

- (void)setSite:(NSString *)site{
    self.siteLabel.text = site;
    _site = site;
}

- (void)setDetailSite:(NSString *)detailSite{
    self.detaiLabel.text = detailSite;
    _detailSite = detailSite;
}


@end
