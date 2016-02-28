//
//  SMArticleModel.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/28.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMArticleModel.h"

@implementation SMArticleModel

+ (instancetype)articleWithDict:(NSDictionary *)dict{
    
    SMArticleModel * article = [[SMArticleModel alloc] init];
    
    [article setValuesForKeysWithDictionary:dict];
    
    return article;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
