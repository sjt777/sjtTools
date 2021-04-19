//
//  CompareCell.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarListModel;
@interface CompareCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setDatas:(NSArray<CarListModel *> *)datas withIndex:(NSIndexPath *)indexPath;

@end
