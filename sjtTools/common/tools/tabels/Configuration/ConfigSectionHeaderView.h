//
//  SectionHeaderView.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigSectionHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) void (^unfoldBlock)();
+ (instancetype)creatView;

@end
