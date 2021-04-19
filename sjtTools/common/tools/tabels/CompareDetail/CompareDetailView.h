//
//  CompareDetailView.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollDelegate.h"

@class CarListModel;
@interface CompareDetailView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,   copy) NSArray<CarListModel *> *datas;
@property (nonatomic,   weak) id<EScrollDelegate> delegate;
- (void)sectionClick:(NSInteger )tag;

@end
