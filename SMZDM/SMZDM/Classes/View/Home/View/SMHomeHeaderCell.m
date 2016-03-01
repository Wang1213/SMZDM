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

@interface SMHomeHeaderCell()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SMHomeHeaderCell *scrollView;
@property (nonatomic, strong) SMHomeScrollHeaderView * homeScrollHeaderView;

@end

@implementation SMHomeHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self setupUI];
    
    return self;
}

- (void)setupUI{
    
    UICollectionViewFlowLayout *colViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    colViewFlowLayout.itemSize = CGSizeMake(ScreenWidth, 90);
    colViewFlowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    colViewFlowLayout.minimumLineSpacing = 0;
    colViewFlowLayout.minimumInteritemSpacing = 0;
    
    SMHomeScrollHeaderView *homeScrollHeaderView = [[SMHomeScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90) collectionViewLayout:colViewFlowLayout];
    self.homeScrollHeaderView = homeScrollHeaderView;
    [self.homeScrollHeaderView setBackgroundColor:[UIColor blueColor]];
    [self addSubview:homeScrollHeaderView];
    
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    _dataArray = dataArray;
//    [self reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.homeScrollHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.leading.equalTo(self).offset(0);
    }];

}

//- (void)reloadData{
//    if (self.dataArray.count) {
//        SMScrollHeaderModel *model = self.dataArray[1];
//    }
//}

@end
