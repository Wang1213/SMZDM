//
//  SMTopBarBottomView.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/14.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMTopBarBottomView.h"
#import "UIView+Frame.h"
#import "PrefixHeader.pch"

@implementation SMTopBarBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    UIImage *img = [UIImage imageNamed:@"bkTx"];
    self.h = img.size.height;
    self.topBarBottomH = self.h;
    self.y = self.y - self.h;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/6, self.h)];
    [imgView setImage:img];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.bottomIamgeMove = ^(CGFloat moveToPosition){
        [UIImageView animateWithDuration:0.2 animations:^{
            imgView.x = moveToPosition;
        }];
    };
    
    [self addSubview:imgView];
    
    return self;
}

@end
