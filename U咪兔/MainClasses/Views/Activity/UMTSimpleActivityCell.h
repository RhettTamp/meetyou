//
//  UMTSimpleActivityCell.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMTSimpleActivityCell : UICollectionViewCell

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSArray *tags;
@property (nonatomic,strong) NSString *headUrl;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,assign) CGFloat persenCount;

- (void)reloadData;


@end
