//
//  SMHomeScrollHeaderView.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/29.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "SMHomeScrollHeaderView.h"
#define HomeScrollHeaderViewID @"HomeScrollHeaderViewID"

@interface SMHomeScrollHeaderCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, assign)CGRect superFrame;

@end

@implementation SMHomeScrollHeaderCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];

    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"noImage_defaultTopicDetail_big"];
    [self addSubview:self.imageView];
    [self setBackgroundColor:[UIColor orangeColor]];
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.leading.equalTo(self).offset(0);
    }];
}

@end

@interface SMHomeScrollHeaderView()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SMHomeScrollHeaderView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerClass:[SMHomeScrollHeaderCell class] forCellWithReuseIdentifier:HomeScrollHeaderViewID];
    
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    _dataArray = dataArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMHomeScrollHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeScrollHeaderViewID forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.bounds.size;
}

@end
