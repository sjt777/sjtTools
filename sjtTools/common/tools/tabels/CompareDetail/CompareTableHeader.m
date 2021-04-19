//
//  CompareTableHeader.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "CompareTableHeader.h"
#import "CarModel.h"
#import "CompareHeaderView.h"
#define ITEM_WIDTH (130 * SCREEN_W/375)

@implementation CompareTableHeader

- (void)setDatas:(NSArray<CarListModel *> *)datas {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CompareRightHeader class]] || [view isKindOfClass:[CompareAddHeader class]]) {
            [view removeFromSuperview];
        }
    }
    NSMutableArray *btnArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < datas.count; i ++) {
        __block CompareRightHeader *header = [CompareRightHeader creatView];
        __weak CompareRightHeader *weakheader = header;
        if (datas[i].isSelect == 1) {
            header.selectBtn.backgroundColor = hexColor(ff4940);
            [header.selectBtn setTitle:@"已选车型" forState:UIControlStateNormal];
        }
        header.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 126);
        header.modelNameLabel.text = datas[i].model_name;
        [btnArray addObject: header.selectBtn];

        header.selectBlock = ^{
            weakheader.selectBtn.backgroundColor = hexColor(ff4940);
            [weakheader.selectBtn setTitle:@"已选车型" forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"selecNotification" object:nil userInfo:@{@"index" : @(i)}];
            [self initBtnUIWithArray:btnArray btn:weakheader.selectBtn];
        };
        [self addSubview:header];
    }
}
-(void)initBtnUIWithArray:(NSArray <UIButton *>*)arr btn:(UIButton *)btn{
    for (UIButton *button in arr) {
        if (button != btn) {
            button.backgroundColor = hexColor(FF920D);
            [button setTitle:@"选此车型" forState:UIControlStateNormal];
        }
    }
}
@end
