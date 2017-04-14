//
//  UMTFindSchoolController.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBaseViewController.h"

typedef void(^getSchoolNameBlock)(NSDictionary *schoolInfo);

@interface UMTFindSchoolController : UMTBaseViewController

@property (nonatomic,copy)getSchoolNameBlock getSchoolBlock;

@end
