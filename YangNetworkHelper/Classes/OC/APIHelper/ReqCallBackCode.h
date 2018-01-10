//
//  ReqCallBackCode.h
//  NetworkHelper
//
//  Created by yanghuang on 16/12/29.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqCallBackCode : NSObject

@property(nonatomic, strong) NSString *errorCode;

@property(nonatomic, strong) NSString *errorMsg;

- (instancetype)initWithError:(NSError *)error;
+ (ReqCallBackCode *)error:(NSString *)message;
@end
