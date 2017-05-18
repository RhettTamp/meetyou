//
//  UMTIssurActivityRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/11.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTIssurActivityRequest : NSObject

+ (void)IssueActivityWithParams:(id)params AndCompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
