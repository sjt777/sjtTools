//
//  MYBannerWebView.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/10.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "BaseVC.h"
#import "dsbridge.h"
#import "MYJsApiRegister.h"
NS_ASSUME_NONNULL_BEGIN

@interface MYBannerWebViewVc : BaseVC<WKNavigationDelegate>
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *lastpath;
@property (nonatomic, strong) MYJsApiRegister *jsApi;
@property(nonatomic,assign) BOOL hideShare;
@property(nonatomic,strong) NSString *user_id;
@property(nonatomic,strong) NSString *user_token;
@property(nonatomic,strong) NSDictionary *shareDic;

@property (nonatomic, assign) BOOL registerSucceed;
@property (nonatomic, assign) BOOL isCombo;
@property(nonatomic,copy) void(^rechargeBlock)(BOOL succeed);
@property (nonatomic, strong) NSString *UMLogPageStr;
-(void)zhifubao:(NSString *)money;
- (void)payByWeiXin:(NSString *)money;
@end

NS_ASSUME_NONNULL_END
