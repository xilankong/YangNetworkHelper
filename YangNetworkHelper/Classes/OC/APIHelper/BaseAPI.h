//
//  BaseAPI.h
//  NetworkHelper
//
//  Created by yanghuang on 16/12/29.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqCallBackCode.h"
#import "BaseAPI.h"

typedef void (^APICompletionHandler)(id responseObject, ReqCallBackCode * error);
//api回调
@class BaseAPI;

@protocol APICallBackDelegate <NSObject>

- (void)api:(BaseAPI *)api success:(id)responseObject;
- (void)api:(BaseAPI *)api failue:(ReqCallBackCode *)error;

@end

@protocol APIParameterProtocol <NSObject>

@required
- (NSDictionary *)parameter;

@end

@interface BaseAPI : NSObject

@property (nonatomic, weak) id<APICallBackDelegate> delegate;

@property (nonatomic, copy) APICompletionHandler completionHandler;

@property (nonatomic, strong, readonly) NSURLSessionTask * task;

@property (nonatomic, strong, readonly) id responseObject;

@property (nonatomic, strong, readonly) ReqCallBackCode *error;

+ (instancetype)api;
- (void)cancle;

- (BaseAPI *)start;

- (BOOL)requestWithHttps;

- (NSString *)httpMethod;

- (NSString *)requestUrlString;

- (NSDictionary *)parameter;


- (BaseAPI *)startWithDelegate:(id<APICallBackDelegate>)delegate;

- (BaseAPI *)startWithParameter:(NSDictionary *)parameter delegate:(id<APICallBackDelegate>)delegate;

- (BaseAPI *)startWithCompletionHandler:(APICompletionHandler)completionHandler;

- (BaseAPI *)startWithParameter:(NSDictionary *)parameter complete:(APICompletionHandler)completionHandler;

@end
