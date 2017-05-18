//
//  UMTSiteViewController.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBaseViewController.h"

typedef void (^UMTSiteBlock)(NSString *site);

@interface UMTSiteViewController : UMTBaseViewController

@property (nonatomic,copy) UMTSiteBlock block;

@end
