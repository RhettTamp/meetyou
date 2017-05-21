//
//  UMTMeHeadView.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/19.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTMeHeadView.h"

@interface UMTMeHeadView ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) UIImageView *headImageView;

@end

@implementation UMTMeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.image = _headImage;
    CGFloat imageWidth = self.width;
    headImageView.layer.cornerRadius = imageWidth/2;
    headImageView.layer.borderColor = Hex(0xececec).CGColor;
    headImageView.layer.borderWidth = 6;
    [self addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(imageWidth);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    self.headImageView = headImageView;
    
    _shapeLayer = [[CAShapeLayer alloc]init];
    self.shapeLayer.fillColor = nil;
    _shapeLayer.frame = self.bounds;
    [self.layer addSublayer:_shapeLayer];
    self.shapeLayer.strokeColor = kCommonGreenColor.CGColor;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineWidth = 6;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = self.progress*M_PI*2+startAngle;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:self.width/2 startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.shapeLayer.path = path.CGPath;
}


@end
