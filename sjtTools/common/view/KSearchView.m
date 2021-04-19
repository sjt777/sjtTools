//
//  KSearchView.m
//  antQueen
//
//  Created by 王明星 on 15/7/29.
//  Copyright (c) 2015年 yibyi. All rights reserved.
//

#import "KSearchView.h"

@implementation KSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)searchView
{
    return [[self alloc] init];
}

- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整布局
    
    
    //通知外界 自己被显示了
    if ([self.delegate respondsToSelector:@selector(searchViewDidShow:)]) {
        [self.delegate searchViewDidShow:self];
    }
  
}

- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(searchViewDidDismiss:)]) {
        [self.delegate searchViewDidDismiss:self];
    }
}

@end
