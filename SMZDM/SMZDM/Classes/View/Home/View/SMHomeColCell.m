//
//  SMHomeColCell.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/28.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMHomeColCell.h"
#import "SMHomeTableView.h"

@interface SMHomeColCell()

@property (nonatomic, strong)SMHomeTableView *homeTableView;

@end

@implementation SMHomeColCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.homeTableView = [[SMHomeTableView alloc] initWithFrame:self.bounds];
        [self addSubview:self.homeTableView];
        
    }
    return self;
}

@end
