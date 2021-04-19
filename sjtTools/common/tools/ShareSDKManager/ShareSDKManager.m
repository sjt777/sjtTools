//
//  ShareSDKManager.m
//  antQueen
//
//  Created by 寇广超 on 2018/12/16.
//  Copyright © 2018年 yibyi. All rights reserved.

#import "ShareSDKManager.h"
#import <ShareSDK/ShareSDK.h>

@implementation ShareSDKManager

+ (void)initShare{
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
//        [platformsRegister setupQQWithAppId:@"1106885155" appkey:@"KEYFlZrrMLqEKRv1fnP"];
        [platformsRegister setupQQWithAppId:@"1106885155" appkey:@"KEYFlZrrMLqEKRv1fnP" enableUniversalLink:YES universalLink:UNIVERSAL_LINK];
        
        //微信
        [platformsRegister setupWeChatWithAppId:@"wx04be3a0db4fece2c" appSecret:@"0398bce360f3f5d9fbcce40326929639" universalLink:UNIVERSAL_LINK];
//        [platformsRegister setupWeChatWithAppId:@"wx04be3a0db4fece2c" appSecret:@"0398bce360f3f5d9fbcce40326929639"];
        
        
    }];
    
}



     @end
