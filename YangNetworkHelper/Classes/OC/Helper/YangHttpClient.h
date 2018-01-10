//
//  YangHttpClient.h
//  NetworkHelper
//
//  Created by yanghuang on 16/12/28.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YangHttpClientProtocol.h"
#import "BaseAPI.h"
#import "BaseAPIMore.h"

@interface YangHttpClient : NSObject

+ (instancetype _Nonnull)sharedClient;

- (void)addRequest:(BaseAPI * _Nonnull)request;

- (void)cancleRequest:(BaseAPI * _Nonnull)request;
- (void)cancleAllRequest;

@end
