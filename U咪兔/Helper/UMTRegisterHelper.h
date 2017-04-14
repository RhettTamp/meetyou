//
//  UMTRegisterHelper.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTRegisterHelper : NSObject

@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,assign) int gender;
@property (nonatomic,strong) NSString *label;  //description
@property (nonatomic,strong) NSString *name;
//@property (nonatomic,strong) NSString *idcard;
@property (nonatomic,strong) NSString *school_id;
@property (nonatomic,strong) NSString *student_id;
@property (nonatomic,strong) NSString *QQ;
@property (nonatomic,strong) NSString *WeChat;
@property (nonatomic,strong) NSString *WeiBo;
@property (nonatomic,strong) NSString *Facebook;
@property (nonatomic,strong) NSString *Instagram;
@property (nonatomic,strong) NSString *Twitter;
@property (nonatomic,strong) NSData *photo;
@property (nonatomic,strong) NSData *photo2;

+ (instancetype)sharedHelper;

@end
