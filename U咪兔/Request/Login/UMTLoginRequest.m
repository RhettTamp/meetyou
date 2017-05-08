//
//  UMTLoginRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTLoginRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTLoginRequest

+ (void)getUserTokenWithUserPhone:(NSString *)userPhone andPassword:(NSString *)password andCompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    NSDictionary *params = @{@"phone":userPhone,
                             @"password":password};
    [[UMTBaseRequest sharedRequest] requestWithType:UMTRequestTypePost params:params andUrlPath:@"auth" completionBlock:^(id response, NSString *message, NSError *erro) {
        if (erro) {
            if (completionBlock) {
                completionBlock(erro,nil);
            }
            
        }else{
            if (completionBlock) {
                completionBlock(nil,response);
            }
        }
    }];
}

@end
