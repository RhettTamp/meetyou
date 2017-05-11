//
//  UMTCircleView.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/21.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTCircleView.h"

@interface UMTCircleView ()

@property (nonatomic,strong)CAShapeLayer *shapeLayer;

@end

@implementation UMTCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius circleWidth:(CGFloat)width Progress:(CGFloat)progress{
    if (self = [super init]) {
        self.radius = radius;
        self.circleWidth = width;
        self.progress = progress;
    }
    return self;
}

//- (void)drawRect:(CGRect)rect{
//    
//    _shapeLayer = [[CAShapeLayer alloc]init];
//    self.shapeLayer.fillColor = nil;
//    _shapeLayer.frame = self.bounds;
//    [self.layer addSublayer:_shapeLayer];
//    self.circleCocor = [UIColor redColor];
//    self.shapeLayer.strokeColor = self.circleCocor.CGColor;
//    self.shapeLayer.lineCap = kCALineCapRound;
//    self.shapeLayer.lineWidth = self.circleWidth;
//    CGFloat startAngle = -M_PI_2;
//    CGFloat endAngle = self.progress*M_PI*2+startAngle;
//    CGPoint center = CGPointMake(self.width/2, self.height/2);
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:YES];
//    self.shapeLayer.path = path.CGPath;
//}
//两个方法性能一样？
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    CAShapeLayer *grayLayer = [[CAShapeLayer alloc]init];
    grayLayer.fillColor = nil;
    grayLayer.frame = self.bounds;
    [self.layer addSublayer:grayLayer];
    grayLayer.strokeColor = Hex(0xF3F3F3).CGColor;
    grayLayer.lineCap = kCALineCapRound;
    grayLayer.lineWidth = self.circleWidth;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:YES];
    grayLayer.path = circlePath.CGPath;
    
    _shapeLayer = [[CAShapeLayer alloc]init];
    self.shapeLayer.fillColor = nil;
    _shapeLayer.frame = self.bounds;
    [self.layer addSublayer:_shapeLayer];
    
    UIColor *color = self.circleCocor?self.circleCocor:[UIColor blackColor];
    self.shapeLayer.strokeColor = color.CGColor;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineWidth = self.circleWidth;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = self.progress*M_PI*2+startAngle;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.shapeLayer.path = path.CGPath;
    
    
}

@end
