//
//  SMScrollHeaderModel.h
//  SMZDM
//
//  Created by 王天奇 on 16/2/29.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMScrollHeaderModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;

+ (instancetype)modelWithDict: (NSDictionary *)dict;

@end
