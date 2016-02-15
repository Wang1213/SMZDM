//
//  SMTopBarBottomView.h
//  SMZDM
//
//  Created by 王天奇 on 16/2/14.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTopBarBottomView : UIView

@property (nonatomic, assign) CGFloat topBarBottomH;
@property (nonatomic, copy) void (^bottomIamgeMove)(CGFloat moveToPosition);

@end
