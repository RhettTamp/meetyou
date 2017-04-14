//
//  UMTRefreshToken.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTRefreshToken : NSObject

+ (void)refreshTokenWithOldToken:(NSString *)oldToken;

@end
