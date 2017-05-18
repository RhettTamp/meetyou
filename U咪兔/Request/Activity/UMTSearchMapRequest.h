//
//  UMTSearchMapRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/16.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTSearchMapRequest : NSObject

+ (void)SearchMapWithSite:(NSString *)site CompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
