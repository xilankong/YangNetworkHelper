//
//  BaseAPI+BaseAPIMore.m
//  NetworkHelper
//
//  Created by yanghuang on 2018/1/9.
//  Copyright © 2018年 yanghuang. All rights reserved.
//

#import "BaseAPIMore.h"

@implementation BaseAPI (APIParameter)

- (NSDictionary *)requestParameter{
    //拼装公共参数
    NSDictionary *dic = @{@"uid":@"123456",@"sid":@"362541"};
    NSMutableDictionary *requestParameter = [NSMutableDictionary dictionaryWithDictionary:dic];
    if ([self parameter]) {
        [requestParameter addEntriesFromDictionary:[self parameter]];
    }
    return requestParameter;
}

@end

@interface BaseAPI()

@property (nonatomic, strong, readwrite) ReqCallBackCode *error;
@property (nonatomic, strong, readwrite) id responseObject;
@property (nonatomic, strong, readwrite) NSURLSessionTask * task;
@property (nonatomic, assign) BOOL isInRequest;
@end

@implementation BaseAPI (APICallBack)

- (void)resolvingTask:(NSURLSessionTask *)task {
    self.task = task;
    self.isInRequest = YES;
}

-(void)_setIsInRequest:(BOOL)isInRequest {
    self.isInRequest = isInRequest;
}

#pragma mark 处理返回结果
- (void)resolvingResponseObject:(id)responseObject {
    //解析结果
    self.error = nil;
    if (responseObject) {
        if ([responseObject isKindOfClass:[NSError class]]) {
            self.error = [[ReqCallBackCode alloc]initWithError:responseObject];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.responseObject = responseObject;
        }
        
    } else {
        self.error = [ReqCallBackCode error:@"接口数据为空"];
        return;
    }
}

#pragma mark 触发成功回调
- (void)triggerSuccessHanderBlock{
    self.isInRequest = NO;
    __weak typeof(self) weakSelf = self;
    if (self.completionHandler) {
        if ([NSThread isMainThread]) {
            self.completionHandler(self.responseObject, nil);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                strongSelf.completionHandler(strongSelf.responseObject, nil);
            });
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(api:success:)]){
        if ([NSThread isMainThread]) {
            [self.delegate api:self success:self.responseObject];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.delegate api:strongSelf success:strongSelf.responseObject];
            });
        }
    }
}

#pragma mark 触发失败回调
- (void)triggerFailueHandlerBlock {
    self.isInRequest = NO;
    __weak typeof(self) weakSelf = self;
    if (self.completionHandler) {
        if ([NSThread isMainThread]) {
            self.completionHandler(nil, self.error);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                strongSelf.completionHandler(nil, strongSelf.error);
            });
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(api:success:)]){
        if ([NSThread isMainThread]) {
            [self.delegate api:self failue:self.error];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                 [strongSelf.delegate api:strongSelf failue:strongSelf.error];
            });
        }
    }
}
@end
