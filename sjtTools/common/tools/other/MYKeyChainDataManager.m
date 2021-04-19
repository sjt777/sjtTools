//
//  MYKeyChainDataManager.m
//  antQueen
//
//  Created by yixiuge on 2017/7/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//
#import "MYKeyChainDataManager.h"
#import "MYKeyChain.h"
@implementation MYKeyChainDataManager

static NSString * const KEY_IN_KEYCHAIN_IDFV = @"KEY_IDFV";
static NSString * const KEY_IDFV = @"key_idfv";



+ (NSString *)getIDFV
{
    NSString *IDFV = (NSString *)[MYKeyChain load:@"IDFV"];
    
    if ([IDFV isEqualToString:@""] || !IDFV) {
        
        IDFV = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [MYKeyChain save:@"IDFV" data:IDFV];
    }
    
    return IDFV;
}

+(NSString *)readIDFV{
    
    NSString *IDFV = (NSString *)[MYKeyChain load:@"IDFV"];

    
    return IDFV;
    
}

+(void)deleteIDFV{
    
    [MYKeyChain delete:KEY_IN_KEYCHAIN_IDFV];
    
}

@end
