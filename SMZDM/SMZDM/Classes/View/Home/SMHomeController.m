//
//  SMHomeController.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/3.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMHomeController.h"
#import "UIBarButtonItem+convenience.h"
#import "SMTopBarView.h"
#import "PrefixHeader.pch"
#import "SMHomeColView.h"

#define topBarHeight 35

@interface SMHomeController ()

@end

@implementation SMHomeController
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.tabBarItem.title = @"值得买";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupUI{
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"leftSearch" andTitle:nil andTarget:nil andAction:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"rightding" andTitle:nil andTarget:nil andAction:nil];
    self.title = @"什么值得买";
    
    CGFloat topBarY = self.navigationController.navigationBar.bounds.size.height + StatusBarHeight;
    SMTopBarView *topBar = [[SMTopBarView alloc] initWithFrame:CGRectMake(0, topBarY, ScreenWidth, topBarHeight)];
    [self.view addSubview:topBar];
    
    UICollectionViewFlowLayout *colViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGRect colViewCellFrame = CGRectMake(0, topBarHeight + topBarY, ScreenWidth, ScreenHeight);
    colViewFlowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
    colViewFlowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    colViewFlowLayout.minimumLineSpacing = 0;
    SMHomeColView *colView = [[SMHomeColView alloc] initWithFrame:colViewCellFrame collectionViewLayout:colViewFlowLayout];
    [self.view addSubview:colView];
}
@end
