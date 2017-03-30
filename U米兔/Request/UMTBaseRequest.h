//
//  UMTBaseRequest.h
//  U米兔
//
//  Created by 谭培 on 2017/3/30.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,UMTRequestType){
    UMTRequestTypeGet,
    UMTRequestTypePost,
};

typedef void(^UMTRequestCompletion)(id response,NSString *message,NSError *erro);


@interface UMTBaseRequest : NSObject

+ (instancetype)requestWithURL:(NSString *)url;

- (NSURLSessionDataTask *)requestWithType:(UMTRequestType)type params:(id)params completionBlock:UMTRequestCompletion;

@end
