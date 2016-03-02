//
//  SMNetWorkTools.h
//  SMZDM
//
//  Created by 王天奇 on 16/3/2.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^finish)(id response, NSError *error);

typedef NS_ENUM(NSInteger, SMRequestMethod) {
    GET,
    POST
};

@interface SMNetWorkTools : AFHTTPSessionManager

+ (instancetype)shareManger;

- (void)request:(SMRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finish:(void (^)(id response, NSError *error))finish;

@end
