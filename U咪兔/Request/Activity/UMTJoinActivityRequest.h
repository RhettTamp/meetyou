//
//  UMTJoinActivityRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/15.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTJoinActivityRequest : NSObject

+ (void)JoinActivityWithActivityId:(int)activityId CompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
