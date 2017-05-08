//
//  UMTTabBar.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/19.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UMTTabItem){
    UMTItemAddActivity = 1000,
    UMTItemActivity = 100,  //活动
    UMTItemFind,   //发现
    UMTItemMessage,   //消息
    UMTItemMe,   //我的
};

@class UMTTabBar;

@protocol UMTTabBarDelegate <NSObject>

- (void)tabBar:(UMTTabBar *)tabBar Clickeditem:(NSInteger)index;

@end

@interface UMTTabBar : UIView

@property (nonatomic,weak) id<UMTTabBarDelegate>delegate;

@end
