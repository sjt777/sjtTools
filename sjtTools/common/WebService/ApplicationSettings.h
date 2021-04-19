//
//  ApplicationSettings.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EnvironmentType) {
    EnvironmentProduct = 0,
    EnvironmentDev,                    // Dev环境
    EnvironmentQA,                       // 测试环境

    ServiceURLCounts
};


@interface ApplicationSettings : NSObject

+ (ApplicationSettings *)instance;
+ (void)clearInstance;

// service base surl
- (NSString*)currentServiceURL;

- (EnvironmentType)currentEnvironmentType;

- (void)setCurrentEnvironmentType:(EnvironmentType)type;

- (NSString *)serviceURLForEnvironmentType:(EnvironmentType)type;

/** 域名 */
- (NSArray *)hosts;

@end
