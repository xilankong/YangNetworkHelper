//
//  BaseAPI.m
//  NetworkHelper
//
//  Created by yanghuang on 16/12/29.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import "BaseAPI.h"
#import "YangHttpsClient.h"
#import "YangHttpClient.h"

@interface BaseAPI(){
    NSDictionary *_parameter;
}

@property (nonatomic, strong, readwrite) ReqCallBackCode *error;
@property (nonatomic, strong, readwrite) id responseObject;
@property (nonatomic, strong, readwrite) NSURLSessionTask * task;
@property (nonatomic, assign) BOOL isInRequest;

@end

@implementation BaseAPI

+ (instancetype)api{
    
    return [[BaseAPI alloc] init];
}

- (NSString *)requestUrlString{
    
    return @"";
}

- (NSString *)httpMethod{
    
    return @"GET";
}

- (BOOL)requestWithHttps {
    return YES;
}

-(NSDictionary *)parameter {
    return _parameter;
}

#pragma mark 开启请求
- (BaseAPI *)start{
    if ([self requestWithHttps]) {
        YangHttpsClient *client = [YangHttpsClient sharedClient];
        [client addRequest:self];
    } else {
        YangHttpClient *client = [YangHttpClient sharedClient];
        [client addRequest:self];
    }
    return self;
}

#pragma mark 取消请求
- (void)cancle {
    [self.task cancel];
}

- (BaseAPI *)startWithDelegate:(id<APICallBackDelegate>)delegate {
    self.delegate = delegate;
    return [self start];
}

- (BaseAPI *)startWithParameter:(NSDictionary *)parameter delegate:(id<APICallBackDelegate>)delegate {
    self.delegate = delegate;
    _parameter = parameter;
    return [self start];
}

- (BaseAPI *)startWithCompletionHandler:(APICompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    
    return [self start];
}

- (BaseAPI *)startWithParameter:(NSDictionary *)parameter complete:(APICompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    _parameter = parameter;
    return [self start];
}

@end
