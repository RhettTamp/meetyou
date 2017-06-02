//
//  UMTRefreshLocationRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/31.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRefreshLocationRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTRefreshLocationRequest

+ (void)postLovationWithLng:(NSString *)lng lat:(NSString *)lat CompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    NSDictionary *dic = @{@"lng":lng,@"lat":lat};
    [[UMTBaseRequest sharedRequest] requestWithType:UMTRequestTypePost params:dic andUrlPath:[NSString stringWithFormat:@"user/location"] completionBlock:^(id response, NSString *message, NSError *erro) {
        if (erro) {
            completionBlock(erro,nil);
        }else{
            completionBlock(nil,response);
        }
    }];
}

@end
