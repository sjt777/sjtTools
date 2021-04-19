//
//  MYAlipPayManager.m
//  antQueen
//
//  Created by 寇广超 on 2018/6/6.
//  Copyright © 2018年 yibyi. All rights reserved.
//

#import "MYAlipPayManager.h"
@interface MYAlipPayManager ()
{
    UIViewController *_orderPayController;
}
@end
@implementation MYAlipPayManager
+ (MYAlipPayManager *)sharedManager{
    static MYAlipPayManager *shareAlisjtPayUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAlisjtPayUtil = [[self alloc]init];
    });
    return shareAlisjtPayUtil;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)aliPayWithVc:(UIViewController *)vc signStr:(NSString *)sign paySuccessBlock:(paySuccessBlock)successBlock  payFailBlock:(payFailBlock)failBlock{
    [self clearnPasteboard];
    
    _orderPayController = vc;
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    NSString *appScheme = @"com.ruiheng.antqueen";
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        [self showResult:resultDic];
    }];
}

-(void)showResult:(NSDictionary *)dic{
    NSString *returnCode = [dic my_stringForKey:@"resultStatus"];
    if ([returnCode isEqualToString:@"9000"]) {
        !_successBlock ?:_successBlock();
    }else if([returnCode isEqualToString:@"8000"]) {
        !_successBlock ?:_successBlock();
    } else{
        !_failBlock ?:_failBlock();

    }
}

-(void)clearnPasteboard{
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];

    NSString *pastStr = [pastboard.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (pastStr.length == 17) {
        [pastboard setString:@""];
    }
}


@end
