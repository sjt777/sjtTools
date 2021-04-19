//
//  BaseVC.m
//  template
//
//  Created by yxj on 15-3-25.
//  Copyright (c) 2015年 yxj. All rights reserved.
//


//#import "APService.h"
#import "JPUSHService.h"
#import "AppDelegate.h"
#include <netdb.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonDigest.h>
#import "UIView+HDAddition.h"
#import "LoginVC.h"
#import "YYText.h"
#import "YYImage/YYImage.h"
#import "JVERIFICATIONService.h"
#import "MYLoginManager.h"
#import "UIViewController+HBD.h"
#import "NSString+SCAddition.h"
@interface BaseVC ()<UIAlertViewDelegate>
{
    UIViewController * controller;
    UIImageView  *nav_bg;
    UIView       *loadingView;

}

@end

@implementation BaseVC

@synthesize util ;
- (void)initData {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];

    
    self.extendedLayoutIncludesOpaqueBars = YES;//偏移64处理
//
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;//状态栏颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];//title字体颜色
//    self.navigationController.navigationBar.tintColor = hexColor(999999);//返回按钮颜色
    self.hbd_barStyle = UIBarStyleDefault;
    self.hbd_barTintColor = hexColor(ffffff);
    self.hbd_tintColor = hexColor(333333);
    self.hbd_titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium]};
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"nav_return_gray"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_return_gray"]];
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    
    self.params = [[NSMutableDictionary alloc]init];
    self.util = [[Util alloc] init];
    self.loginuser = [self getLoginUser];
    
    
    AFNetworkReachabilityManager  *netManage =[AFNetworkReachabilityManager sharedManager];
    [netManage startMonitoring];
    WeakSelf
    [netManage setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status) {
            [weakSelf networkChange:status];
//        }
        
    }];
//    
//    JVAuthConfig *config = [[JVAuthConfig alloc] init];
//    config.appKey = @"2fad2245722aae78c1e0ab4e";
//    [JVERIFICATIONService setupWithConfig:config];
//    [JVERIFICATIONService setDebug:NO];
//    [self customUI];

    // 加入打印控制器名称，方便定位控制器 Mr.co
    NSLog(@"*****UIViewController : %@",NSStringFromClass([self class]));
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题
    }
}
- (void)modalPushToVc:(UIViewController*)vc{
       CATransition* transition = [CATransition animation];

       transition.duration =0.4f;

       transition.type = kCATransitionMoveIn;

       transition.subtype = kCATransitionFromTop;

       [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];

       [self.navigationController pushViewController:vc animated:NO];

   }



- (void)modalPop

{

   CATransition* transition = [CATransition animation];

   transition.duration =0.4f;

   transition.type = kCATransitionReveal;

   transition.subtype = kCATransitionFromBottom;

   [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];

   [self.navigationController popViewControllerAnimated:NO];

}

- (void)setViewLayer:(UIView *)view{
    view.layer.shadowOffset =CGSizeMake(0, 2);
    view.layer.shadowColor = [UIColor colorWithHex:@"#e5e5e5"].CGColor;
    view.layer.shadowRadius = 1;
    view.layer.shadowOpacity = .5f;
    
    CGRect shadowFrame = view.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    view.layer.shadowPath = shadowPath;
    
}
- (void)navBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldResignFirstResponse {
    
    [self resignKeyBoardInView:self.view];
}

- (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
}

-(void)networkChange:(AFNetworkReachabilityStatus)status{
    
}
#pragma mark 用户
- (void) setLoginUser: (User *)loginuser
{
    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
    NSLog(@"setLoginUser******* uid %@ pid %@ cardealer %@ type %@",self.loginuser.uid,self.loginuser.pid,self.loginuser.cardealer,self.loginuser.type);

    if (loginuser){
        long long uid = [loginuser.uid longLongValue];
        [defaultpreference setObject:[NSString stringWithFormat:@"%lld",uid] forKey:@"uid"];
        [defaultpreference setObject:loginuser.tel forKey:@"tel"];
        [defaultpreference setObject:loginuser.pwd forKey:@"pwd"];
        [defaultpreference setObject:loginuser.key forKey:@"key"];
#pragma mark - 添加new
        [defaultpreference setObject:loginuser.is_online forKey:@"is_online"];
        [defaultpreference setObject:loginuser.is_insurance forKey:@"is_insurance"];
        [defaultpreference setObject:loginuser.pid forKey:@"pid"];
        [defaultpreference setObject:loginuser.cardealer forKey:@"cardealer"];
        [defaultpreference setObject:loginuser.type forKey:@"type"];
        [defaultpreference setObject:loginuser.is_new_cardealer forKey:@"is_new_cardealer"];
        [defaultpreference setObject:loginuser.vip_type forKey:@"vip_type"];
        [defaultpreference setBool:loginuser.is_show_price forKey:@"is_show_price"];
        [defaultpreference setObject:loginuser.user_token forKey:@"user_token"];

        [defaultpreference synchronize];
    }else{
        [defaultpreference removeObjectForKey:@"uid"];
        [defaultpreference removeObjectForKey:@"tel"];
        [defaultpreference removeObjectForKey:@"pwd"];
        [defaultpreference removeObjectForKey:@"key"];
#pragma mark - 添加new
        [defaultpreference removeObjectForKey:@"is_online"];
        [defaultpreference removeObjectForKey:@"is_insurance"];
        [defaultpreference removeObjectForKey:@"pid"];
        [defaultpreference removeObjectForKey:@"cardealer"];
        [defaultpreference removeObjectForKey:@"type"];
        [defaultpreference removeObjectForKey:@"is_new_cardealer"];
        [defaultpreference removeObjectForKey:@"vip_type"];
        [defaultpreference removeObjectForKey:@"is_show_price"];
        [defaultpreference removeObjectForKey:@"user_token"];

        [defaultpreference synchronize];
    }
}

- (User *) getLoginUser
{
    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
    self.loginuser = [[User alloc]init];
    NSString *login_user_id = [defaultpreference stringForKey:@"uid"];
    if (![self.util isNullOrEmpty:login_user_id]){
        //self.loginuser = [[User alloc] init];
        self.loginuser.uid = login_user_id;
        self.loginuser.user_token = [defaultpreference  objectForKey:@"user_token"];
        self.loginuser.tel = [defaultpreference objectForKey:@"tel"];
        self.loginuser.pwd = [defaultpreference objectForKey:@"pwd"];
        self.loginuser.key = [defaultpreference objectForKey:@"key"];
        self.loginuser.is_online = [defaultpreference objectForKey:@"is_online"];
        self.loginuser.is_insurance=[defaultpreference objectForKey:@"is_insurance"];
        self.loginuser.pid  =   [defaultpreference objectForKey:@"pid"];
        self.loginuser.cardealer = [defaultpreference objectForKey:@"cardealer"];
        self.loginuser.type = [defaultpreference objectForKey:@"type"];
        self.loginuser.is_new_cardealer = [defaultpreference objectForKey:@"is_new_cardealer"];
        self.loginuser.vip_type = [defaultpreference objectForKey:@"vip_type"];
        self.loginuser.is_show_price = [defaultpreference boolForKey:@"is_show_price"];
        self.loginuser.user_token = [defaultpreference objectForKey:@"user_token"];

    }
    NSLog(@"getLoginUser uid %@ pid %@ cardealer %@ type %@ is_new_cardealer %@",self.loginuser.uid,self.loginuser.pid,self.loginuser.cardealer,self.loginuser.type,self.loginuser.is_new_cardealer);
    return self.loginuser;
}

- (BOOL)isSubAccount {
    
    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
    NSString  *pid  =   [defaultpreference objectForKey:@"pid"];
    NSLog(@"isSubAccount %@",pid);

    if (pid) {
        
        if (pid.integerValue == 0) {
            return NO;
        } else if (pid.integerValue !=0){
            return YES;
        }
        
    } else {
        
        return NO;
    }
    return NO;
}

-(NSString *)getToken
{
    NSString *token = [NSString stringWithFormat:@"%@%@%@",self.loginuser.key,self.util.getCurrentYear,self.loginuser.uid];
    
    if (token > 0)
    {
        const char *cstr = [token UTF8String];
        unsigned char result[16];
        CC_MD5(cstr, strlen(cstr), result); // This is the md5 call
        return [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]];
    }else{
        return token;
    }
    
    return nil ;
}
#pragma mark - 32位 小写
-(NSString *)MD5ForLower32Bate:(NSString *)str{
    
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

#pragma mark - 32位 大写
-(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
-(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
-(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - 一键登录

-(void)jvfLogin:(NSString *)token carrier:(NSString *)carrier isRegister:(BOOL)isRegister{
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    [dataDic setValue:token forKey:@"token"];
    [dataDic setValue:carrier forKey:@"carrier"];
    [dataDic setValue:@"i" forKey:@"systemType"];
    NSString *md5IFDV = [self MD5ForLower32Bate:[MYKeyChainDataManager getIDFV]];

    [dataDic setValue:md5IFDV forKey:@"device_id"];
    [dataDic setValue:ANT_VERSION forKey:@"version"];

    [SVProgressHUD showWithStatus:@"登录中 请稍后"];
    WeakSelf
    [Biz opRequestAction:CHECKLOGIN pragrams:dataDic handler:^(BOOL success, id responseObject) {
        [SVProgressHUD dismiss];
        if (success) {
            if ([responseObject my_integerForKey:@"code"] == 200) {
                NSDictionary *dic = [responseObject my_dictionaryForKey:@"data"];
                [weakSelf saveUser:dic isRegister:isRegister];
                [weakSelf getLoginInfo];

            }else{
                [weakSelf toastMBText:[responseObject my_stringForKey:@"msg"] view:weakSelf.view ];
            }
        }else{
            [weakSelf toastMBText:@"登录失败请重试" view:self.view ];
        }
    }];
}
#pragma mark 保存用户信息到本地
-(void)saveUser:(NSDictionary *)returnDic isRegister:(BOOL)isRegister
{
    
    self.loginuser.uid = [returnDic my_stringForKey:@"user_id"];
    self.loginuser.user_token = [returnDic my_stringForKey:@"user_token"];
    //标识用户
    NSString *md5IFDV = [self MD5ForLower32Bate:[MYKeyChainDataManager getIDFV]];
    NSString *alias = [NSString stringWithFormat:@"%@%@",self.loginuser.uid,md5IFDV];
    
    if (self.loginuser.uid.length>0) {
        
        if([self.loginuser.cardealer isEqualToString:@"1"]){
            
            [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
                NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
            } seq:(1)];
            
            [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                NSLog(@"_____%ld___%@",(long)iResCode,iTags);
            } seq:(1)];
        } else {
            
            [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
                NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
            } seq:(1)];
            
            [JPUSHService setTags:[NSSet setWithObject:@"cardealer_0"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                NSLog(@"_____%ld___%@",(long)iResCode,iTags);
            } seq:(1)];
        }
    }
    self.loginuser.tel = [returnDic my_stringForKey:@"phone"];
    self.loginuser.key = [returnDic my_stringForKey:@"key"];
    self.loginuser.is_online = [returnDic my_stringForKey:@"is_online"];
    self.loginuser.is_insurance=[returnDic my_stringForKey:@"is_insurance"];
    
    self.loginuser.pid  = [returnDic my_stringForKey:@"pid"];
    
    self.loginuser.cardealer = [returnDic my_stringForKey:@"cardealer"];
    
    self.loginuser.type = [returnDic my_stringForKey:@"type"];
    
    self.loginuser.is_new_cardealer = [returnDic my_stringForKey:@"is_new_cardealer"];
    NSString  *others = [returnDic my_stringForKey:APP_VERSION];
    
    if ([others isEqualToString:@"1"]) {
        //others 1 为隐藏充值号
        self.loginuser.is_online = others;
    }
    
    [self setLoginUser:self.loginuser];
    if (isRegister) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSucced" object:nil];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_LoginSuccess object:nil];
    
}
-(void)changeLoginType{
    [self dismissViewControllerAnimated:YES completion:nil];

    LoginVC * loging=nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loging=[storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    loging.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:loging animated:YES];
}
- (void)goLogin {
    //一键登录
//    [JVERIFICATIONService getAuthorizationWithController:self completion:^(NSDictionary *result) {
//        NSLog(@"一键登录 result:%@", result);
//        dispatch_async(dispatch_get_main_queue(), ^{
//        });
//    }];
    WeakSelf
    [[MYLoginManager sharedManager] loginWithVc:self isRegister:NO loginSuccessBlock:^(NSString *operatorStr,NSString *loginToken) {
        [SVProgressHUD dismiss];
        [weakSelf jvfLogin:loginToken carrier:operatorStr isRegister:NO];
    } loginFailBlock:^{
        [SVProgressHUD dismiss];
        NSLog(@"1");
        [weakSelf changeLoginType];
    } loginChangeBlock:^{
        [SVProgressHUD dismiss];

        NSLog(@"2");
        [weakSelf changeLoginType];
    } authorizationBlock:^{
        [SVProgressHUD showWithStatus:@"登录中 请稍后"];
    }];
//    LoginVC * loging=nil;
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    loging=[storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
//    loging.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:loging animated:YES];
}
-(void)loginAndRegister{
    
}
#pragma mark ------- message dialog -----
- (void) toastText: (NSString *)message view:(UIView *)view
{
//    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView: view];
//    toast.labelText = message;
//    toast.opacity = 0.8;
//    toast.mode = MBProgressHUDModeText;
//    //    toast.yOffset = 150.0;
//    toast.removeFromSuperViewOnHide = YES;
//    [view addSubview: toast];
//    [toast show: YES];
//    [toast hide: YES afterDelay:1.0];
//    toast = nil;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    alert.tag=1111;
    
    [alert show];
}
-(void)makeToast:(NSString *)msg{
    if (![msg isNotEmpty]) {
        return;
    }
    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView: self.view];
    toast.labelText = msg;
    toast.opacity = 0.8;
    toast.mode = MBProgressHUDModeText;
    //    toast.yOffset = 150.0;
    toast.removeFromSuperViewOnHide = YES;
    [self.view addSubview: toast];
    [toast show: YES];
    [toast hide: YES afterDelay:2.0];
    toast = nil;
}
- (void)toastMBText:(NSString *)message view:(UIView *)view
{
    if ([message isNotEmpty]) {
        MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView: view];
        toast.labelText = message;
    
//        toast.color = [UIColor whiteColorblackColor];
//        toast.labelColor = [UIColor blackColor];
        toast.opacity = 0.8;
        toast.mode = MBProgressHUDModeText;
        //    toast.yOffset = 150.0;
        toast.removeFromSuperViewOnHide = YES;
        [view addSubview: toast];
        [toast show: YES];
        [toast hide: YES afterDelay:2.0];
        toast = nil;
    }
}

- (void)sjtToastMBText:(NSString *)message view:(UIView *)view
{
    if ([message isNotEmpty]) {
        MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView: view];
        toast.detailsLabelText = message;
        toast.detailsLabelFont = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        toast.opacity = 0.8;
        toast.mode = MBProgressHUDModeText;
        toast.removeFromSuperViewOnHide = YES;
        [view addSubview: toast];
        [toast show: YES];
        [toast hide: YES afterDelay:2.0];
        toast = nil;
    }
}

- (void)makeToastMBText:(NSString *)message view:(UIView *)view
{
    if (![message isNotEmpty]) {
        return;
    }
    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView: view];
    toast.labelText = message;
    toast.color = [UIColor whiteColor];
    toast.labelColor = [UIColor blackColor];
    toast.opacity = 0.8;
    toast.mode = MBProgressHUDModeText;
    //    toast.yOffset = 150.0;
    toast.removeFromSuperViewOnHide = YES;
    [view addSubview: toast];
    [toast show: YES];
    [toast hide: YES afterDelay:2.0];
    toast = nil;
}

- (void) toastAlertText: (NSString *)message view:(UIView *)view
{

    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    alert.tag=1111;
    
    [alert show];
 
}
-(void)showAlertWith:(NSString*)alertString {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelFont=[UIFont systemFontOfSize:14];
        hud.labelText = alertString;
        
        hud.margin = 15.f;
        
        //        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.8];
    });
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)//刷新当前页面
    {
//        //退出
//        [self setLoginUser:nil];
//        [APService setAlias:@"" callbackSelector:nil object:nil];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        //自动登录
//        [self reloadMY];
        if (self.httpSelecter) {
//            [self performSelector:self.httpSelecter withObject:nil];
           
            switch (self.params.allKeys.count) {
                case 0:
                {
                     [self performSelector:self.httpSelecter withObject:nil];
                }
                    break;
                case 1:
                {
                    [self performSelector:self.httpSelecter withObject:self.params[@"key1"]];
                }
                    break;
                case 2:
                {
                    [self performSelector:self.httpSelecter withObject:self.params[@"key1"] withObject:self.params[@"key2"]];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        [self reloadInputViews];
        
    }
}

- (void)showHeaderBg {
    if (!nav_bg) {
        nav_bg = [[UIImageView alloc]init];
        nav_bg.frame = CGRectMake(0, 0, SCREEN_W, SafeAreaTopHeight);
        nav_bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:nav_bg];
    }
}

- (void)setNavBarTransparent:(BOOL)transparent {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = transparent;
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"ant_navbar_yingyin"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    if (transparent) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;//状态栏颜色
        
        self.navigationController.navigationBar.tintColor = hexColor(333333);//返回按钮颜色
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];//title字体颜色
        
    } else {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;//状态栏颜色
       
        self.navigationController.navigationBar.tintColor = hexColor(333333);//返回按钮颜色
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:RGBA(66,70, 82,1)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

         [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];//title字体颜色
//        self.view.backgroundColor = [UIColor whiteColor];
       [self showHeaderBg];
    }
}
- (void)setNoShadowImageNavBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;//状态栏颜色
    
    self.navigationController.navigationBar.tintColor = hexColor(333333);//返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];//title字体颜色

}
- (void)setNavBarWhite {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"ant_navbar_yingyin"]];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;//状态栏颜色
    
    self.navigationController.navigationBar.tintColor = hexColor(333333);//返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];//title字体颜色

}
//当设置navigationBar的背景图片或背景色时，使用该方法都可移除黑线，且不会使translucent属性失效
-(void)useMethodToFindBlackLineAndHind
{
     
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = YES;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
-(void)showLoading:(NSString*)text
{
    UIWindow *_keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!_keyWindow) {
        _keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    loadingView.backgroundColor = hexColorAlpha(000000, 0.6);
    
    UIImage *image = [YYImage imageNamed:@"loading.gif"];
    YYAnimatedImageView *gifImage = [[YYAnimatedImageView alloc]initWithImage:image];
    
    gifImage.contentMode = UIViewContentModeScaleAspectFit;
    
    gifImage.bounds = CGRectMake(0, 0, 100, 65);
    
    [loadingView addSubview:gifImage];
    gifImage.center = CGPointMake(SCREEN_W / 2.0, SCREEN_H / 2.0 - 64);
    
    UILabel  *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, gifImage.HDview_y_b, SCREEN_W, 20)];
    tipsLabel.textColor = hexColor(ffffff);
    tipsLabel.font = [UIFont systemFontOfSize:14.0];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.text = text;
    [loadingView addSubview:tipsLabel];
    
  
    [_keyWindow addSubview:loadingView];
    _keyWindow.tag = 123456;
    
}
-(void)showWLoading:(NSString*)text
{
    UIWindow *_keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!_keyWindow) {
        _keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    loadingView.backgroundColor = hexColorAlpha(ffffff, 1);
    
    UIImage *image = [YYImage imageNamed:@"loading.gif"];
    YYAnimatedImageView *gifImage = [[YYAnimatedImageView alloc]initWithImage:image];
    
    gifImage.contentMode = UIViewContentModeScaleAspectFit;
    
    gifImage.bounds = CGRectMake(0, 0, 100, 65);
    
    [loadingView addSubview:gifImage];
    gifImage.center = CGPointMake(SCREEN_W / 2.0, SCREEN_H / 2.0 - 64);
    
    UILabel  *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, gifImage.HDview_y_b, SCREEN_W, 20)];
    tipsLabel.textColor = hexColor(000000);
    tipsLabel.font = [UIFont systemFontOfSize:14.0];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.text = text;
    [loadingView addSubview:tipsLabel];
    
  
    [_keyWindow addSubview:loadingView];
    _keyWindow.tag = 123456;
    
}
-(void)hideLoadingGif
{
    [loadingView removeFromSuperview];
    UIWindow *keyWindow =(UIWindow *)[self.view viewWithTag:123456];
    keyWindow.userInteractionEnabled = YES;
    [keyWindow removeAllSubviews];
    
}


-(void)reloadMY
{
    AppDelegate * app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.reloadstr=@"yuming";
    controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"loginVC"];
    [self.navigationController pushViewController:controller animated:YES];


}
- (void)showDialog: (NSString *)message
{
    if (!self.dialog)
    {
        self.dialog = [[MBProgressHUD alloc] initWithWindow: [[UIApplication sharedApplication].delegate window]] ;
        self.dialog.backgroundColor = [UIColor colorWithRed: 0. green: 0. blue: 0. alpha: 88 / 255.0];
        self.dialog.mode = MBProgressHUDModeIndeterminate;
        self.dialog.animationType = MBProgressHUDAnimationFade;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.dialog];
    }
    self.dialog.labelText = message;
    [self.dialog show: YES];
}

- (void) showloadingInView:(UIView*)view message:(NSString *)message{
 
    if (!self.dialog)
    {
        self.dialog = [[MBProgressHUD alloc] initWithWindow: [[UIApplication sharedApplication].delegate window]] ;
        self.dialog.backgroundColor = [UIColor colorWithRed: 0. green: 0. blue: 0. alpha: 88 / 255.0];
        self.dialog.mode = MBProgressHUDModeIndeterminate;
        self.dialog.animationType = MBProgressHUDAnimationFade;
        
        [view addSubview:self.dialog];
    }
    self.dialog.labelText = message;
    [self.dialog show: YES];
}

- (void) hideDialog
{
    [self.dialog hide: YES];
}

- (void) setDialogText: (NSString *) message
{
    self.dialog.labelText = message;
}

- (void)showloading
{
    [self showDialog: @"请稍后..."];
}

- (void)alert: (NSString *)message title:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title message: message delegate: self
                                          cancelButtonTitle: @"确定" otherButtonTitles: nil, nil];
    [alert show];
}

- (void) alertError: (NSString *) message
{
    [self alert: message title: @"发生错误!"];
}


#pragma mark ------ keyboard ------
- (void)setKeyboardTapGestore
{
    UITapGestureRecognizer *cancelkeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(cencelKeyBoardEvent:)];
    [self.view addGestureRecognizer: cancelkeyboard];
}

- (void)cencelKeyBoardEvent: (UITapGestureRecognizer *)gest
{
    
}

#pragma mark ----- text delegate ----
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 判断网络
- (NETWORK_TYPE)isnetwork
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])     {
            dataNetworkItemView = subview;
            break;
        }
    }
    NETWORK_TYPE nettype = NETWORK_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    nettype = [num intValue];
    return nettype;
}

#pragma mark -------- navigate bar --------
//- (void)setBackItem
//{
//    [self setCustomBarItem:@"back.png" withName:nil isRight: NO rect:  CGRectMake(0, 0, 24, 24)];
//}
//
//- (void)setCustomBarItem:(NSString *)image withName:(NSString *)name isRight:(BOOL)isRight rect:(CGRect)rect
//{
//    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
//    button.frame = rect;
//    [button setBackgroundImage:[UIImage imageNamed:image] forState: UIControlStateNormal];
//    [button setTitle:name forState:UIControlStateNormal];
//    button.titleLabel.font=[UIFont systemFontOfSize:16];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    UIBarButtonItem *baritem = [[UIBarButtonItem alloc] initWithCustomView: button];
//    if(isRight)
//    {
//        [button addTarget: self action: @selector(rightButtonClick:) forControlEvents: UIControlEventTouchUpInside];
//        self.navigationItem.rightBarButtonItem = baritem;
//    }
//    else
//    {
//        [button addTarget: self action: @selector(leftButtonClick:) forControlEvents: UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = baritem;
//    }
//}
//
//- (void)leftButtonClick:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void) rightButtonClick: (id)sender
//{
//    
//}
#pragma mark - 判断VIN码是否正确
- (BOOL)checkVin:(NSString *)vin{
    if (vin.length < 17) {
        return false;
    }
    /*
    NSDictionary *charDic=@{@"0":@(0),@"1":@(1),@"2":@(2),@"3":@(3),@"4":@(4),@"5":@(5),@"6":@(6),@"7":@(7),@"8":@(8),@"9":@(9),@"A":@(1),@"B":@(2),@"C":@(3),@"D":@(4),@"E":@(5),@"F":@(6),@"G":@(7),@"H":@(8),@"J":@(1),@"K":@(2),@"L":@(3),@"M":@(4),@"N":@(5),@"P":@(7),@"R":@(9),@"S":@(2),@"T":@(3),@"U":@(4),@"V":@(5),@"W":@(6),@"X":@(7),@"Y":@(8),@"Z":@(9)};
    NSArray *weightArr = @[@(8),@(7),@(6),@(5),@(4),@(3),@(2),@(10),@(0),@(9),@(8),@(7),@(6),@(5),@(4),@(3),@(2)];
    NSArray *vin9Arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X"];
    NSArray* charDicKeyArr = [charDic allKeys];
    NSString *vin9 = [vin substringWithRange:NSMakeRange(8, 1)];
    if(![vin9Arr containsObject:vin9]){
        return false;
    }
    NSString *tempStr =nil;
    for (int i = 0 ; i < 17; i++) {
        tempStr = [vin substringWithRange:NSMakeRange(i,1)];
        if (![charDicKeyArr containsObject:tempStr]) {
            return false;
        }
    }
    int total = 0;
    for (int i = 0; i < 17; i++) {
        NSString *key = [vin substringWithRange:NSMakeRange(i,1)];
        int a = [charDic[key] intValue];
        int b = [weightArr[i] intValue ];
        total += a*b;
    }
    int mode = total%11;
    if (mode < 10 && mode == vin9.intValue) {
        return true;
    }else if ((mode = 10 && [vin9 isEqualToString:@"X"])){
        return true;
    }else{
        return false;
    }*/
    return true;
}
- (void)pushViewController:(BaseVC *)controller_
{
    if (self.getLoginUser.uid==nil || [self.getLoginUser.uid isEqual:@""])
    {
        [self.navigationController pushViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"loginVC"] animated:YES];
        return;
    }
    [self.navigationController pushViewController:controller_ animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 优惠券升级
-(void)couponUpdate{
    NSString *user_token = self.getLoginUser.user_token;
    [Biz opRequestAction:CouponUpgrade pragrams:@{@"user_token":user_token} handler:^(BOOL success, id responseObject) {
        
    }];
}
-(void)getLoginInfo
{
    if (![self.loginuser.uid isNotEmpty]) {
        return;
    }
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:self.loginuser.user_token forKey:@"user_token"];
    WeakSelf
    [MYWebService getRequest:ACTION_showProfile parameters:dict progress:nil success:^(ErrorCode code, NSString *msg, id data) {
        if (code == 200) {
            NSDictionary * smdict= (NSDictionary *)data;
            if (smdict) {
  
                NSString  *cardealer = [smdict my_stringForKey:@"cardealer"];
                NSString  *str  = [smdict my_stringForKey:@"pid"];
                
                if (str && str.length>0) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:str forKey:@"pid"];
                    [defaultpreference synchronize];
                }
                NSString *type = [smdict my_stringForKey:@"type"];
                if (![weakSelf.loginuser.type isEqualToString:type]&&type) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:type forKey:@"type"];
                    [defaultpreference synchronize];
                    weakSelf.loginuser.type = type;
                }
                ///
               
                NSString *vip_type = [smdict my_stringForKey:@"vip_type"];
                if (![weakSelf.loginuser.vip_type isEqualToString:vip_type] && vip_type) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:vip_type forKey:@"vip_type"];
                    [defaultpreference synchronize];
                    weakSelf.loginuser.vip_type = vip_type;
                }
              
                NSString *is_new_cardealer = [smdict my_stringForKey:@"is_new_cardealer"];
                if (![weakSelf.loginuser.is_new_cardealer isEqualToString:is_new_cardealer]&&is_new_cardealer) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:is_new_cardealer forKey:@"is_new_cardealer"];
                    [defaultpreference synchronize];
                    weakSelf.loginuser.is_new_cardealer = is_new_cardealer;
                }
                BOOL is_show_price = [smdict my_boolForKey:@"is_show_price"];
                NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                [defaultpreference setBool:is_show_price forKey:@"is_show_price"];
                [defaultpreference synchronize];
                weakSelf.loginuser.is_show_price = is_show_price;

                if (![weakSelf.loginuser.cardealer isEqualToString:cardealer]&&cardealer) {
                    weakSelf.loginuser.cardealer = cardealer;
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:cardealer forKey:@"cardealer"];
                    [defaultpreference synchronize];
                    //标识用户
                    NSString *md5IFDV = [weakSelf MD5ForLower32Bate:[MYKeyChainDataManager getIDFV]];
                    NSString *alias = [NSString stringWithFormat:@"%@%@",weakSelf.loginuser.uid,md5IFDV];
                    if ([weakSelf.loginuser.cardealer isEqualToString:@"1"]) {

                        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
                            NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
                        } seq:(1)];
                        
                        [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                            NSLog(@"_____%ld___%@",(long)iResCode,iTags);
                        } seq:(1)];
                    }else {

                        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
                            NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
                        } seq:(1)];
                        
                        [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                            NSLog(@"_____%ld___%@",(long)iResCode,iTags);
                        } seq:(1)];
                    }
                }
                
                weakSelf.loginuser = [weakSelf getLoginUser];
               
            } else {
//                [self.avtarIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"personal_mayi_default"]];
            }

        } else {
//            [self.avtarIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"personal_mayi_default"]];

        }
      
        } failure:^(ErrorCode code, NSString *msg, id data) {
            
            
        } finish:^(ErrorCode code, NSString *msg, BOOL success) {

        }];
//    self.op = [Biz requestAction:ACTION_showProfile pragrams:dict handler:^(BOOL success, id responseObject) {
//        if (success) {
//            NSDictionary * smdict=[responseObject dictionaryForKey:@"data"];
//            if (smdict) {
//               
//
//                NSString  *cardealer = [smdict my_stringForKey:@"cardealer"];
//                NSString  *str  = [smdict my_stringForKey:@"pid"];
//                
//                if (str && str.length>0) {
//                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
//                    [defaultpreference setObject:str forKey:@"pid"];
//                    [defaultpreference synchronize];
//                }
//                NSString *type = [smdict my_stringForKey:@"type"];
//                if (![self.loginuser.type isEqualToString:type]&&type) {
//                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
//                    [defaultpreference setObject:type forKey:@"type"];
//                    [defaultpreference synchronize];
//                    self.loginuser.type = type;
//                }
//                ///
//               
//                NSString *vip_type = [smdict my_stringForKey:@"vip_type"];
//                if (![self.loginuser.vip_type isEqualToString:vip_type] && vip_type) {
//                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
//                    [defaultpreference setObject:vip_type forKey:@"vip_type"];
//                    [defaultpreference synchronize];
//                    self.loginuser.vip_type = vip_type;
//                }
//              
//                NSString *is_new_cardealer = [smdict my_stringForKey:@"is_new_cardealer"];
//                if (![self.loginuser.is_new_cardealer isEqualToString:is_new_cardealer]&&is_new_cardealer) {
//                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
//                    [defaultpreference setObject:is_new_cardealer forKey:@"is_new_cardealer"];
//                    [defaultpreference synchronize];
//                    self.loginuser.is_new_cardealer = is_new_cardealer;
//                }
//                BOOL is_show_price = [smdict my_boolForKey:@"is_show_price"];
//                NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
//                [defaultpreference setBool:is_show_price forKey:@"is_show_price"];
//                [defaultpreference synchronize];
//                self.loginuser.is_show_price = is_show_price;
//
//                if (![self.loginuser.cardealer isEqualToString:cardealer]&&cardealer) {
//                    self.loginuser.cardealer = cardealer;
//                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
//                    [defaultpreference setObject:cardealer forKey:@"cardealer"];
//                    [defaultpreference synchronize];
//                    //标识用户
//                    NSString *md5IFDV = [self MD5ForLower32Bate:[MYKeyChainDataManager getIDFV]];
//                    NSString *alias = [NSString stringWithFormat:@"%@%@",self.loginuser.uid,md5IFDV];
//                    if ([self.loginuser.cardealer isEqualToString:@"1"]) {
//
//                        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
//                            NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
//                        } seq:(1)];
//                        
//                        [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                            NSLog(@"_____%ld___%@",(long)iResCode,iTags);
//                        } seq:(1)];
//                    }else {
//
//                        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
//                            NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
//                        } seq:(1)];
//                        
//                        [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                            NSLog(@"_____%ld___%@",(long)iResCode,iTags);
//                        } seq:(1)];
//                    }
//                }
//                
//            }
//
//        }
//
//        
//    }];
    
    
}
/**
 列表请求
 */
-(void)requestList{
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL

{
    UIImage * result;

    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];

    result = [UIImage imageWithData:data];

    return result;
}
#pragma mark - 压缩图片
- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;

    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;

    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }

    return resultImage;
}
/**
 获取 个人中心信息
 */
-(void)requsetloging
{

    if (![self.loginuser.uid isNotEmpty]) {
        return;
    }
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    

    [dict setValue:self.loginuser.user_token forKey:@"userToken"];
    [dict setValue:@([[NSDate date] timeIntervalSince1970]) forKey:@"timeToken"];
WeakSelf
    [MYWebService getRequest:ACTION_showProfile parameters:dict progress:nil success:^(ErrorCode code, NSString *msg, id data) {
        if (code == 200) {
            NSDictionary * smdict= (NSDictionary *)data;
            if (smdict) {
  
                NSString  *cardealer = [smdict my_stringForKey:@"cardealer"];
                NSString  *str  = [smdict my_stringForKey:@"pid"];
                
                if (str && str.length>0) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:str forKey:@"pid"];
                    [defaultpreference synchronize];
                }
                NSString *type = [smdict my_stringForKey:@"type"];
                if (![weakSelf.loginuser.type isEqualToString:type]&&type) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:type forKey:@"type"];
                    [defaultpreference synchronize];
                    weakSelf.loginuser.type = type;
                }

                ///
                NSString *is_new_cardealer = [smdict my_stringForKey:@"is_new_cardealer"];
                if (![weakSelf.loginuser.is_new_cardealer isEqualToString:is_new_cardealer]&&is_new_cardealer) {
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:is_new_cardealer forKey:@"is_new_cardealer"];
                    [defaultpreference synchronize];
                    weakSelf.loginuser.is_new_cardealer = is_new_cardealer;
                }
                BOOL is_show_price = [smdict my_boolForKey:@"is_show_price"];
                NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                [defaultpreference setBool:is_show_price forKey:@"is_show_price"];
                [defaultpreference synchronize];
                weakSelf.loginuser.is_show_price = is_show_price;
//                if (self.loginuser.is_show_price != is_show_price) {
//
//                }
                if (![weakSelf.loginuser.cardealer isEqualToString:cardealer]&&cardealer) {
                    weakSelf.loginuser.cardealer = cardealer;
                    NSUserDefaults *defaultpreference = [NSUserDefaults standardUserDefaults];
                    [defaultpreference setObject:cardealer forKey:@"cardealer"];
                    [defaultpreference synchronize];
                    //标识用户
                    NSString *md5IFDV = [weakSelf MD5ForLower32Bate:[MYKeyChainDataManager getIDFV]];
                    NSString *alias = [NSString stringWithFormat:@"%@%@",self.loginuser.uid,md5IFDV];
                    if ([weakSelf.loginuser.cardealer isEqualToString:@"1"]) {

                        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
                            NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
                        } seq:(1)];
                        
                        [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                            NSLog(@"_____%ld___%@",(long)iResCode,iTags);
                        } seq:(1)];
                    }else {

                        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
                            NSLog(@"_____%ld___%@",(long)iResCode,iAlias);
                        } seq:(1)];
                        
                        [JPUSHService setTags:[NSSet setWithObject:@"cardealer_1"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                            NSLog(@"_____%ld___%@",(long)iResCode,iTags);
                        } seq:(1)];
                    }
                }
                
                
                weakSelf.loginuser = [weakSelf getLoginUser];
               
            } else {
//                [self.avtarIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"personal_mayi_default"]];
            }

        } else {
//            [self.avtarIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"personal_mayi_default"]];

        }
      
        } failure:^(ErrorCode code, NSString *msg, id data) {
            
            
        } finish:^(ErrorCode code, NSString *msg, BOOL success) {

        }];
    
    
}
@end
