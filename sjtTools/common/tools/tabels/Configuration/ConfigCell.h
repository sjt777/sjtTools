//
//  ConfigCell.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
