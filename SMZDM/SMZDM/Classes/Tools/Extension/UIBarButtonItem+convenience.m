//
//  UIBarButtonItem+convenience.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/6.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "UIBarButtonItem+convenience.h"

@implementation UIBarButtonItem (convenience)

- (instancetype)initWithImage:(NSString *)imgName andTitle:(NSString *)title andTarget:(id)tag andAction:(SEL)action{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:tag action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (imgName) {
        NSString *imgNameNormal = [imgName stringByAppendingString:@"_l"];
        NSString *imgNameHighlighted = [imgName stringByAppendingString:@"_h"];
        [btn setImage:[UIImage imageNamed:imgNameNormal] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgNameHighlighted] forState:UIControlStateHighlighted];
    }
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    }
    
    [btn sizeToFit];
    return [self initWithCustomView:btn];
}

@end

