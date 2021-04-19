//
//  CompareDetailView.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "CompareDetailView.h"
#import "CarModel.h"
#import "CompareTableHeader.h"
#import "CompareCell.h"

static CGFloat const kHeaderHeight = 126;
@interface CompareDetailView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollVeiw;
@property (nonatomic,   copy) NSArray<GroupParamsModel *> *dataArr;
@property (nonatomic, strong) CompareTableHeader *tableHeader;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *flagArray;

@end

@implementation CompareDetailView

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_flagArray[section] boolValue] == SectionIsUnFold ?  self.dataArr[section].paramList.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompareCell *cell = [CompareCell cellWithTableView:tableView];
    [cell setDatas:self.datas withIndex:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.backgroundColor = UIColor.whiteColor;
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
        [self.delegate e_scrollViewDidScroll:scrollView];
    }
}
#define ITEM_WIDTH (130 * SCREEN_W/375)
/*
CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    //屏幕适配比例
    float autoSizeScaleX;
    float autoSizeScaleY;
    if (SCREEN_H >480) {
        autoSizeScaleX = SCREEN_W/320;
        autoSizeScaleY = SCREEN_H/568;
        
    } else {
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    
    return rect;
}*/
- (void)sectionClick:(NSInteger )tag{
    NSInteger index = tag;
    

    _flagArray[index] = @(![_flagArray[index] boolValue]);
    [_tableView reloadData];
    //NSIndexSet *sectionReload = [NSIndexSet indexSetWithIndex:index];
    //[_tableView reloadSections:sectionReload withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
#pragma mark - setter/getter
- (void)setDatas:(NSArray<CarListModel *> *)datas {
    _datas = datas;
    if (!(datas.count > 0)) {
        return;
    }

    self.scrollVeiw.contentSize = CGSizeMake(datas.count * ITEM_WIDTH, 0);
    self.tableView.frame = CGRectMake(0, 45 + kHeaderHeight, datas.count * ITEM_WIDTH, self.scrollVeiw.bounds.size.height - 45 - kHeaderHeight);
    self.tableHeader.frame = CGRectMake(0, 0, datas.count * ITEM_WIDTH, kHeaderHeight);
    _dataArr = datas[0].paramList;

    // 展开折叠
    _flagArray  = [NSMutableArray array];
    for (int i = 0; i < _dataArr.count; i ++) {
        [_flagArray addObject:@(SectionIsUnFold)];
    }
    
    [self.tableHeader setDatas:datas];
    [self.tableView reloadData];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.backgroundColor;
        
        [self.scrollVeiw addSubview:_tableView];
    }
    return _tableView;
}

- (CompareTableHeader *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[CompareTableHeader alloc] init];
        [self.scrollVeiw addSubview:_tableHeader];
    }
    return _tableHeader;
}

- (UIScrollView *)scrollVeiw {
    if (!_scrollVeiw) {
        _scrollVeiw = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollVeiw.bounces = NO;
        [self addSubview:_scrollVeiw];
    }
    return _scrollVeiw;
}

@end
