//
//  User.h
//  antQueen
//
//  Created by yibyi on 15/4/1.
//  Copyright (c) 2015年 yibyi. All rights reserved.
//

#import "Util.h"
#import "YYModel.h"
@interface User : NSObject
@property (strong,nonatomic) NSString *user_token;

@property (strong,nonatomic) NSString *uid ;
@property (strong,nonatomic) NSString *tel ;
@property (strong,nonatomic) NSString *pwd ;
@property (strong,nonatomic) NSString *key ;
@property (strong,nonatomic) NSString *nickName ;
#pragma mark - new
@property (strong,nonatomic) NSString *is_online;// 1 为隐藏充值 0 为显示
@property(strong,nonatomic)NSString *is_insurance;

@property (nonatomic, strong) NSString  *pid; //不等于 0  即为子账号
@property (nonatomic, strong) NSString  *cardealer;

@property (nonatomic, strong) NSString  *type;//0 普通用户子账号 1 车商 2特殊车商
@property (nonatomic, strong) NSString  *is_new_cardealer;
@property (nonatomic, strong) NSString  *vip_type; // vip 发车vip
@property (nonatomic, assign) BOOL is_show_price; //
@end
