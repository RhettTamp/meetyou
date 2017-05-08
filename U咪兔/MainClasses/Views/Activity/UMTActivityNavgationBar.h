//
//  UMTActivityNavgationBar.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/3.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UMTActivityNavgationBarIndex){
    UMTActivityNavgationBarDetailed = 100, //默认
    UMTActivityNavgationBarSimple,
};

typedef void(^UMTActivityNavgationBarBlock)(UMTActivityNavgationBarIndex index);

@interface UMTActivityNavgationBar : UIView

@property (nonatomic,copy) UMTActivityNavgationBarBlock block;

- (void)selectedAtIndex:(UMTActivityNavgationBarIndex)index;

@end
