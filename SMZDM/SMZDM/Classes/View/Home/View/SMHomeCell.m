//
//  SMHomeCell.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/28.
//  Copyright © 2016年 王天奇. All rights reserved.
//

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "SMHomeCell.h"
#import "Masonry.h"
#import "UIView+Frame.h"
#import "SMMixButtom.h"

@interface SMHomeCell()

@property (nonatomic, strong)UIImageView *articlePic;

@property (nonatomic, strong)UILabel *articleTitle;

@property (nonatomic, strong)SMMixButtom *articleFavorite;

@property (nonatomic, strong)SMMixButtom *articleComment;

@property (nonatomic, strong)UILabel *articlePrice;

@property (nonatomic, strong)UILabel *articleMallAndDate;

@end

@implementation SMHomeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self setupUI];
    
    return self;
}

- (void)setModel:(SMArticleModel *)model{
    _model = model;
    
    [self reloadData];
}

-(void)reloadData{
    [self.articleTitle setText:self.model.article_title];
    [self.articlePrice setText:self.model.article_price];
    [self.articleFavorite setTitle:self.model.article_favorite forState:UIControlStateNormal];
    [self.articleComment setTitle:self.model.article_comment forState:UIControlStateNormal];
    [self setArticleRzlxAndDate:self.model.article_mall andDate:self.model.article_date];
}

- (void)setupUI{
    
    self.articlePic = [[UIImageView alloc] init];
    self.articlePic.image = [UIImage imageNamed:@"noImage_defaultHomePage_list"];
    [self addSubview:self.articlePic];
    
    self.articleTitle = [[UILabel alloc] init];
    self.articleTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    self.articleTitle.font = [UIFont systemFontOfSize:17];
    self.articleTitle.numberOfLines = 2;
    [self.articleTitle setTextColor:[UIColor grayColor]];
    [self addSubview:self.articleTitle];
    
    self.articlePrice = [[UILabel alloc] init];
    [self.articlePrice setTextColor:[UIColor redColor]];
    self.articlePrice.font = [UIFont systemFontOfSize:17];
    [self addSubview:self.articlePrice];
    
    self.articleFavorite = [[SMMixButtom alloc] init];
    [self.articleFavorite setImage:[UIImage imageNamed:@"icon_zhi_list"] forState:UIControlStateNormal];
    [self.articleFavorite setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.articleFavorite.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.articleFavorite];
    
    self.articleComment = [[SMMixButtom alloc] init];
    [self.articleComment setImage:[UIImage imageNamed:@"icon_ping_list"] forState:UIControlStateNormal];
    [self.articleComment setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.articleComment.titleLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.articleComment];
    
    self.articleMallAndDate = [[UILabel alloc] init];
    self.articleMallAndDate.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.articleMallAndDate];

}

- (void)setArticleRzlxAndDate:(NSString *)mall andDate:(NSString *)date{
    NSString *shortDate = [date substringWithRange:NSMakeRange(5, 6)];
    NSString *str = [NSString stringWithFormat:@"%@|%@",mall,shortDate];
    [self.articleMallAndDate setTextColor:[UIColor lightGrayColor]];
    [self.articleMallAndDate setText:str];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.articlePic makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self).offset(0);
        make.width.equalTo(135);
    }];
    
    [self.articleTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articlePic.right).offset(0);
        make.right.top.equalTo(self).offset(0);;
        make.height.equalTo(70);
    }];
    
    [self.articlePrice makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articlePic.right).offset(0);
        make.right.equalTo(self);
        make.top.equalTo(self.articleTitle.bottom);
        make.height.equalTo(30);
    }];
    
    [self.articleMallAndDate makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articlePic.right);
        make.right.equalTo(self.articleComment.left);
        make.top.equalTo(self.articlePrice.bottom);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [self.articleFavorite makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self.articlePrice.bottom);
        make.bottom.equalTo(self);
        make.width.equalTo(60);
    }];
    
    [self.articleComment makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.articleFavorite.left);
        make.top.equalTo(self.articlePrice.bottom);
        make.bottom.equalTo(self);
        make.width.equalTo(60);
    }];
}

@end

