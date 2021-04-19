//
//  ConfigurationView.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//
//  左侧配置项

#import "BackgroundView.h"
#import "EScrollDelegate.h"

@class CarListModel;
@protocol SectionClickDelegate <NSObject>

-(void)sectionClickIndex:(NSInteger)index;

@end
@interface ConfigurationView : BackgroundView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,   copy) NSArray<CarListModel *> *datas;
@property (nonatomic,   weak) id<EScrollDelegate> delegate;
@property (nonatomic,   weak) id<SectionClickDelegate> setionDelegate;

@end
