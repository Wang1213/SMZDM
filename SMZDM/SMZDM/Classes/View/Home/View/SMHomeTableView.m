//
//  SMHomeTableView.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/23.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMHomeTableView.h"
#import "SMHomeCell.h"
#import "SMArticleModel.h"
#import "UIView+Frame.h"
#import "SMScrollHeaderModel.h"
#import "SMHomeHeaderCell.h"
#import "SMNetWorkTools.h"
#import "PrefixHeader.pch"

#define HomeCellID @"SMHomeCell"
#define HomeHeaderCellID @"HomeHeaderCellID"

@interface SMHomeTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation SMHomeTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:NotificationGetChannelIndex object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hehe:) name:NotificationHomeIndexPath object:nil];
    
    [self firstloadHomeData];
    [self setupUI];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)setupUI{
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return 135;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SMHomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeHeaderCellID];
        
        if (!cell) {
            cell = [[SMHomeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeHeaderCellID];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        SMHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID];
        
        if (!cell) {
            cell = [[SMHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeCellID];
        }
        
        if (self.dataArray.count) {
            SMArticleModel *model = self.dataArray[indexPath.row];
            cell.model = model;
        }
        
        return cell;
    }

}

//第一次加载频道“首页”数据，只执行一次
- (void)firstloadHomeData{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadDataWithChannelIndex:0];
    });
}

//
- (void)loadData:(NSNotification *)noti{
    
    NSString *channelStr = noti.object;
    NSInteger channelInt = [channelStr integerValue];
//
//    NSLog(@"%ld", channelInt);
//    NSLog(@"%ld", self.currentRow);
//    
//    if (channelInt != self.currentRow) {
//        return;
//    }
//    NSLog(@"fff");

    [self loadDataWithChannelIndex:channelInt];
    
}



- (NSString *)getURLStringWithChannelIndex:(NSInteger)channelIndex{
    switch (channelIndex) {
        case 0:
            return @"http://api.smzdm.com/v1/home/articles?f=iphone&have_zhuanti=1&imgmode=0&limit=20&v=6.1.2&weixin=1";
            break;
        case 1:
            return @"http://api.smzdm.com/v1/youhui/articles?f=iphone&imgmode=0&limit=20&v=6.1.2&weixin=1";
            break;
        case 2:
            return @"http://api.smzdm.com/v1/haitao/articles?f=iphone&imgmode=0&limit=20&v=6.1.2&weixin=1";
            break;
        case 3:
            return @"http://api.smzdm.com/v1/yuanchuang/articles?f=iphone&imgmode=0&limit=20&v=6.1.2&weixin=1";
            break;
        case 4:
            return @"http://api.smzdm.com/v1/yuanchuang/articles?f=iphone&imgmode=0&limit=20&v=6.1.2&weixin=1";
            break;
        case 5:
            return @"http://api.smzdm.com/v1/news/articles?f=iphone&imgmode=0&limit=20&v=6.1.2&weixin=1";
            break;
        default:
            break;
    }
    return nil;
}

- (void)loadDataWithChannelIndex:(NSInteger)channelIndex{
    
    NSString *urlStr = [self getURLStringWithChannelIndex:channelIndex];
    
    [[SMNetWorkTools shareManger] request:GET urlString:urlStr parameters:nil finish:^(id response, NSError *error) {
        if (error) {
            return;
        }
        NSDictionary *tData = response[@"data" ];
        
        NSArray *tempArray = tData[@"rows"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in tempArray) {
            SMArticleModel *articleModel = [SMArticleModel articleWithDict:dict];
            [array addObject:articleModel];
        }
        
        self.dataArray = array;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
    }];

}

//- (void)hehe:(NSNotification *)noti{
//    NSIndexPath *indexPath = noti.object;
//    self.currentRow = indexPath.row;
//}

@end
