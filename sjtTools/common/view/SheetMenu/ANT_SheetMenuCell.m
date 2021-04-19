//
//  ANT_SheetMenuCell.m
//  antQueen
//
//  Created by 寇广超 on 2017/4/27.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "ANT_SheetMenuCell.h"

@implementation SheetModel

+(instancetype)sheetMenuModel:(NSString *)content color:(UIColor *)color font:(UIFont *)font
{
    SheetModel *model = [[SheetModel alloc] init];
    model.content = content;
    if (!color) {
        color = hexColor(4391e8);
    }
    model.itemColor = color;
    if (!font) {
        font = [UIFont systemFontOfSize:15.f];
    }
    model.itemFont = font;
    return model;
}

@end

@implementation ANT_SheetMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return self;
}

-(void)putSheetTitle:(SheetModel *)model
{
    self.sheetTitleL.text = model.content;
    self.sheetTitleL.textColor = model.itemColor;
    self.sheetTitleL.font = model.itemFont;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSubviews
{
    self.sheetTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-20, self.bounds.size.height)];
    self.sheetTitleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_sheetTitleL];
    
    UIView *oneLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, SCREEN_W-20,0.5)];
    oneLine.backgroundColor = hexColor(cccccc);
    [self.contentView addSubview:oneLine];
}

@end
