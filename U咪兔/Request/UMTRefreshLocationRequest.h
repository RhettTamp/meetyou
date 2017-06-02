//
//  UMTRefreshLocationRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTRefreshLocationRequest : NSObject

+ (void)postLovationWithLng:(NSString *)lng lat:(NSString *)lat CompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
