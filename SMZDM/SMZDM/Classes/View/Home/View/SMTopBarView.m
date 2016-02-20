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

@interface SMTopBarView()

@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) SMTopBarBottomView *topBarBottomView;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation SMTopBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self setupUI];
    
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

    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationClickTopBarButton object:@"Click"];
    
    self.currentBtn.selected = NO;
    self.currentBtn = btn;
    btn.selected = YES;
    
    CGFloat scrollProportionFlt = (btn.frame.origin.x)/SelfWidth;
    NSString *scrollProportionStr = [NSString stringWithFormat:@"%f",scrollProportionFlt];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationScrollHomeColViewPage object:scrollProportionStr];
}

@end
