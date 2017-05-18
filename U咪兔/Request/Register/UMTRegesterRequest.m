//
//  UMTRegesterRequest.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/10.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTRegesterRequest.h"
#import "UMTRegisterHelper.h"
#import "UMTBaseRequest.h"
#import <YYModel.h>

@implementation UMTRegesterRequest

+ (void)RegisterWithCompletionBlock:(void(^)(NSError *erro, id response))completionBlock{
    UMTRegisterHelper *sharedHelper = [UMTRegisterHelper sharedHelper];
    NSDictionary *params = [sharedHelper yy_modelToJSONObject];
    if (sharedHelper.photo) {
        [params setValue:sharedHelper.photo forKey:@"photo"];
        NSLog(@"%@",params[@"photo"]);
    }
    if (sharedHelper.photo2) {
        [params setValue:sharedHelper.photo2 forKey:@"photo2"];
    }
    [[UMTBaseRequest sharedRequest] requestWithType:UMTRequestTypePost params:params andUrlPath:@"users" completionBlock:^(id response, NSString *message, NSError *erro) {
        if (erro) {
            if (completionBlock) {
                completionBlock(erro,nil);
            }
        }else{
            if (completionBlock) {
                NSString *phoneNumber = [UMTRegisterHelper sharedHelper].phone;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:phoneNumber forKey:@"phoneNumber"];
                [defaults synchronize];
                completionBlock(nil,response);
            }
        }
    }];

}

@end
