//
//  ApplicationSettings.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//


#import "ApplicationSettings.h"

//#import <AlicloudHttpDNS/AlicloudHttpDNS.h>

#pragma mark - Service Url

// http  TODO
NSString* const ServiceURLProduct      = @"https://op.51ruiheng.com/";//OP_BASE_SERVER_ADDRESS;

NSString* const ServiceURLDev          = @"http://op.dev.51ruiheng.com/";///OP_BASE_SERVER_ADDRESS;

NSString* const ServiceURLQA           = @"http://r.51ruiheng.com/";//OP_BASE_SERVER_ADDRESS;


NSString* const kServiceURL                    = @"kServiceURL";
NSString* const kServiceURLType                = @"kServiceURLType";


static ApplicationSettings * instance;

@interface ApplicationSettings() {
    
}

@end

@implementation ApplicationSettings

+ (ApplicationSettings *)instance {
    @synchronized(self) {
        if (!instance) {
            instance = [[ApplicationSettings alloc] init];
        }
    }
    return instance;
}

+ (void)clearInstance {
    @synchronized(self) {
        if (instance) {
            instance = nil;
        }
    }
}

- (NSString*)currentServiceURL
{
    NSString *urlStr = [self serviceURLForEnvironmentType:[self currentEnvironmentType]];
    
    return urlStr;
}

- (void)setCurrentServiceURL:(NSString*)urlString
{
    [[NSUserDefaults standardUserDefaults] setObject:urlString forKey:kServiceURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (EnvironmentType)currentEnvironmentType
{
#if DEBUG
    //NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey: kServiceURLType];
    
    //return (number == nil) ? EnvironmentQA : (EnvironmentType)[number intValue];
    return EnvironmentDev;
#elif UTA
    return EnvironmentQA;
#else
    return EnvironmentProduct;
#endif
}

- (void)setCurrentEnvironmentType:(EnvironmentType)type
{
    [[NSUserDefaults standardUserDefaults] setObject:@(type) forKey:kServiceURLType];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)serviceURLForEnvironmentType:(EnvironmentType) type {
    switch(type) {
        case EnvironmentProduct:    return ServiceURLProduct;
        case EnvironmentDev:       return ServiceURLDev;
        case EnvironmentQA:         return ServiceURLQA;
        default:
            break;
    }
    return @"";
}

/** 域名 */
- (NSArray *)hosts
{
    NSURL *serviceURLProductUrl   = [NSURL URLWithString:ServiceURLProduct];
    NSURL *serviceURLDev         = [NSURL URLWithString:ServiceURLDev];
    NSURL *serviceURLQA           = [NSURL URLWithString:ServiceURLQA];
    
    
    return @[serviceURLProductUrl.host,
             serviceURLDev.host,
             serviceURLQA.host,
             ];
}


@end
