//
//  UMTUserInfo.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/1.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTUserInfo : NSObject

@property (nonatomic,strong)NSString *userPhoneNumber;
@property (nonatomic,strong)NSString *userPassword;
@property (nonatomic,strong)NSString *userNickname;
@property (nonatomic,strong)NSString *userSex;
@property (nonatomic,strong)NSString *userLabel;
@property (nonatomic,strong)NSString *userQQNumber;
@property (nonatomic,strong)NSString *userWechatNumber;
@property (nonatomic,strong)NSString *userBaiduPostBar;
@property (nonatomic,strong)NSString *userFaceBook;
@property (nonatomic,strong)NSString *userInstagram;
@property (nonatomic,strong)NSString *userTitter;
@property (nonatomic,strong)NSDictionary *userContact;
@property (nonatomic,assign)BOOL isHaveRealInfomation;

@end
