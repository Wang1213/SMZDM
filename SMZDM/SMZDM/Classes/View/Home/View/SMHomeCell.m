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

@interface SMHomeCell()

@property (nonatomic, strong)UIImageView *articlePic;

@property (nonatomic, strong)UILabel *articleTitle;

@property (nonatomic, strong)UIButton *articleFavorite;

@property (nonatomic, strong)UIButton *articleComment;

@property (nonatomic, strong)UILabel *articlePrice;

@property (nonatomic, strong)UILabel *articleRzlxAndDate;

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

- (void)setupUI{
    self.articlePic = [[UIImageView alloc] init];
    self.articlePic.image = [UIImage imageNamed:@"noImage_defaultHomePage_list"];
    [self addSubview:self.articlePic];
    
    self.articleTitle = [[UILabel alloc] init];
    [self.articleTitle setBackgroundColor:[UIColor lightGrayColor]];
    [self.articleTitle setText:@"标题"];
    [self addSubview:self.articleTitle];
    
    self.articlePrice = [[UILabel alloc] init];
    [self.articlePrice setBackgroundColor:[UIColor orangeColor]];
    [self.articlePrice setText:@"价格"];
    [self addSubview:self.articlePrice];
    
    self.articleFavorite = [[UIButton alloc] init];
    [self.articleFavorite setBackgroundColor:[UIColor grayColor]];
    [self.articleFavorite setTitle:@"赞" forState:UIControlStateNormal];
    [self addSubview:self.articleFavorite];
    
    self.articleComment = [[UIButton alloc] init];
    [self.articleComment setBackgroundColor:[UIColor grayColor]];
    [self.articleComment setTitle:@"评论" forState:UIControlStateNormal];
    [self addSubview:self.articleComment];
    
    self.articleRzlxAndDate = [[UILabel alloc] init];
    [self.articleRzlxAndDate setBackgroundColor:[UIColor redColor]];
    [self.articleRzlxAndDate setText:@"公告|2.28"];
    [self addSubview:self.articleRzlxAndDate];

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
    
    [self.articleRzlxAndDate makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articlePic.right);
        make.right.equalTo(self.articleComment.left);
        make.top.equalTo(self.articlePrice.bottom);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [self.articleFavorite makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self.articlePrice.bottom);
        make.bottom.equalTo(self);
        make.width.equalTo(50);
    }];
    
    [self.articleComment makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.articleFavorite.left);
        make.top.equalTo(self.articlePrice.bottom);
        make.bottom.equalTo(self);
        make.width.equalTo(50);
    }];
}

@end

