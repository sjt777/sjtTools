//
//  MYWebService.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>


// ASYNC
#define SYNC_DEVICE_ID                   @"device_id"
#define SYNC_USER_ID                     @"uid"
#define SYNC_USER_TOKEN                  @"token"
#define SYNC_SITE_ID                     @"site_id"
#define SYNC_DEVICE_TYPE                 @"device_type"
#define SYNC_DEVICE_TOEKN                @"device_token"
#define SYNC_SYSTEM_VERSION              @"system_version"
#define SYNC_APP_VERSION                 @"app_version"

typedef enum
{
    kNetSuccess = 200,
    //未知错误
    kUnknownError = -1,
    
    
    //服务器返回的错误
    kNoError = 0,
    
    kParamsError = 1,
    
    kInvalidTokenError = 2,
    
    kDidNotLoginError = 3,
    
    kNetWorkError = -200,
    
    kNetworkingCancelError = -999,
    
}ErrorCode;
/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, MYNetworkStatus) {
    /**
     *  未知网络
     */
    MYNetworkStatusUnknown             = 1 << 0,
    /**
     *  无法连接
     */
    MYNetworkStatusNotReachable        = 1 << 1,
    /**
     *  WWAN网络
     */
    MYNetworkStatusReachableViaWWAN    = 1 << 2,
    /**
     *  WiFi网络
     */
    MYNetworkStatusReachableViaWiFi    = 1 << 3
};
@interface MYWebService : NSObject

+ (NSURLSessionDataTask *)postRequest:(NSString*)path
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress *))uploadProgress
                              success:(void (^)(ErrorCode code, NSString *msg, id data))success
                              failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                               finish:(void (^)(ErrorCode code, NSString *msg, BOOL success))finish;;

+ (NSURLSessionDataTask *)getRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                            progress:(void (^)(NSProgress *))downloadProgress
                             success:(void (^)(ErrorCode code, NSString *msg, id data))success
                             failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                              finish:(void (^)(ErrorCode code, NSString *msg, BOOL success))finish;

+ (NSURLSessionDataTask *)uploadRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                          formDataArray:(NSArray *)formDataArray
                               progress:(void (^)(NSProgress *))uploadProgress
                                success:(void (^)(ErrorCode code, NSString *msg, id data))success
                                failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                                 finish:(void (^)(ErrorCode code, NSString *msg, BOOL success))finish;

+ (NSURLSessionDataTask *)putRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                             success:(void (^)(ErrorCode code, NSString *msg, id data))success
                             failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                              finish:(void (^)(ErrorCode code, NSString *msg, BOOL success))finish;

+ (NSURLSessionDataTask *)deleteRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                                success:(void (^)(ErrorCode code, NSString *msg, id data))success
                                failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                                 finish:(void (^)(ErrorCode code, NSString *msg, BOOL success))finish;

@end
