//
//  ReqCallBackCode.m
//  NetworkHelper
//
//  Created by yanghuang on 16/12/29.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import "ReqCallBackCode.h"

@implementation ReqCallBackCode

- (instancetype)initWithError:(NSError *)error {
    
    ReqCallBackCode * callBackCode = [[ReqCallBackCode alloc]init];
    callBackCode.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
    
    return callBackCode;
}

+ (ReqCallBackCode *)error:(NSString *)message{
    
    ReqCallBackCode *error = [[ReqCallBackCode alloc] init];
    error.errorMsg = message;
    error.errorCode = @"kCustomErrorCode";
    return error;
    
}

@end
