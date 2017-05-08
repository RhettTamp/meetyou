//
//  UMTUserMgr.m
//  U咪兔
//
//  Created by 谭培 on 2017/3/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTUserMgr.h"



@interface UMTUserMgr ()<NSCoding>


@end

@implementation UMTUserMgr

static UMTUserMgr *sharedMgr = nil;

+ (instancetype)sharedMgr{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMgr = [[UMTUserMgr alloc]init];
        sharedMgr.userInfo = [[UMTUserInfo alloc]init];
        sharedMgr.userRealInfo = [[UMTUserRealInfo alloc]init];
    });
    return sharedMgr;
}

- (void)removeAllUserInfomation{
    self.userInfo = nil;
    self.userRealInfo = nil;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:[UMTUserMgr sharedMgr]];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:@"UMTUserInfomationKey"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userInfo forKey:@"USERINFO"];
//    [aCoder encodeObject:self.userRealInfo forKey:@"USERREALINFO"];
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
//        self.userRealInfo = [aDecoder decodeObjectForKey:@"USERREALINFO"];
        self.userInfo = [aDecoder decodeObjectForKey:@"USERINFO"];
        
    }
    return self;
}

@end
