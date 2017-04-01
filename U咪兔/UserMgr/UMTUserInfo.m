//
//  UMTUserInfo.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/1.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTUserInfo.h"

@interface UMTUserInfo ()

@end

@implementation UMTUserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userNickname forKey:@"USERNICKNAME"];
    [aCoder encodeObject:self.userPassword forKey:@"USERPASSWORD"];
    [aCoder encodeObject:self.userPhoneNumber forKey:@"USERPHONENUMBER"];
    [aCoder encodeBool:self.isHaveRealInfomation forKey:@"ISHAVEREALINFOMATION"];
}



- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userNickname = [aDecoder decodeObjectForKey:@"USERNICKNAME"];
        self.userPassword = [aDecoder decodeObjectForKey:@"USERPASSWORD"];
        self.userPassword = [aDecoder decodeObjectForKey:@"USERPHONENUMBER"];
        self.isHaveRealInfomation = [aDecoder decodeBoolForKey:@"ISHAVEREALINFOMATION"];
    }
    return self;
}


@end
