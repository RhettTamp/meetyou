//
//  UMTBaseRequest.m
//  U米兔
//
//  Created by 谭培 on 2017/3/30.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBaseRequest.h"
#import "AFNetWorking.h"
#import "UMTKeychainTool.h"

@interface UMTBaseRequest ()

@property (nonatomic,copy) UMTRequestCompletion completionBlock;
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

static const NSString *baseUrl = @"https://xbbbbbb.cn/MeetU/api/";
static UMTBaseRequest *baseRequest = nil;

@implementation UMTBaseRequest

+ (instancetype)sharedRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseRequest = [[UMTBaseRequest alloc]init];
        baseRequest.requestToken = [UMTKeychainTool load:kTokenKey];
    });
    return baseRequest;
}

- (void)requestWithType:(UMTRequestType)type params:(id)params andUrlPath:(NSString *)urlPath completionBlock:(UMTRequestCompletion)completionBlock{
    NSString *urlStr = [baseUrl copy];
    urlStr = [NSString stringWithFormat:@"%@%@",urlStr,urlPath];
    if (self.requestToken && self.requestToken.length > 0) {
        urlStr = [NSString stringWithFormat:@"%@?token=%@",urlStr,self.requestToken];
    }
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0f;
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    if (type == UMTRequestTypeGet) {
        [sessionManager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completionBlock) {
                completionBlock(responseObject, nil, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completionBlock) {
                completionBlock(nil, nil, error);
            }
        }];
    }else if (type == UMTRequestTypePost){
        [sessionManager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completionBlock) {
                completionBlock(responseObject, nil, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completionBlock) {
                completionBlock(nil, nil, error);
            }
        }];
    }
}

- (void)uploadFileData:(NSData *)fileData params:(id)params progress:(void(^)(NSProgress *uploadProgress))progress completionBlock:(UMTRequestCompletion)completionBlock{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0f;
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    [sessionManager POST:[baseUrl copy] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFormData:fileData name:fileName];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(responseObject,nil,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(nil,nil,error);
    }];
    
}


@end
