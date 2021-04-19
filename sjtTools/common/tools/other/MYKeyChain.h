//
//  MYKeyChain.h
//  antQueen
//
//  Created by 寇广超 on 2017/7/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;
@end
