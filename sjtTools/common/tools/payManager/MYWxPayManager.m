//
//  MYWxPayManager.m
//  antQueen
//
//  Created by 寇广超 on 2018/6/6.
//  Copyright © 2018年 yibyi. All rights reserved.
//

#import "MYWxPayManager.h"
@interface MYWxPayManager ()
{
    UIViewController *_orderPayController;
}
@end
@implementation MYWxPayManager
+ (MYWxPayManager *)sharedManager{
    static MYWxPayManager *shareAlisjtPayUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAlisjtPayUtil = [[self alloc]init];
    });
    return shareAlisjtPayUtil;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxCompletion:) name:NOTIFICATION_WXPayResult object:nil];
    }
    return self;
}
-(void)wxPayWithVc:(UIViewController *)vc wechatPayDic:(NSDictionary*)wechatPayDic paySuccessBlock:(paySuccessBlock)successBlock  payFailBlock:(payFailBlock)failBlock{
    
    [self clearnPasteboard];
    
    _orderPayController = vc;
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    
    PayReq *req = [[PayReq alloc]init];

    req.partnerId = [wechatPayDic objectForKey:@"partnerid"];
    req.prepayId = [wechatPayDic objectForKey:@"prepayid"];
    req.package = [wechatPayDic objectForKey:@"package"];
    req.nonceStr = [wechatPayDic objectForKey:@"noncestr"];
    req.timeStamp = (UInt32)[[wechatPayDic objectForKey:@"timestamp"] intValue];
    req.sign = [wechatPayDic objectForKey:@"sign"];
    [WXApi sendReq:req completion:nil];
}

-(void)wxCompletion:(NSNotification *)sender{
    if (sender.object) {
        [self onResp:sender.object];
    }
}

-(void)onResp:(BaseResp *)resp{
     PayResp *response = (PayResp *)resp;
    switch (response.errCode) {
        case WXSuccess:
            !_successBlock ?:_successBlock();
            break;
        case WXErrCodeUserCancel:
            !_failBlock ?:_failBlock();
            break;
        default:{
            !_failBlock ?:_failBlock();
        }
            break;
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
