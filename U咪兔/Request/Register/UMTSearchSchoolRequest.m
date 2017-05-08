//
//  UMTSearchSchoolRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTSearchSchoolRequest.h"
#import "UMTBaseRequest.h"

@implementation UMTSearchSchoolRequest

+ (void)getMoreSchoolWithKey:(NSString *)key andCompletionBlock:(void(^)(NSError *erro, id response))completionBlock;{
    NSDictionary *dic = @{@"q":key};
    [[UMTBaseRequest sharedRequest] requestWithType:UMTRequestTypeGet params:dic andUrlPath:[[NSString stringWithFormat:@"search/schools"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] completionBlock:^(id response, NSString *message, NSError *erro) {
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
