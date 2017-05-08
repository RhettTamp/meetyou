//
//  UMTAddActivityNavBar.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol UMTAddActivityNavBarDelegate <NSObject>

- (void)exitButtonClicked;

- (void)rightButtonClicked;

@end

@interface UMTAddActivityNavBar : UIView

@property (nonatomic,weak) id <UMTAddActivityNavBarDelegate> delegate;

@end
