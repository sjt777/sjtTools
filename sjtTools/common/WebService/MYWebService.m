//
//  MYWebService.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYWebService.h"
#import "AFNetworking.h"

#import "MYBaseWebService.h"


// Third Framework
//#import <AlicloudHttpDNS/AlicloudHttpDNS.h>

#import <CommonCrypto/CommonCrypto.h>
#import "ApplicationSettings.h"

// sync response
#define MYNC_RESPONSE_MSG               @"msg"
#define MYNC_RESPONSE_CODE              @"code"
#define MYNC_RESPONSE_DATA              @"data"


#define kSecret   @""
static NSMutableArray   *requestTasksPool;//请求任务池
static MYNetworkStatus  networkStatus;
#define MY_ERROR [NSError errorWithDomain:@"com.hmy.MYWebService.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:@"网络出现错误，请检查网络连接"}]
#define DIC_HAS_STRING(dic, key)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSString class]])

#define DIC_HAS_NUMBER(dic, key)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSNumber class]])

#define DIC_HAS_ARRAY(dic, key)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSArray class]])

#define DIC_HAS_DIC(dic, key)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSDictionary class]])

#define DIC_HAS_MEM(dic, key, className)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[className class]])

#define DIC_MEM_NOT_NULL(dic, key) ([dic objectForKey:key] && ![[dic objectForKey:key] isKindOfClass:[NSNull class]])
@implementation NSURLRequest (decide)
//判断是否是同一个请求（依据是请求url和参数是否相同）
- (BOOL)isTheSameRequest:(NSURLRequest *)request {
    if ([self.HTTPMethod isEqualToString:request.HTTPMethod]) {
        if ([self.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
            if ([self.HTTPMethod isEqualToString:@"GET"] || [self.HTTPBody isEqualToData:request.HTTPBody]) {
                NSLog(@"同一个请求还没执行完，又来请求☹️");
                return YES;
            }
        }
    }
    return NO;
}

@end

@implementation MYWebService

#pragma mark - Initial Methods

+ (MYBaseWebService *)webService
{
    static MYBaseWebService *webService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *userAgent = @"";
        //[NSString stringWithFormat:@"%@/%@; iOS %@; %.0fX%.0f/%0.1f", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleNameKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] systemVersion], SCREEN_WIDTH*[[UIScreen mainScreen] scale],SCREEN_HEIGHT*[[UIScreen mainScreen] scale], [[UIScreen mainScreen] scale]];
        if (userAgent) {
            if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                NSMutableString *mutableUserAgent = [userAgent mutableCopy];
                if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                    userAgent = mutableUserAgent;
                }
            }
        }
        

        NSString *userAgentStr = @"";//[NSString stringWithFormat:@"%@\\%@; %@; %@", originalUserAgent, [MYAppDeviceHelper modelString], userAgent,[NSString stringWithFormat:@"IsJailbroken/%d",[MYAppDeviceHelper isJailbroken]]];
        NSString *deviceIDStr = [self MD5ForLower32Bate:[MYKeyChainDataManager getIDFV]];//保证32位
        webService = [[MYBaseWebService alloc] createWebServiceWithUserAgent:userAgentStr
                                                                deviceID:deviceIDStr];
    });
    
    return webService;
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
#pragma mark - Core

+ (void)handleSuccess:(BOOL)isPost
                 path:(NSString*)path
           parameters:(NSDictionary*)parameters
            operation:(NSURLSessionDataTask *)op
                 json:(id)json
              success:(void (^)(ErrorCode code, NSString * msg, id data))success
              failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
               finish:(void (^)(ErrorCode, NSString *, BOOL))finish

{
    NSLog(@"%@ handleSuccess", path);
    
    [MYWebService onResponseData:json
                              success:success
                              failure:failure
                               finish:finish];
    
}

+ (void)handleFailure:(BOOL)isPost
                 path:(NSString*)path
           parameters:(NSDictionary*)parameters
            operation:(NSURLSessionDataTask *)op
                error:(NSError*)error
              success:(void (^)(ErrorCode code, NSString * msg, id data))success
              failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
               finish:(void (^)(ErrorCode, NSString *, BOOL))finish
{
    if([error.domain isEqualToString:@"NSURLErrorDomain"]
       && error.code == kNetworkingCancelError)
    {//增加上传取消操作后的error code 判断
//        failure(kNetworkingCancelError, @"网络请求取消", nil);
        return;
    }
    failure(kNetWorkError, @"网络错误", nil);
    finish(kNetWorkError, @"网络错误", NO);
}

#pragma mark - 检查网络
+(void)checkNetworkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus = MYNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusUnknown:
                networkStatus = MYNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus = MYNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus = MYNetworkStatusReachableViaWiFi;
                break;
            default:
                networkStatus = MYNetworkStatusUnknown;
                break;
        }
        
    }];
}
#pragma mark - Public Methods

#pragma mark - POST

+ (NSURLSessionDataTask *)postRequest:(NSString*)path
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                              success:(void (^)(ErrorCode code, NSString * msg, id data))success
                              failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                                finish:(void (^)(ErrorCode, NSString *, BOOL))finish

{
    NSLog(@"Request Start %@", [NSDate date]);
    NSLog(@"Request %@", path);
    NSLog(@"Params %@", parameters);
    [self checkNetworkStatus];

    __block NSURLSessionDataTask *session = nil;
    
    if (networkStatus == MYNetworkStatusNotReachable) {
        if (failure) failure(kNetworkingCancelError, @"网络出现错误，请检查网络连接", nil);
        return session;
    }
    MYWebServiceModel *model = [MYWebService createWebServiceModelWithPath:path];
        //parameters = [MYWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[MYWebService webService]
                                  postWithWebServiceModel:model
                                  parameters:parameters
                                  progress:uploadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      if ([[self allTasks] containsObject:task]) {
                                          [[self allTasks] removeObject:task];
                                      }
                                      [MYWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                     
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"Request End Faile %@ %@", [NSDate date] , error);
                                      [[self allTasks] removeObject:task];
                                      [MYWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                      

                                  }];
    NSLog(@"Header %@",task.originalRequest.allHTTPHeaderFields );

    if ([self haveSameRequestInTasksPool:task] ) {
        [task cancel];
        return task;
    }else {
        NSURLSessionDataTask *oldTask = [self cancleSameRequestInTasksPool:task];
        if (oldTask) [[self allTasks] removeObject:oldTask];
        if (task) [[self allTasks] addObject:task];
        [task resume];
        return task;
    }
    return task;
}

#pragma mark - GET

+ (NSURLSessionDataTask *)getRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                            progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                             success:(void (^)(ErrorCode code, NSString * msg, id data))success
                             failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                              finish:(void (^)(ErrorCode, NSString *, BOOL))finish
{
    NSLog(@"Request Start %@", [NSDate date]);
    NSLog(@"Request %@", path);
    NSLog(@"Params %@", parameters);
    __block NSURLSessionDataTask *session = nil;
    
    if (networkStatus == MYNetworkStatusNotReachable) {
        if (failure) failure(kNetworkingCancelError, @"网络出现错误，请检查网络连接", nil);
        return session;
    }
    MYWebServiceModel *model = [MYWebService createWebServiceModelWithPath:path];
    
    //    //parameters = [MYWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[MYWebService webService]
                                  getWithWebServiceModel:model
                                  parameters:parameters
                                  progress:downloadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleSuccess:NO
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure
                                                                finish:finish];

                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"Request End Faile %@", [NSDate date]);
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleFailure:NO
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure
                                                                finish:finish];

                                  }];
    NSLog(@"Header %@",task.originalRequest.allHTTPHeaderFields );

    if ([self haveSameRequestInTasksPool:task] ) {
        [task cancel];
        return task;
    }else {
        NSURLSessionDataTask *oldTask = [self cancleSameRequestInTasksPool:task];
        if (oldTask) [[self allTasks] removeObject:oldTask];
        if (task) [[self allTasks] addObject:task];
        [task resume];
        return task;
    }
    
    return task;
}


#pragma mark - UPLOAD

+ (NSURLSessionDataTask *)uploadRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                          formDataArray:(NSArray *)formDataArray
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(void (^)(ErrorCode code, NSString *msg, id data))success
                                failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                                 finish:(void (^)(ErrorCode, NSString *, BOOL))finish
{
    NSLog(@"Request Start %@", [NSDate date]);
    NSLog(@"Request %@", path);
    NSLog(@"Params %@", parameters);
    __block NSURLSessionDataTask *session = nil;
    
    if (networkStatus == MYNetworkStatusNotReachable) {
        if (failure) failure(kNetworkingCancelError, @"网络出现错误，请检查网络连接", nil);
        return session;
    }
    MYWebServiceModel *model = [MYWebService createWebServiceModelWithPath:path];
    
    //parameters = nil; // Don't send paramenter, If send parameters, the server returns error
    
    NSURLSessionDataTask *task = [[MYWebService webService]
                                  uploadWithWebServiceModel:model
                                  parameters:parameters
                                  formDataArray:formDataArray
                                  progress:uploadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      NSLog(@"Request End Success %@", [NSDate date]);
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                      

                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"Request End Faile %@", [NSDate date]);
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure
                                                                finish:finish];

                                  }];
    
    
    
    [task resume];
    
    if (task) [[self allTasks] addObject:task];
    return task;
}



#pragma mark - PUT

+ (NSURLSessionDataTask *)putRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                             success:(void (^)(ErrorCode code, NSString * msg, id data))success
                             failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                              finish:(void (^)(ErrorCode, NSString *, BOOL))finish
{
    NSLog(@"Request Start %@", [NSDate date]);
    NSLog(@"Request %@", path);
    NSLog(@"Params %@", parameters);
    __block NSURLSessionDataTask *session = nil;
    
    if (networkStatus == MYNetworkStatusNotReachable) {
        if (failure) failure(kNetworkingCancelError, @"网络出现错误，请检查网络连接", nil);
        return session;
    }
    MYWebServiceModel *model = [MYWebService createWebServiceModelWithPath:path];
    
        //parameters = [MYWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[MYWebService webService]
                                  putWithWebServiceModel:model
                                  parameters:parameters
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"Request End Faile %@", [NSDate date]);
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                  }];
    if ([self haveSameRequestInTasksPool:task] ) {
        [task cancel];
        return task;
    }else {
        NSURLSessionDataTask *oldTask = [self cancleSameRequestInTasksPool:task];
        if (oldTask) [[self allTasks] removeObject:oldTask];
        if (task) [[self allTasks] addObject:task];
        [task resume];
        return task;
    }
    return task;
}


#pragma mark - DELETE

+ (NSURLSessionDataTask *)deleteRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                                success:(void (^)(ErrorCode code, NSString * msg, id data))success
                                failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                                 finish:(void (^)(ErrorCode, NSString *, BOOL))finish
{
    NSLog(@"Request Start %@", [NSDate date]);
    NSLog(@"Request %@", path);
    NSLog(@"Params %@", parameters);
    __block NSURLSessionDataTask *session = nil;
    
    if (networkStatus == MYNetworkStatusNotReachable) {
        if (failure) failure(kNetworkingCancelError, @"网络出现错误，请检查网络连接", nil);
        return session;
    }
    MYWebServiceModel *model = [MYWebService createWebServiceModelWithPath:path];
    
        //parameters = [MYWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[MYWebService webService]
                                  deleteWithWebServiceModel:model
                                  parameters:parameters
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"Request End Faile %@", [NSDate date]);
                                      [[self allTasks] removeObject:task];

                                      [MYWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure
                                                                finish:finish];
                                  }];
    if ([self haveSameRequestInTasksPool:task] ) {
        [task cancel];
        return task;
    }else {
        NSURLSessionDataTask *oldTask = [self cancleSameRequestInTasksPool:task];
        if (oldTask) [[self allTasks] removeObject:oldTask];
        if (task) [[self allTasks] addObject:task];
        [task resume];
        return task;
    }
    return task;
}


#pragma mark - Private Methods

+ (NSDictionary *)signDictionary:(NSDictionary *)dic
{
    if ((nil == dic)
        || [dic isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dicReal = [NSMutableDictionary dictionaryWithDictionary:dic];
        if (dicReal == nil) {
            dicReal = [NSMutableDictionary dictionary];
        }
        
        //addtime
        NSString * timeStr = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
        [dicReal addEntriesFromDictionary:@{@"time":timeStr,
                                            SYNC_DEVICE_TYPE:@0,   //ios 0
                                            SYNC_APP_VERSION:@"",
                                            @"protocol_version":@"2.0.0",
                                            SYNC_DEVICE_ID:@"",
                                            }];
        
        if ([dic objectForKey:SYNC_USER_TOKEN] == nil) {
            NSString *tokenStr = @"";
            if (nil != tokenStr) {
                [dicReal setObject:tokenStr forKey:SYNC_USER_TOKEN];
            }
        }
        
        NSString * md5String = [MYWebService calcSignStringWithArr:dicReal];
        [dicReal addEntriesFromDictionary:@{@"sign":md5String}];
        
        return dicReal;
    } else {
        return [NSDictionary dictionary];
    }
}

+ (NSString *)calcSignStringWithArr:(NSDictionary *)dicReal
{
    NSMutableString *start = [[NSMutableString alloc] init];
    NSArray *keys = [dicReal allKeys];
    
    //keys按字母顺序排序
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
            {
                NSString * str1 = (NSString *)obj1;
                NSString * str2 = (NSString *)obj2;
                return [str1 compare:str2];
            }];
    for (NSString *key in keys) {
        [start appendFormat:@"%@=%@&", key, [dicReal objectForKey:key]];
    }
    
    [start appendFormat:@"%@", kSecret];
    
    NSString * md5String = [self md5: start];
    
    return md5String;
}
+(NSString *)md5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]] lowercaseString];
}

+ (void)onResponseData:(id)responseObject
               success:(void (^)(ErrorCode code, NSString * msg, id data))success
               failure:(void (^)(ErrorCode code, NSString *msg, id data))failure
                finish:(void (^)(ErrorCode, NSString *, BOOL))finish

{
    id json = responseObject;
    
    if(json && [json isKindOfClass:[NSDictionary class]]) {
        id message = [json objectForKey:MYNC_RESPONSE_MSG];
        NSString * msg = [message isKindOfClass:[NSString class]] ? message : @"";
        int code = [[json objectForKey:MYNC_RESPONSE_CODE] intValue];
        id data = [json objectForKey:MYNC_RESPONSE_DATA];
       // NSDictionary * data = [json objectForKey:MYNC_RESPONSE_DATA];
        
        if(DIC_HAS_NUMBER(json, MYNC_RESPONSE_CODE)) {

            success(code, msg, data);
            finish(code, msg, YES);
          
        }else {
            failure(code, msg, nil);
            finish(code, msg, YES);

        }
    }else if(json && [json isKindOfClass:[NSArray class]]){
        id message = [json objectForKey:MYNC_RESPONSE_MSG];
        NSString * msg = [message isKindOfClass:[NSString class]] ? message : @"";
        int code = [[json objectForKey:MYNC_RESPONSE_CODE] intValue];
       // NSArray * data = [json objectForKey:MYNC_RESPONSE_DATA];
        id data = [json objectForKey:MYNC_RESPONSE_DATA];

        if(DIC_HAS_NUMBER(json, MYNC_RESPONSE_CODE)) {
           
            success(code, msg, data);
            finish(code, msg, YES);

            
        }else {
            failure(code, msg, nil);
            finish(code, msg, YES);

        }
    }else {
        failure(kUnknownError, @"未知错误-1002", nil);
        finish(kUnknownError, @"未知错误-1001", YES);

    }
}

+ (NSString *)webServiceCurrentDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *now = [[NSDate alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [dateFormatter stringFromDate:now];
}

+ (MYWebServiceModel *)createWebServiceModelWithPath:(NSString *)pathStr
{
    // base url
    NSString *baseURLStr = [[ApplicationSettings instance] currentServiceURL];
    
    // ip address
    NSString *ipAddressStr = nil;
    if (EnvironmentProduct == [[ApplicationSettings instance] currentEnvironmentType]) {
        ipAddressStr = [MYWebService fetchIPByURLStr:baseURLStr];
    }
    
    // web service model
    MYWebServiceModel *model = [[MYWebServiceModel alloc] init];
    model.baseURLStr = baseURLStr;
    model.ipAddressStr = ipAddressStr;
    model.pathStr = pathStr;
    
    return model;
}

+ (NSString *)fetchIPByURLStr:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
//    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
//
//    NSString *ipStr = [httpdns getIpByHostAsyncInURLFormat:url.host];
    
    return @"";
}
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasksPool == nil) requestTasksPool = [NSMutableArray array];
    });
    
    return requestTasksPool;
}
+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionDataTask class]]) {
                [obj cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionDataTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                    *stop = YES;
                }
            }
        }];
    }
}
+ (BOOL)haveSameRequestInTasksPool:(NSURLSessionDataTask *)task {
    __block BOOL isSame = NO;
    [[self currentRunningTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task.originalRequest isTheSameRequest:obj.originalRequest]) {
            isSame  = YES;
            *stop = YES;
        }
    }];
    return isSame;
}

+ (NSURLSessionDataTask *)cancleSameRequestInTasksPool:(NSURLSessionDataTask *)task {
    __block NSURLSessionDataTask *oldTask = nil;
    
    [[self currentRunningTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task.originalRequest isTheSameRequest:obj.originalRequest]) {
            if (obj.state == NSURLSessionTaskStateRunning) {
                [obj cancel];
                oldTask = obj;
            }
            *stop = YES;
        }
    }];
    
    return oldTask;
}
+ (NSArray *)currentRunningTasks {
    return [[self allTasks] copy];
}
@end
