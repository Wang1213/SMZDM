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

#define HomeCellID @"SMHomeCell"

@interface SMHomeTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation SMHomeTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self getData];
    [self setupUI];
    
    return self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)getData{
    NSURL *url = [NSURL URLWithString:@"http://api.smzdm.com/v1/home/articles?f=iphone&have_zhuanti=1&imgmode=0&limit=20&v=6.1.2&weixin=1"];
    NSURLRequest *rerquest = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:rerquest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data) {
            
            NSDictionary *tlist = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *tData = tlist[@"data" ];
            
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
            
        }
    }] resume];
    
}

@end
