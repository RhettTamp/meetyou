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

@property (nonatomic,copy) NSString *requestToken;

- (void)requestWithType:(UMTRequestType)type params:(id)params andUrlPath:(NSString *)urlPath completionBlock:(UMTRequestCompletion)completionBlock;

+ (instancetype)sharedRequest;

- (void)uploadFileData:(NSData *)fileData params:(id)params progress:(void(^)(NSProgress *uploadProgress))progress completionBlock:(UMTRequestCompletion)completionBlock;

@end
