//
//  SMTopBarView.m
//  SMZDM
//
//  Created by 王天奇 on 16/2/14.
//  Copyright © 2016年 王天奇. All rights reserved.
//

#import "SMTopBarView.h"
#import "PrefixHeader.pch"
#import "SMTopBarBottomView.h"
#import "UIView+Frame.h"

@interface SMTopBarView()

@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) SMTopBarBottomView *topBarBottomView;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation SMTopBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topBtnColorChanged:) name:NotificationTopBtnColorChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topBtnColorRestore) name:NotificationHomeColViewDidEndDecelerating object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getScrollDirction:) name:NotificationHomeColViewScrollDirction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTemporaryScrollDirction:) name:NotificationHomeColViewTemporaryScrollDirction object:nil];
    
    return self;
}

- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI{
    
    [self setBackgroundColor:[UIColor colorWithRed:246 green:246 blue:246 alpha:0.7]];
    
    NSArray *arr = @[@"首页",@"国内",@"海淘",@"原创",@"众测",@"资讯"];
    
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectTopBarBtn:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        if (i == 0) {
            btn.selected = YES;
            self.currentBtn = btn;
        }
        
        [self.btnArray addObject:btn];
        [self addSubview:btn];
    }
    
    //h无意义，在init中会重新赋值
    self.topBarBottomView = [[SMTopBarBottomView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, ScreenWidth, 2)];
    [self addSubview:self.topBarBottomView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    int index = 0;
    CGFloat btnWidth = self.bounds.size.width/6;
    CGFloat btnHeight = self.bounds.size.height - self.topBarBottomView.topBarBottomH;
    CGFloat btnY = 0;
    
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UIButton")]) {
            CGFloat btnX = index * btnWidth;
            btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            index++;
        }
    }
}

- (void)selectTopBarBtn:(UIButton *)btn{

    [self changeSelestedBtn:btn];
    CGFloat scrollProportionFlt = (btn.frame.origin.x)/SelfWidth;
    NSString *scrollProportionStr = [NSString stringWithFormat:@"%f",scrollProportionFlt];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationJudgeClick object:@"click"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationScrollHomeColViewPage object:scrollProportionStr];
}

- (void)changeSelestedBtn:(UIButton *)btn{
    self.currentBtn.selected = NO;
    self.currentBtn = btn;
    self.currentBtn.selected = YES;
}

- (void)topBtnColorChanged:(NSNotification *)noti{
    NSString *offSetStr = noti.object;
    CGFloat offSetFlt = [offSetStr floatValue];
    
    self.currentBtn.titleLabel.textColor = [[UIColor alloc] initWithRed:(100/offSetFlt/100 + 130)/255.0 green:53.0/255.0 blue:44/255.0 alpha:1.0];
    self.nextButton.titleLabel.textColor = [[UIColor alloc] initWithRed:(255 - (100/offSetFlt/100 + 130))/255.0 green:53.0/255.0 blue:44/255.0 alpha:1.0];
}

- (void)topBtnColorRestore{
    [self resetBtnColor:self.currentBtn];
}

- (void)resetBtnColor:(UIButton *)btn{
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.titleLabel.textColor = [UIColor redColor];
}

- (void)getScrollDirction:(NSNotification *)noti{
    NSString *direction = noti.object;
    NSInteger tag = self.currentBtn.tag;
    [self resetBtnColor:self.currentBtn];
    
    if ([direction isEqualToString:@"right"] && tag < 5) {
        [self changeSelestedBtn:self.btnArray[++tag]];
    }else if ([direction isEqualToString:@"left"] && tag > 0){
        [self changeSelestedBtn:self.btnArray[--tag]];
    }
}

- (void)getTemporaryScrollDirction:(NSNotification *)noti{
    NSString *direction = noti.object;
    NSInteger tag = self.currentBtn.tag;
    
    if ([direction isEqualToString:@"right"] && tag < 5) {
        self.nextButton = self.btnArray[++tag];
    }else if ([direction isEqualToString:@"left"] && tag > 0){
        self.nextButton = self.btnArray[--tag];
    }
}

@end
