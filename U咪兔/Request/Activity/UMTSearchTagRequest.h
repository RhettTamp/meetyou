//
//  UMTSearchTagRequest.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/11.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMTSearchTagRequest : NSObject

+ (void)searchTagWithKeyValue:(NSString *)key andCompletionBlock:(void(^)(NSError *erro, id response))completionBlock;

@end
