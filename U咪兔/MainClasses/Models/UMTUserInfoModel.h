//
//  UMTUserInfoModel.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTUserInfoModel : NSObject

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *headImgUrl;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,assign) NSInteger character_value;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,strong) NSArray *followers;
@property (nonatomic,strong) NSString *userDescription;
@property (nonatomic,strong) NSString *school;

@end
