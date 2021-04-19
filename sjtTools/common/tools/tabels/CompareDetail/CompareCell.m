//
//  CompareCell.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "CompareCell.h"
#import "CarModel.h"

#define ITEM_WIDTH (130 * SCREEN_W/375)

@interface CompareItem : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)creatView;

@end

@implementation CompareItem

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareItem" owner:nil options:nil] objectAtIndex:0];
}

@end


@implementation CompareCell{
    NSMutableArray *_itemLbArr;
    NSMutableArray *_itemStrArr;

}

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"CompareCell";
    CompareCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CompareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setDatas:(NSArray<CarListModel *> *)datas withIndex:(NSIndexPath *)indexPath {
    _itemLbArr = [NSMutableArray array];
    _itemStrArr = [NSMutableArray array];
    NSMutableArray *dataArr = datas.mutableCopy;
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[CompareItem class]]) {
            [view removeFromSuperview];
        }
    }
    for (NSInteger i = 0; i < datas.count; i ++) {
        CompareItem *item = [CompareItem creatView];
        item.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 45);
        item.titleLabel.text = datas[i].paramList[indexPath.section].paramList[indexPath.row].value;
       
        [_itemLbArr addObject: item.titleLabel];
        [_itemStrArr addObject: item.titleLabel.text];

        [self.contentView addSubview:item];
    }

    NSString *tempStr;

    for (NSString *value in _itemStrArr) {
        if (tempStr && ![tempStr isEqualToString:value]) {
            for (UILabel *lb in _itemLbArr) {
                lb.backgroundColor = hexColorAlpha(FF4940, 0.1);
            }
            break;
        }
        tempStr = value;
    }

}

@end
