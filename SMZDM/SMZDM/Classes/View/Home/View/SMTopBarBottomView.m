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
#import "SMHomeColView.h"

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
        [UIImageView animateWithDuration:0.15 animations:^{
            imgView.x = moveToPosition;
        }];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToNext:) name:NotificationMoveToNextTopBarBtn object:nil];
    
    [self addSubview:imgView];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moveToNext:(NSNotification *)noti{
    NSString *offSetStr = noti.object;
    CGFloat offSetFlt = [offSetStr floatValue];
    self.bottomIamgeMove(offSetFlt * SelfWidth);
}

@end
