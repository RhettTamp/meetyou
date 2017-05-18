//
//  UMTJoinActivityRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/15.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTJoinActivityRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTJoinActivityRequest

+ (void)JoinActivityWithActivityId:(int)activityId CompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    [[UMTBaseRequest sharedRequest] requestWithType:UMTRequestTypePost params:nil andUrlPath:[NSString stringWithFormat:@"activity/%d/participants",activityId] completionBlock:^(id response, NSString *message, NSError *erro) {
        if (erro) {
            completionBlock(erro,nil);
        }else{
            completionBlock(nil,response);
        }
    }];
}


@end
