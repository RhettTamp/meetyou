//
//  UMTRefreshToken.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/8.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRefreshToken.h"
#import "UMTBaseRequest.h"
#import "UMTKeychainTool.h"
@implementation UMTRefreshToken

+ (void)refreshTokenWithOldToken:(NSString *)oldToken{
    if (oldToken.length == 0) {
        return;
    }else{
        UMTBaseRequest *shareRequest = [UMTBaseRequest sharedRequest];
        shareRequest.requestToken = oldToken;
        [shareRequest requestWithType:UMTRequestTypePost params:nil andUrlPath:@"user/upToken" completionBlock:^(id response, NSString *message, NSError *erro) {
            if (erro) {
                NSLog(@"%@",erro);
            }else{
                NSString *token = response[@"token"];
                shareRequest.requestToken = token;
                NSDate *date = [NSDate date];
                [UMTKeychainTool save:kTokenKey data:token];
                [UMTKeychainTool save:@"lastDate" data:date];
            }
            
            
        }];
    }
}

@end
