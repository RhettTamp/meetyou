//
//  UMTSaveUserInfoHelper.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/1.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSaveUserInfoHelper.h"

@implementation UMTSaveUserInfoHelper

+ (void)saveUserInfoToDisk{
    UMTUserMgr *sharedMgr = [UMTUserMgr sharedMgr];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sharedMgr];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UMTUserInfomationKey"];
}

+ (UMTUserMgr *)getUserInfoFromDisk{
    UMTUserMgr *sharedMgr = [UMTUserMgr sharedMgr];
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"UMTUserInfomationKey"];
    if (data) {
        sharedMgr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return sharedMgr;
}

@end
