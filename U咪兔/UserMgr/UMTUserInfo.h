//
//  UMTUserInfo.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/1.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTUserInfo : NSObject

@property (nonatomic,copy)NSString *userPhoneNumber;
@property (nonatomic,copy)NSString *userPassword;
@property (nonatomic,copy)NSString *userNickname;
@property (nonatomic,assign)BOOL isHaveRealInfomation;

@end
