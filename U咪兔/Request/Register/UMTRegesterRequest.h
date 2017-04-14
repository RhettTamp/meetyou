//
//  UMTRegesterRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UMTRegesterRequest : NSObject

+ (void)RegisterWithCompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
