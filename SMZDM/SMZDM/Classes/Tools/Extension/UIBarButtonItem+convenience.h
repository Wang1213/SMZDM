//
//  UIBarButtonItem+convenience.h
//  SMZDM
//
//  Created by 王天奇 on 16/2/6.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (convenience)

- (instancetype)initWithImage:(NSString *)imgName andTitle:(NSString *)title andTarget:(id)tag andAction:(SEL)action;

@end
