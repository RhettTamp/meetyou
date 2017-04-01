//
//  UMTUserMgr.h
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMTUserInfo.h"
#import "UMTUserRealInfo.h"

@interface UMTUserMgr : NSObject

+ (instancetype)sharedMgr;

@property (nonatomic,strong) UMTUserInfo *userInfo;
@property (nonatomic,strong) UMTUserRealInfo *userRealInfo;

- (void)removeAllUserInfomation;

@end
