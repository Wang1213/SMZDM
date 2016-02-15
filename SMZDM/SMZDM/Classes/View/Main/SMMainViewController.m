//
//  SMMainViewController.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/3.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMMainViewController.h"
#import "SMHomeController.h"
#import "SMDiscoveryController.h"
#import "SMDictionaryController.h"
#import "SMProfileController.h"
#import "SMTabBar.h"
#import "SMNavigationController.h"

@interface SMMainViewController ()

@end

@implementation SMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMTabBar *tabBar = [[SMTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    [self addChildControllers];
    
}

- (void)addChildControllers{
    
    SMHomeController *homeVc = [[SMHomeController alloc] init];
    SMDiscoveryController *discoveryVc = [[SMDiscoveryController alloc] init];
    SMDictionaryController *dictionaryVc = [[SMDictionaryController alloc] init];
    SMProfileController *profileVc = [[SMProfileController alloc] init];
    
    [self addChildViewController: homeVc imgName:@"main" title:@"值得买" hasNavigationcon:YES];
    [self addChildViewController:discoveryVc imgName:@"goods" title:@"发现" hasNavigationcon:YES];
    [self addChildViewController:dictionaryVc imgName:@"dingyueItem" title:@"商品百科" hasNavigationcon:NO];
    [self addChildViewController:profileVc imgName:@"person" title:@"我的" hasNavigationcon:NO];
    
}

- (void)addChildViewController:(UIViewController *)childController imgName:(NSString *)imgName title:(NSString *)title hasNavigationcon:(BOOL)hasNvai{
    
    childController.tabBarItem.title = title;
    
    childController.tabBarItem.image = [[UIImage imageNamed:[imgName stringByAppendingString:@"Normal"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[imgName stringByAppendingString:@"Selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
    if (hasNvai) {
        SMNavigationController *navigationVc = [[SMNavigationController alloc] initWithRootViewController:childController];
        [self addChildViewController:navigationVc];
    }else{
        [self addChildViewController:childController];
    }
}

@end
