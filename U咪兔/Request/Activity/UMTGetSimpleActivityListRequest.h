//
//  UMTGetSimpleActivityListRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTGetSimpleActivityListRequest : NSObject

+ (void)GetActivityListWithCompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
