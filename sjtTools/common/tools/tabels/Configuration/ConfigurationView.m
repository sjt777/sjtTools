//
//  ConfigurationView.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "ConfigurationView.h"
#import "CompareHeaderView.h"
#import "ConfigCell.h"
#import "ConfigSectionHeaderView.h"
#import "CarModel.h"

static CGFloat const kHeaderHeight = 126;

@interface ConfigurationView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,   copy) NSArray<GroupParamsModel *> *dataArr;
@property (nonatomic, strong) CompareHiddenHeader *hiddenHeader;
@property (nonatomic, strong) CompareDifferentHeader *compareHeader;

@property (nonatomic, strong) NSMutableArray *flagArray;

@end
#define ITEM_WIDTH 94

@implementation ConfigurationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 设置tableView的交互区域
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ITEM_WIDTH, self.bounds.size.height)];
        self.path = path;
        self.buttonframe = CGRectMake(0, kHeaderHeight , SCREEN_W, 45);
    }
    return self;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_flagArray[section] boolValue] == SectionIsUnFold ?  self.dataArr[section].paramList.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConfigCell *cell = [ConfigCell cellWithTableView:tableView];
    cell.titleLabel.text = self.dataArr[indexPath.section].paramList[indexPath.row].name;
    cell.backgroundColor = self.backgroundColor;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ConfigSectionHeaderView *sectionHeader = [ConfigSectionHeaderView creatView];
    sectionHeader.backgroundColor = UIColor.whiteColor;
    sectionHeader.tag = section;
    sectionHeader.titleLabel.text = self.dataArr[section].name;
    WeakSelf
    sectionHeader.unfoldBlock = ^{
        [weakSelf sectionClick:section];
    };
    return sectionHeader;
}
- (void)sectionClick:(NSInteger )tag{
    if (self.setionDelegate && [self.setionDelegate respondsToSelector:@selector(sectionClickIndex:)]) {
        [self.setionDelegate sectionClickIndex:tag];
    }
    NSInteger index = tag;
    
    _flagArray[index] = @(![_flagArray[index] boolValue]);
    [_tableView reloadData];
    //NSIndexSet *sectionReload = [NSIndexSet indexSetWithIndex:index];
    //[_tableView reloadSections:sectionReload withRowAnimation:UITableViewRowAnimationAutomatic];
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
        [self.delegate e_scrollViewDidScroll:scrollView];
    }
}

#pragma mark - setter/getter
- (void)setDatas:(NSArray<CarListModel *> *)datas {
    _datas = datas;
    
    if (datas.count > 0) {
    _dataArr = datas[0].paramList;
    }
    // 展开折叠
    _flagArray  = [NSMutableArray array];
    for (int i = 0; i < _dataArr.count; i ++) {
        [_flagArray addObject:@(SectionIsUnFold)];
    }
    [self.tableView reloadData];
    self.hiddenHeader.backgroundColor = self.backgroundColor;
    self.compareHeader.backgroundColor = self.backgroundColor;
   
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeaderHeight + 45, self.bounds.size.width, self.bounds.size.height - kHeaderHeight - 45)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.backgroundColor;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (CompareDifferentHeader *)compareHeader{
    if (!_compareHeader) {
        _compareHeader = [CompareDifferentHeader creatView];
        _compareHeader.frame = CGRectMake(0, kHeaderHeight, SCREEN_W, 45);
        _compareHeader.compareBlock = ^(NSInteger index) {
              [[NSNotificationCenter defaultCenter] postNotificationName:@"differentNotification" object:nil userInfo:@{@"isDiffrent" : @(index)}];
        };
        [self addSubview:_compareHeader];
    }
    return _compareHeader;
}
- (CompareHiddenHeader *)hiddenHeader {
    if (!_hiddenHeader) {
        _hiddenHeader = [CompareHiddenHeader creatView];
        _hiddenHeader.frame = CGRectMake(0, 0, ITEM_WIDTH, kHeaderHeight);
        _hiddenHeader.hiddenBlock = ^(UIButton *button) {
            
        };
        
        [self addSubview:_hiddenHeader];
    }
    return _hiddenHeader;
}



@end
