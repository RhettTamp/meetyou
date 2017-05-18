//
//  UMTGetActivityListRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTGetActivityListRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTGetActivityListRequest

+ (void)GetActivityListWithPage:(NSInteger)page CompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    UMTBaseRequest *sharedRequest = [UMTBaseRequest sharedRequest];
    NSDictionary *params = @{@"page":[NSNumber numberWithInteger:page],@"type":@1};
    [sharedRequest requestWithType:UMTRequestTypeGet params:params andUrlPath:@"activity" completionBlock:^(id response, NSString *message, NSError *erro) {
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
