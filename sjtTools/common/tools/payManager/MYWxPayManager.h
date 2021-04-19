//
//  MYWxPayManager.h
//  antQueen
//
//  Created by 寇广超 on 2018/6/6.
//  Copyright © 2018年 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef void(^paySuccessBlock)();
typedef void(^payFailBlock)();

@interface MYWxPayManager : NSObject<WXApiDelegate>
@property(nonatomic,copy)paySuccessBlock successBlock;
@property(nonatomic,copy)payFailBlock failBlock;

+ (MYWxPayManager *)sharedManager;
-(void)wxPayWithVc:(UIViewController *)vc wechatPayDic:(NSDictionary*)dic paySuccessBlock:(paySuccessBlock)successBlock  payFailBlock:(payFailBlock)failBlock;
@end
