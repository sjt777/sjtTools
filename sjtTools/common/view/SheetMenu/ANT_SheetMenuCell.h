//
//  ANT_SheetMenuCell.h
//  antQueen
//
//  Created by 寇广超 on 2017/4/27.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIColor *itemColor;
@property (nonatomic, strong) UIFont *itemFont;

+(instancetype)sheetMenuModel:(NSString *)content color:(UIColor *)color font:(UIFont *)font;

@end

@interface ANT_SheetMenuCell : UITableViewCell

@property (nonatomic, strong) UILabel *sheetTitleL;

-(void)putSheetTitle:(SheetModel *)model;

@end
