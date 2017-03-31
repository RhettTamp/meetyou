//
//  UMTBaseRequest.m
//  U米兔
//
//  Created by 谭培 on 2017/3/30.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBaseRequest.h"
#import "AFNetWorking.h"

@interface UMTBaseRequest ()

@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,copy) UMTRequestCompletion completionBlock;
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end


@implementation UMTBaseRequest

+ (instancetype)requestWithURL:(NSString *)url{
    UMTBaseRequest *request = [[UMTBaseRequest alloc]init];
    request.urlString = url;
    return request;
}

- (NSURLSessionDataTask *)requestWithType:(UMTRequestType)type params:(id)params completionBlock:(id)Completion{
    NSURLSessionDataTask *task = nil;
    self.completionBlock = Completion;
    self.sessionManager = [self sessionManager];
    if (type == UMTRequestTypeGet) {
        task = [self.sessionManager GET:self.urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (self.completionBlock) {
                self.completionBlock(responseObject, nil, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (self.completionBlock) {
                self.completionBlock(nil, nil, error);
            }
        }];
    }else if (type == UMTRequestTypePost){
        task = [self.sessionManager POST:self.urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (self.completionBlock) {
                self.completionBlock(responseObject, nil, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (self.completionBlock) {
                self.completionBlock(nil, nil, error);
            }
        }];
    }
    return task;
}

-(AFHTTPSessionManager *)sessionManager{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0f;
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    return sessionManager;
}


@end
