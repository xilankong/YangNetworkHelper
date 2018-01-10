//
//  BaseAPI+BaseAPIMore.h
//  NetworkHelper
//
//  Created by yanghuang on 2018/1/9.
//  Copyright © 2018年 yanghuang. All rights reserved.
//

#import "BaseAPI.h"
#import "ReqCallBackCode.h"

@interface BaseAPI (APIParameter)

- (NSDictionary *)requestParameter;

@end

@interface BaseAPI (APICallBack)

- (void)resolvingResponseObject:(id)responseObject;

- (void)resolvingTask:(NSURLSessionTask *)task;

- (void)_setIsInRequest:(BOOL)isInRequest;

- (void)triggerSuccessHanderBlock;

- (void)triggerFailueHandlerBlock;

@end
