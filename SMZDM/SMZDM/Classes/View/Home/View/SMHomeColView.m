//
//  SMHomeColView.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/15.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMHomeColView.h"

#define numOfPage 6

#define HomeColCellID @"HOME_COLLECTION_CELL"

@interface SMHomeColView()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@end

@implementation SMHomeColView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HomeColCellID];
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.pagingEnabled = YES;
    [self setBackgroundColor:[UIColor blueColor]];
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return numOfPage;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:HomeColCellID forIndexPath:indexPath];
    UIColor *randomColor = [[UIColor alloc] initWithRed: arc4random() % 256/256.0  green: arc4random() % 256/256.0  blue: arc4random() % 256/256.0  alpha:1.0];
    [cell setBackgroundColor:randomColor];
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerateP{
    NSLog(@"ccc");
}

@end
