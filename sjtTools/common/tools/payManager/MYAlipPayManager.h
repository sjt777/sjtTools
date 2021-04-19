//
//  MYAlipPayManager.h
//  antQueen
//
//  Created by 寇广超 on 2018/6/6.
//  Copyright © 2018年 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AlipaySDK/AlipaySDK.h>


typedef void(^paySuccessBlock)();
typedef void(^payFailBlock)();

@interface MYAlipPayManager : NSObject
@property(nonatomic,copy)paySuccessBlock successBlock;
@property(nonatomic,copy)payFailBlock failBlock;

+ (MYAlipPayManager *)sharedManager;
-(void)aliPayWithVc:(UIViewController *)vc signStr:(NSString *)sign paySuccessBlock:(paySuccessBlock)successBlock  payFailBlock:(payFailBlock)failBlock;

-(void)showResult:(NSDictionary *)dic;
@end
