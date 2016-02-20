//
//  SMHomeColView.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/15.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMHomeColView.h"
#import "PrefixHeader.pch"
#import "SMTopBarBottomView.h"

#define NumOfPage 6
#define ColWidth self.bounds.size.width

#define HomeColCellID @"HOME_COLLECTION_CELL"

@interface SMHomeColView()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isClick;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollHomeColViewPage:) name:NotificationScrollHomeColViewPage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topBarButtonDidClick:) name:NotificationClickTopBarButton object:nil];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return NumOfPage;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:HomeColCellID forIndexPath:indexPath];
    UIColor *randomColor = [[UIColor alloc] initWithRed: arc4random() % 256/256.0  green: arc4random() % 256/256.0  blue: arc4random() % 256/256.0  alpha:1.0];
    [cell setBackgroundColor:randomColor];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"...");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollProportionFlt = self.contentOffset.x/(ColWidth * NumOfPage);
    NSLog(@"%f",scrollProportionFlt);
    
    NSString * scrollProportionStr = [NSString stringWithFormat:@"%f",scrollProportionFlt];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMoveToNextTopBarBtn object:scrollProportionStr];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.isClick = NO;
}

- (void)scrollHomeColViewPage:(NSNotification *)noti{
    NSString *scrollProportionStr = noti.object;
    CGFloat scrollProportionFlt = [scrollProportionStr floatValue];
    CGFloat offSetX = scrollProportionFlt * ColWidth * NumOfPage;
    [self setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}

- (void)topBarButtonDidClick:(NSNotification *)noti{
    if ([noti.object isEqual: TopBarButtonClick]) {
        [self scrollViewWillBeginDragging:self];
        self.isClick = YES;
    }
}

@end
