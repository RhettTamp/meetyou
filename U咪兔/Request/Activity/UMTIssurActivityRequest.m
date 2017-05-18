//
//  UMTIssurActivityRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/11.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTIssurActivityRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTIssurActivityRequest

+ (void)IssueActivityWithParams:(id)params AndCompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    [params removeObjectForKey:@"id"];
    [params removeObjectForKey:@"0"];
    [params removeObjectForKey:@"people_number_join"];
//    [params removeObject:@"status"];
    UMTBaseRequest *shardRequest = [UMTBaseRequest sharedRequest];
    [shardRequest requestWithType:UMTRequestTypePost params:params andUrlPath:@"activity" completionBlock:^(id response, NSString *message, NSError *erro) {
        if (erro) {
            completionBlock(erro,nil);
        }else{
            completionBlock(nil,response);
        }
    }];
}

@end
