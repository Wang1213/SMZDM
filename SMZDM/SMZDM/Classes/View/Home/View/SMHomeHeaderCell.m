//
//  SMHomeHeaderCell.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/29.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "UIImageView+WebCache.h"
#import "SMHomeHeaderCell.h"
#import "SMScrollHeaderModel.h"
#import "SMHomeScrollHeaderView.h"
#import "Masonry.h"
#import "PrefixHeader.pch"

#define NumberOfPages 5

@interface SMHomeHeaderCell()

@property (nonatomic, strong) SMHomeHeaderCell *scrollView;
@property (nonatomic, strong) SMHomeScrollHeaderView * homeScrollHeaderView;
@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation SMHomeHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageChanged:) name:NotificationHomeHeaderCellPageChanged object:nil];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI{
    
    UICollectionViewFlowLayout *colViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    colViewFlowLayout.itemSize = CGSizeMake(ScreenWidth, 90);
    colViewFlowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    colViewFlowLayout.minimumLineSpacing = 0;
    colViewFlowLayout.minimumInteritemSpacing = 0;
    
    SMHomeScrollHeaderView *homeScrollHeaderView = [[SMHomeScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90) collectionViewLayout:colViewFlowLayout];
    self.homeScrollHeaderView = homeScrollHeaderView;
    [self addSubview:homeScrollHeaderView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.numberOfPages = NumberOfPages;
    pageControl.currentPage = 0;
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.homeScrollHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.leading.equalTo(self).offset(0);
    }];

    [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (void)pageChanged:(NSNotification *)noti{
    NSString *currentPageStr = noti.object;
    NSInteger currentPageInt = [currentPageStr integerValue];
    self.pageControl.currentPage = currentPageInt;
}

@end
