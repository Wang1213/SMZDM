//
//  SMArticleModel.h
//  SMZDM
//
//  Created by 王天奇 on 16/2/28.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMArticleModel : NSObject

@property (nonatomic, copy) NSString *article_channel_id;
@property (nonatomic, copy) NSString *article_channel_name;
@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, copy) NSString *article_url;
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_rzlx;
@property (nonatomic, copy) NSString *article_date;
@property (nonatomic, copy) NSString *article_format_date;
@property (nonatomic, copy) NSString *article_pic;
@property (nonatomic, copy) NSString *article_collection;
@property (nonatomic, copy) NSString *article_favorite;
@property (nonatomic, copy) NSString *article_love_count;
@property (nonatomic, copy) NSString *article_comment;
@property (nonatomic, copy) NSString *article_price;
@property (nonatomic, copy) NSString *article_link;
@property (nonatomic, strong) NSDictionary *article_mall_client;
@property (nonatomic, copy) NSString *article_link_type;
@property (nonatomic, copy) NSString *article_link_list;
@property (nonatomic, strong) NSDictionary *redirect_data;
@property (nonatomic, copy) NSString *article_tag;
@property (nonatomic, copy) NSString *article_referrals;
@property (nonatomic, copy) NSString *article_avatar;
@property (nonatomic, copy) NSString *user_smzdm_id;
@property (nonatomic, copy) NSString *article_filter_content;
@property (nonatomic, copy) NSString *share_title;
@property (nonatomic, copy) NSString *share_title_other;
@property (nonatomic, copy) NSString *share_pic_title;
@property (nonatomic, copy) NSString *share_pic;
@property (nonatomic, copy) NSString *share_title_separate;
@property (nonatomic, copy) NSString *article_top;
@property (nonatomic, copy) NSString *time_sort;
@property (nonatomic, copy) NSString *matches_rules;
@property (nonatomic, copy) NSString *promotion_type;

+ (instancetype)articleWithDict:(NSDictionary *)dict;

@end
