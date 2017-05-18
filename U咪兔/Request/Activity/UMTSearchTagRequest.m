//
//  UMTSearchTagRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/11.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSearchTagRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTSearchTagRequest

+ (void)searchTagWithKeyValue:(NSString *)key andCompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    NSDictionary *params = @{@"q":key};
    UMTBaseRequest *request = [[UMTBaseRequest alloc]init];
    [request requestWithType:UMTRequestTypeGet params:params andUrlPath:@"search/tags" completionBlock:^(id response, NSString *message, NSError *erro) {
        if (erro) {
            completionBlock(erro,nil);
        }else{
            completionBlock(nil,response);
        }
    }];
}

@end
