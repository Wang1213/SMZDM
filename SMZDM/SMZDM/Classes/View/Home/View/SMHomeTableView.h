//
//  SMHomeTableView.h
//  SMZDM
//
//  Created by 王天奇 on 16/2/23.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMHomeTableView : UITableView

//每个cell都持有一个共同的CollectionView当前所显示的cell的索引，用于在加载数据时判断自己是否要执行loadData，和决定执行loadData里的内容
@property (nonatomic, assign)NSInteger currentRow;

@end
