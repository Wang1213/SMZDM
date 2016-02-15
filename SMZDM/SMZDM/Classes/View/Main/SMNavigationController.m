//
//  SMNavigationController.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/6.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMNavigationController.h"
#import "PrefixHeader.pch"

@interface SMNavigationController ()

@end

@implementation SMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_zhi"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [self.navigationBar setBackgroundColor:[UIColor colorWithRed:230.0/256.0 green:47.0/256.0 blue:56.0/256.0 alpha:0.7]];
    
    UIImageView *statusBarBg = [[UIImageView alloc] init];
    [statusBarBg setBackgroundColor:[UIColor colorWithRed:230.0/256.0 green:47.0/256.0 blue:56.0/256.0 alpha:0.7]];
    statusBarBg.frame = CGRectMake(0, -20, ScreenWidth, 20);
    [self.navigationBar addSubview:statusBarBg];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
