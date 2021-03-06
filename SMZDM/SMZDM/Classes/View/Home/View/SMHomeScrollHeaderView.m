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
#import "UIImageView+WebCache.h"
#import "SMHomeScrollHeaderView.h"
#import "SMScrollHeaderModel.h"
#import "PrefixHeader.pch"

#define HomeScrollHeaderViewID @"HomeScrollHeaderViewID"
#define NumberOfPages 5

@interface SMHomeScrollHeaderCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, assign)CGRect superFrame;

@property (nonatomic, strong)SMScrollHeaderModel *model;

@end

@implementation SMHomeScrollHeaderCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self setupUI];
    
    return self;
}

- (void)setupUI{
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"noImage_defaultTopicDetail_big"];
    [self addSubview:self.imageView];

}

- (void)setModel:(SMScrollHeaderModel *)model{
    _model = model;
    [self reloadData];
    
}

- (void)reloadData{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.img]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.leading.equalTo(self).offset(0);
    }];
    
}

@end





typedef NS_ENUM(NSInteger, AutoScrollDirction) {
    AutoScrollDirctionRight,
    AutoScrollDirctionLeft
};

@interface SMHomeScrollHeaderView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;

//计时器
@property (nonatomic, strong)NSTimer *timer;

//自动滚动方向
@property (nonatomic, assign)AutoScrollDirction autoScrollDirction;

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
    self.contentSize = CGSizeMake(ScreenWidth * 5, 150);
    
    self.autoScrollDirction = AutoScrollDirctionRight;
    [self startTimer];
    
    [self registerClass:[SMHomeScrollHeaderCell class] forCellWithReuseIdentifier:HomeScrollHeaderViewID];
    [self getDataWithUrlString:@"http://api.smzdm.com/v2/util/banner?f=iphone&type=home&v=6.1.2&weixin=0"];
    
    return self;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return NumberOfPages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMHomeScrollHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeScrollHeaderViewID forIndexPath:indexPath];
    
    if (self.dataArray.count) {
        SMScrollHeaderModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.bounds.size;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomeHeaderCellPageChanged object:pageStr];
}

- (void)getDataWithUrlString:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *rerquest = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:rerquest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data) {
            
            NSDictionary *tlist = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *tData = tlist[@"data" ];
            
            NSArray *tempArray = tData[@"rows"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dict in tempArray) {
                SMScrollHeaderModel *scrollHeaderModel = [SMScrollHeaderModel modelWithDict:dict];
                [array addObject:scrollHeaderModel];
            }
            
            self.dataArray = array;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
            });
            
        }
    }] resume];
    
}

//启动时钟
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//停止时钟
- (void)updateTimer{
    NSInteger count = NumberOfPages - 1
    ;
    
    if (!count) {
        return;
    }
    
    NSInteger index = [self getCurrentPageIndex];
    if (self.autoScrollDirction == AutoScrollDirctionRight && index < count) {
        [self pageChanged:++index];
    }else if (index == count){
        [self pageChanged:--index];
        self.autoScrollDirction = AutoScrollDirctionLeft;
    }else if (self.autoScrollDirction == AutoScrollDirctionLeft && index > 0){
        [self pageChanged:--index];
    }else if (index == 0){
        [self pageChanged:++index];
        self.autoScrollDirction = AutoScrollDirctionRight;
    }
    
}

- (void)pageChanged:(NSInteger)pageIndex{
    [self.timer invalidate];
    
    CGFloat x = self.bounds.size.width * pageIndex;
    [self setContentOffset:CGPointMake(x, 0) animated:YES];
    [self startTimer];
}

- (NSInteger)getCurrentPageIndex{
    
    return (self.contentOffset.x)/ScreenWidth;
}

@end
