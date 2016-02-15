//
//  SMTabBar.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/4.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMTabBar.h"

@implementation SMTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)setupUI{
    [self setBackgroundImage:[UIImage imageNamed:@"bar"]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
