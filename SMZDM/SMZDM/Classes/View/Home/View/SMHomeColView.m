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
#import "SMHomeColCell.h"

#define NumOfPage 6
#define ColWidth self.bounds.size.width

static NSString * const HomeColCellID =  @"HOME_COLLECTION_CELL";

@interface SMHomeColView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (nonatomic, assign) CGFloat startContentOffsetX;
@property (nonatomic, assign) CGFloat willEndContentOffsetX;
@property (nonatomic, assign) BOOL topBarBtnIsClick;

@end

@implementation SMHomeColView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    [self registerClass:[SMHomeColCell class] forCellWithReuseIdentifier:HomeColCellID];
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.pagingEnabled = YES;
    [self setBackgroundColor:[UIColor whiteColor]];
    self.tag = 0;
    
    //监听btn点击，滑动page
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollHomeColViewPage:) name:NotificationScrollHomeColViewPage object:nil];
    //监听btn点击，保存点击状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgeTopBarBtnClick:) name:NotificationJudgeClick object:nil];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return NumOfPage;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SMHomeColCell *cell = [self dequeueReusableCellWithReuseIdentifier:HomeColCellID forIndexPath:indexPath];
    
    cell.currentRow = indexPath.row;
    //[[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeIndexPath object:indexPath];
    
    return cell;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{ //拖动前的起始坐标
    self.startContentOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{ //将要停止前的坐标
    self.willEndContentOffsetX = scrollView.contentOffset.x;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollProportionFlt = self.contentOffset.x/(ColWidth * NumOfPage);
    NSString * scrollProportionStr = [NSString stringWithFormat:@"%f",scrollProportionFlt];
    
    //如果点击btn，则不发滑动方向消息给topBarView
    if (!self.topBarBtnIsClick) {
        CGFloat endContentOffsetX = scrollView.contentOffset.x;
        
        //判断临时滑动方向
        if (endContentOffsetX < self.willEndContentOffsetX && self.willEndContentOffsetX < self.startContentOffsetX) { //画面从右往左移动,前一页
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeColViewTemporaryScrollDirction object:@"left"];
        } else if (endContentOffsetX > self.willEndContentOffsetX && self.willEndContentOffsetX > self.startContentOffsetX) {//画面从左往右移动,后一页
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeColViewTemporaryScrollDirction object:@"right"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTopBtnColorChanged object:scrollProportionStr];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMoveToNextTopBarBtn object:scrollProportionStr];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.topBarBtnIsClick = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (!self.topBarBtnIsClick) {
        CGFloat endContentOffsetX = scrollView.contentOffset.x;
        
        //判断最终滑动方向
        if (endContentOffsetX < self.willEndContentOffsetX && self.willEndContentOffsetX < self.startContentOffsetX) { //画面从右往左移动,前一页
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeColViewScrollDirction object:@"left"];
        } else if (endContentOffsetX > self.willEndContentOffsetX && self.willEndContentOffsetX > self.startContentOffsetX) {//画面从左往右移动,后一页
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeColViewScrollDirction object:@"right"];
        } else{
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeColViewScrollDirction object:@"noScroll"];
        }
        //通知topBarBtn恢复颜色设置
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeColViewDidEndDecelerating object:nil];
    }
    
    //点击结束，保存状态
    self.topBarBtnIsClick = NO;
    
}

//监听执行
- (void)scrollHomeColViewPage:(NSNotification *)noti{
    
    NSString *scrollProportionStr = noti.object;
    CGFloat scrollProportionFlt = [scrollProportionStr floatValue];
    CGFloat offSetX = scrollProportionFlt * ColWidth * NumOfPage;
    [self setContentOffset:CGPointMake(offSetX, 0) animated:NO];
    
}

- (void)judgeTopBarBtnClick:(NSNotification *)noti{
    NSString *str = noti.object;
    if ([str isEqualToString:@"click"]) {
        self.topBarBtnIsClick = YES;
    }
}

@end
