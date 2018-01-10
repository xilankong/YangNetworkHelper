//
//  YangHttpsClient.m
//  NetworkHelper
//
//  Created by yanghuang on 16/12/28.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import "YangHttpsClient.h"

@interface YangHttpsSessionManager : AFHTTPSessionManager <YangHttpClientProtocol>

@end

@implementation YangHttpsSessionManager

@end

@interface YangHttpsClient() <YangHttpClientProtocol>

@property (nonatomic, strong) id<YangHttpClientProtocol> httpClient;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) NSMutableDictionary *requestList;

@end

@implementation YangHttpsClient

+ (instancetype)sharedClient {
    
    static YangHttpsClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[YangHttpsClient alloc]init];
        
        YangHttpsSessionManager * httpClient = [[YangHttpsSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://nexus.officeapps.live.com"]];
        
        httpClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        httpClient.securityPolicy.allowInvalidCertificates = YES;
        [httpClient.securityPolicy setValidatesDomainName:NO];
        
        httpClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpClient.requestSerializer.timeoutInterval = 300;
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        _sharedClient.httpClient = httpClient;
        
    });
    
    
    
    return _sharedClient;
}

-(instancetype)init {
    if (self = [super init]) {
        self.lock = [[NSLock alloc]init];
    }
    return self;
}

#pragma mark GET请求

-(id)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id, id))success failure:(void (^)(id, NSError *))failure {
    
    return [self.httpClient GET:URLString parameters:parameters  success:success failure:failure];
}

#pragma mark POST请求

-(id)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id, id))success failure:(void (^)(id, NSError *))failure {
    return [self.httpClient POST:URLString parameters:parameters  success:success failure:failure];
}

#pragma mark 公开方法

-(void)addRequest:(id)req {
    //还有http和https的manager切换问题 需要加一个唯一同步队列保证 ，manager获取根据请求不同来决定
    BaseAPI *request = req;
    NSURLSessionTask *task = nil;
    if ([[request httpMethod] isEqualToString:@"GET"]) {
        task = [self.httpClient GET:request.requestUrlString parameters:[request requestParameter] success:^(id operation, id responseObject) {
            [self handleResponseWithOperation:operation AndResponseObject:responseObject];
        } failure:^(id operation, NSError *error) {
            [self handleResponseWithOperation:operation AndResponseObject:error];
        }];
    } else {
        task = [self.httpClient POST:request.requestUrlString parameters:[request requestParameter] success:^(id operation, id responseObject) {
            [self handleResponseWithOperation:operation AndResponseObject:responseObject];
        } failure:^(id operation, NSError *error) {
            [self handleResponseWithOperation:operation AndResponseObject:error];
        }];
    }
    [request resolvingTask:task];
    [self addRequestWithKey:[self hash_format:task.hash] andRequest:request];
}

#pragma mark 请求结束回调处理

- (void)handleResponseWithOperation:(id)operation AndResponseObject:(id)responseObject {
    BaseAPI *request = [self.requestList objectForKey:[self hash_format:[operation hash]]];
    
    [request resolvingResponseObject:responseObject];
    
    if ([responseObject isKindOfClass:[NSError class]]) {
        [request triggerFailueHandlerBlock];
    } else {
        [request triggerSuccessHanderBlock];
    }
    
    //清除task
    [self deleteRequestWithKey:[self hash_format:request.task.hash]];
}

#pragma mark 取消请求

-(void)cancleRequest:(BaseAPI *)request {
    if (request) {
        [request.task cancel];
        [self deleteRequestWithKey:[self hash_format:request.task.hash]];
    }
}

- (void)cancleAllRequest {
    NSDictionary *requestList_copy = [self.requestList copy];
    for (BaseAPI *api in requestList_copy) {
        [api.task cancel];
        [self deleteRequestWithKey:[self hash_format:api.task.hash]];
    }
}

- (void)addRequestWithKey:(NSString *)key andRequest:(BaseAPI *)req {
    [self.lock lock];
    self.requestList[key] = req;
    [self.lock unlock];
}

- (void)deleteRequestWithKey:(NSString *)key {
    [self.lock lock];
    [self.requestList removeObjectForKey:key];
    [self.lock unlock];
}


///////////工具///////////

//hashValue string化
- (NSString *)hash_format:(NSUInteger)hash {
    return [NSString stringWithFormat:@"%ld",hash];
}
//请求数据处理
- (void)prepareRequest {
    AFHTTPSessionManager *httpClient = (AFHTTPSessionManager *)self.httpClient;
    if (![httpClient.requestSerializer isKindOfClass:[AFJSONRequestSerializer class]]) {
        httpClient.requestSerializer = [AFJSONRequestSerializer serializer];
    }
}

-(NSMutableDictionary *)requestList {
    if (!_requestList) {
        _requestList = [NSMutableDictionary dictionary];
    }
    return _requestList;
}

@end
