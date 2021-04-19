//
//  ANT_SheetMenu.m
//  antQueen
//
//  Created by 寇广超 on 2017/4/27.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "ANT_SheetMenu.h"

static float sheetItemHeight = 44.f;
static float sheetLeft = 10.f;

float sheetTableBtm() {
    return (SCREEN_H-20-sheetItemHeight-10);
}

@interface ANT_SheetMenu ()

@property (nonatomic, strong) UIButton *menuExitBT;

@end

@implementation ANT_SheetMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentsArr = [NSMutableArray arrayWithCapacity:1];
        [self setSubviews];
    }
    return self;
}

-(void)showSheetMenu:(NSArray *)contents superView:(UIViewController *)superVC completionBlock:(void (^)(BOOL))block
{
    [self.contentsArr removeAllObjects];
    [self.contentsArr addObjectsFromArray:contents];
    float tableY = sheetTableBtm()-10.f;
    float tableH = 0.;
    for (NSArray *section in contents) {
        tableH += section.count*sheetItemHeight;
        tableH += 10.f;
    }
    tableH -= 10.f;
    tableY -= tableH;
    self.menuTV.frame = CGRectMake(sheetLeft, tableY, _menuTV.HDview_w, tableH);
    if (self.isRoot) {
        [superVC.tabBarController.view addSubview:self];
    } else {
        [superVC.navigationController.view addSubview:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
        self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    } completion:^(BOOL finished) {
        if (block) block(finished);
    }];
}

-(void)dismissSheetMenuCompletionBlock:(void (^)(BOOL))block
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (block) block(finished);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myDelegate) {
        [self.myDelegate didSelectMenuIndex:indexPath];
    }
    [self dismissSheetMenuCompletionBlock:^(BOOL finish) {
    }];
}

-(void)cancelMenuAction:(UIButton *)button
{
    [self dismissSheetMenuCompletionBlock:^(BOOL finish) {
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contentsArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = self.contentsArr[section];
    return sections.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return sheetItemHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANT_SheetMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sheetCell"];
    if (!cell) {
        cell = [[ANT_SheetMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sheetCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    NSArray *sections = self.contentsArr[indexPath.section];
    [cell putSheetTitle:[sections objectAtIndex:indexPath.row]];
    return cell;
}

-(void)setSubviews
{
    self.backgroundColor = [UIColor clearColor];
    
    self.menuExitBT = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuExitBT.backgroundColor = [UIColor whiteColor];
    self.menuExitBT.frame = CGRectMake(sheetLeft, SCREEN_H-20-sheetItemHeight, SCREEN_W-sheetLeft*2, sheetItemHeight);
    self.menuExitBT.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.menuExitBT setTitleColor:hexColor(666666) forState:UIControlStateNormal];
    self.menuExitBT.clipsToBounds = YES;
    self.menuExitBT.layer.cornerRadius = 5.f;
    [self.menuExitBT setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:_menuExitBT];
    
    [self.menuExitBT addTarget:self action:@selector(cancelMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.menuTV = [[UITableView alloc] initWithFrame:CGRectMake(sheetLeft, sheetTableBtm()-sheetItemHeight*2, SCREEN_W-sheetLeft*2, sheetItemHeight*2)];
    self.menuTV.backgroundColor = [UIColor whiteColor];
    self.menuTV.clipsToBounds = YES;
    self.menuTV.layer.cornerRadius = 5.f;
    [self.menuTV setSeparatorStyle:UITableViewCellSeparatorStyleNone]; 
    self.menuTV.bounces = NO;
    [self addSubview:self.menuTV];
    
    self.menuTV.delegate = self;
    self.menuTV.dataSource = self;
}

@end
