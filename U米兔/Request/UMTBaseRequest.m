//
//  UMTBaseRequest.m
//  U米兔
//
//  Created by 谭培 on 2017/3/30.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTBaseRequest.h"

@interface UMTBaseRequest ()

@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,copy) UMTRequestCompletion completionBlock;

@end


@implementation UMTBaseRequest

+ (instancetype)requestWithURL:(NSString *)url{
    UMTBaseRequest *request = [[UMTBaseRequest alloc]init];
    request.urlString = url;
    return request;
}

//- (NSURLSessionDataTask *)requestWithType:(UMTRequestType)type params:(id)params completionBlock:(id)Completion{
//    NSURLSessionDataTask *task = nil;
//}

@end
