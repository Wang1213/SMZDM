//
//  SMScrollHeaderModel.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/29.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMScrollHeaderModel.h"

@implementation SMScrollHeaderModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    SMScrollHeaderModel *scrollHeaderModel = [[SMScrollHeaderModel alloc] init];
    [scrollHeaderModel setValuesForKeysWithDictionary:dict];
    return scrollHeaderModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
