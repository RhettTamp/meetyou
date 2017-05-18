//
//  UMTActivityTypeView.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/14.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickedBlock)(UIButton *);

@interface UMTActivityTypeView : UIView

@property (nonatomic,strong) UIImage *buttonImage;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,copy) buttonClickedBlock block;

@end
