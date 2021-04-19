//
//  ANT_SheetMenu.h
//  antQueen
//
//  Created by 寇广超 on 2017/4/27.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANT_SheetMenuCell.h"

@protocol SheetMenuDelegate <NSObject>

-(void)didSelectMenuIndex:(NSIndexPath *)index;

@end

@interface ANT_SheetMenu : UIView <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *menuTV;

/**
 * 菜单栏 的 标题内容 @[array1,array2...] 其中 每个array为个section，array为每个section的rows(类型为SheetModel)
 */
@property (nonatomic, strong) NSMutableArray *contentsArr;
/**
 * 是否是根视图 若是则需考虑tabbar
 */
@property (nonatomic, assign) BOOL isRoot;

@property (nonatomic, assign) id<SheetMenuDelegate>myDelegate;

/**
 *  contents及是属性contentsArr
 */
-(void)showSheetMenu:(NSArray *)contents superView:(UIViewController *)superVC completionBlock:(void (^)(BOOL finish))block;
-(void)dismissSheetMenuCompletionBlock:(void (^)(BOOL finish))block;

@end
