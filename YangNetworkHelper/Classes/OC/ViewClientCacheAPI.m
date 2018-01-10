//
//  ViewClientCacheAPI.m
//  NetworkHelper
//
//  Created by yanghuang on 17/1/18.
//  Copyright © 2017年 yanghuang. All rights reserved.
//

#import "ViewClientCacheAPI.h"

@implementation ViewClientCacheAPI

-(BaseAPI *)start {
    [self cacheDataResponse];
    return [super start];
}

- (void)cacheDataResponse {
//    self.responseObject = @{@"name":@"this is the cache data"};
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(api:success:)]) {
        [self.delegate performSelector:@selector(api:success:) withObject:self withObject:self.responseObject];
    }
}
-(NSString *)requestUrlString {
    
    return @"/test";
}

-(NSString *)httpMethod {
    
    return @"POST";
}

- (NSDictionary *)parameter {
    return @{@"name":@"one",@"age":@"10"};
}
@end
