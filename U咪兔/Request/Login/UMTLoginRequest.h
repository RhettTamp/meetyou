//
//  UMTLoginRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTLoginRequest : NSObject

+ (void)getUserTokenWithUserPhone:(NSString *)userPhone andPassword:(NSString *)password andCompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
