//
//  MYWebBridge.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol myWebBridgeDelegate <NSObject>
/**
 webView加载完成
 */
- (void)my_webViewDidFinishLoad:(UIWebView *)webView;

/**
 webView加载失败
 */
- (void)my_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end


@interface MYWebBridge : NSObject

@property (nonatomic,weak) id<myWebBridgeDelegate> delegate;


/**
 创建myWebBridge
 
 @param webView 需要与JS进行交互的UIWebView对象
 @return myWebBridge Obj
 */
- (instancetype)initWithWebView:(UIWebView *)webView;


/**
 注册Objc方法,供JS调用

 @param aObjcFuncName Objc方法名称
 @discussion 延迟到webView加载完成后才会执行真正的注册
 */
- (void)registerObjcFuncForJS:(NSString *)aObjcFuncName;

/**
 调用JS方法

 @param aJSFuncName JS方法名称
 @param params 调用参数, 支持NSString, NSArray, NSDictionary
 @discussion 调用时需要注意js是否加载完成
 */
- (void)invokeJSFunc:(NSString *)aJSFuncName params:(nullable id)params;


/**
 响应JS调用
 无返回值则return nil
 */
@property (nonatomic,copy) id (^JSHander)(NSString *funcName,NSArray *params);

@end

NS_ASSUME_NONNULL_END
