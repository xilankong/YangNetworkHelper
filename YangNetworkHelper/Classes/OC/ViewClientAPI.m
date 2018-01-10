//
//  ViewClientAPI.m
//  NetworkHelper
//
//  Created by yanghuang on 16/12/29.
//  Copyright © 2016年 yanghuang. All rights reserved.
//

#import "ViewClientAPI.h"

@implementation ViewClientAPI

-(NSString *)requestUrlString {
    
    return @"/test";
}

-(NSString *)httpMethod {
    
    return @"POST";
}

-(BOOL)requestWithHttps {
    return YES;
}


- (NSDictionary *)parameter {
    return @{@"name":@"one",@"age":@"10"};
}

@end
