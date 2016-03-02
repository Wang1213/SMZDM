//
//  SMNetWorkTools.m
//  SMZDM
//
//  Created by 王天奇 on 16/3/2.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "SMNetWorkTools.h"
#import "AFNetworking.h"

@implementation SMNetWorkTools

+ (instancetype)shareManger{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)request:(SMRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finish:(void (^)(id response, NSError *error))finish{
    
    void (^success)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        finish(responseObject, nil);
    };
    
    void (^failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        finish(nil, error);
    };

    
    if (method == GET) {
        [self GET:urlString parameters:parameters progress:nil success:success failure:failure];
    }else if (method == POST){
        [self POST:urlString parameters:parameters progress:nil success:success failure:failure];
    }
    
}

@end
