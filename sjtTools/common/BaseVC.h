//
//  BaseVC.h
//  template
//
//  Created by yxj on 15-3-25.
//  Copyright (c) 2015年 yxj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"

#import "User.h"

#import "MBProgressHUD.h"

#import "URL.h"
#import "Biz.h"
#import "AFNetworking.h"
#import "UIScrollView+EmptyDataSet.h"
#import "NSDictionary+SCAddition.h"
#import "UIImage+Color.h"
#import "UIView+HDAddition.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+HBD.h"

#define cellTextFont [UIFont systemFontOfSize:14.0]

#define NOTIFICATION_Query  @"QueryJlVC"

#define NOTIFICATION_LoginSuccess @"Notify_LoginSuccess"
#define IS_IOS7_OR_LATER            ([[UIDevice currentDevice].systemVersion floatValue] >=8.2)

#define IS_IOS10_OR_LATER            ([[UIDevice currentDevice].systemVersion floatValue] >=10.0)


//判断是否是iPhone4
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否是iPhone5
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//是否iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ? CGSizeEqualToSize(CGSizeMake(375*2, 667*2),[[UIScreen mainScreen] nativeBounds].size) : NO)

//是否iPhone6plus
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ? CGSizeEqualToSize(CGSizeMake(414.000000*3, 736.000000*3),[[UIScreen mainScreen] currentMode].size) : NO)

#define NOTIFICATION_WXPayResult @"WXPayResult"
#define NOTIFICATION_WXPayResult_Query @"WXPayResult_Query"

#define APP_VERSION @"others_2_6_1"

#import <UMMobClick/MobClick.h>
#import "MobDefine.h"
#import "UIView+HDAddition.h"
//#define DEBUG @"debug"



#define WeakSelf __weak __typeof(&*self) weakSelf = self;
#define StrongSelf  __strong __typeof(&*self) strongSelf = weakSelf;
#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define ANT_HEADER_H (self.view.frame.size.width * 0.5 +SafeAreaTopHeight )

@interface BaseVC : UIViewController<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

typedef enum {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_2G= 1,
    NETWORK_TYPE_3G= 2,
    NETWORK_TYPE_4G= 3,
    NETWORK_TYPE_5G= 4,//  5G目前为猜测结果
    NETWORK_TYPE_WIFI= 5,
}NETWORK_TYPE;

typedef enum : NSUInteger {
    Car_Subscribe,
    Car_OnLine,
    Car_OutLine
} Car_VC_Type;

typedef enum : NSUInteger {
    Subscribe,
    OnLine,
    OutLine
} WholeCar_VC_Type;

@property (strong,nonatomic) Util *util ;
@property (strong,nonatomic) User *loginuser ;
@property (nonatomic, strong) MBProgressHUD *dialog;


@property (nonatomic,strong) NSURLSessionDataTask *op;
@property (nonatomic,assign) SEL httpSelecter;
@property (nonatomic,strong) NSMutableDictionary *params;
#pragma mark 用户信息
- (void) setLoginUser:(User *)loginuser;
- (User *) getLoginUser;
-(NSString *)getToken ;

#pragma mark ------- 对话框 -----
- (void) toastText:(NSString *)message view:(UIView *)view;
- (void)sjtToastMBText:(NSString *)message view:(UIView *)view;
- (void) toastMBText:(NSString *)message view:(UIView *)view;
- (void)makeToastMBText:(NSString *)message view:(UIView *)view;

- (void) showloadingInView:(UIView*)view message:(NSString *)message;

- (void) toastAlertText: (NSString *)message view:(UIView *)view;
- (void) showDialog:(NSString *) message;
- (void) hideDialog;
- (void) setDialogText: (NSString *) message;
- (void) showloading;
- (void) alertError: (NSString *) message;
- (void) alert: (NSString *) message title: (NSString *)title;
- (void)showAlertWith:(NSString*)alertString;
//kgc
-(void)showLoading:(NSString*)text;
-(void)hideLoadingGif;
#pragma mark ------ keyboard ------
- (void) setKeyboardTapGestore;

- (BOOL) isSubAccount;
- (void)couponUpdate;
#pragma mark 判断网络
- (NETWORK_TYPE)isnetwork;
-(void)networkChange:(AFNetworkReachabilityStatus)status;
-(NSString *)MD5ForLower32Bate:(NSString *)str;
-(NSString *)MD5ForUpper32Bate:(NSString *)str;
-(NSString *)MD5ForUpper16Bate:(NSString *)str;
-(NSString *)MD5ForLower16Bate:(NSString *)str;
#pragma mark -------- navigate bar --------
//- (void) setBackItem;
//- (void)setCustomBarItem:(NSString *)image withName:(NSString *)name isRight:(BOOL)isRight rect:(CGRect)rect;
//- (void) leftButtonClick:(id)sender;
//- (void) rightButtonClick:(id)sender;
#pragma mark - 判断VIN码是否正确

- (BOOL)checkVin:(NSString *)vin;
#pragma mark - 判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string;


- (void)textFieldResignFirstResponse;


//设置navbar 是否透明
- (void)setNavBarTransparent:(BOOL)transparent;
- (void)setNavBarWhite;
- (void)setNoShadowImageNavBar;
-(void)useMethodToFindBlackLineAndHind;
- (void)showHeaderBg;

- (void)goLogin;
- (void)setViewLayer:(UIView *)view;

-(void)jvfLogin:(NSString *)token carrier:(NSString *)carrier isRegister:(BOOL)isRegister;
- (void)modalPushToVc:(UIViewController*)vc;
- (void)modalPop;
-(void)getLoginInfo;
-(void)requestList;
- (void)initData;
-(void)makeToast:(NSString *)msg;
/**
 Mrco
 */
@property (nonatomic, strong) UIImage *shareIthumbImage;

-(UIImage *) getImageFromURL:(NSString *)fileURL;
- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
-(void)showWLoading:(NSString*)text;
-(void)requsetloging;
@end
