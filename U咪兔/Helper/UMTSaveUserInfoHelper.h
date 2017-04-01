//
//  UMTSaveUserInfoHelper.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/1.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTSaveUserInfoHelper : NSObject
+ (void)saveUserInfoToDisk;

+ (UMTUserMgr *)getUserInfoFromDisk;

@end
