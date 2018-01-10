//
//  YangHttpClientProtocol.h
//  NetworkHelper
//
//  Created by yanghuang on 16/12/28.
//  Copyright © 2016年 yanghuang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@protocol YangHttpClientProtocol <NSObject>

@required

- (id )GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id operation, id responseObject))success
   failure:(void (^)(id operation, NSError *error))failure;

- (id )POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id operation, id responseObject))success
    failure:(void (^)(id operation, NSError *error))failure;

@end
