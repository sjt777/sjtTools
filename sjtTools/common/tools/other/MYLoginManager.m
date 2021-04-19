//
//  MYLoginManager.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/8.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYLoginManager.h"
#import "NSString+SCAddition.h"
@interface MYLoginManager ()
{
    UIViewController *_viewController;
    BOOL _isChangeLogin;
    BOOL _isRegister;
    BOOL _isAuthorization;

}
@end
@implementation MYLoginManager
+ (MYLoginManager *)sharedManager{
    static MYLoginManager *shareLoginUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareLoginUtil = [[self alloc]init];
    });
    return shareLoginUtil;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        JVAuthConfig *config = [[JVAuthConfig alloc] init];
        config.appKey = @"2fad2245722aae78c1e0ab4e";
        [JVERIFICATIONService setupWithConfig:config];
        [JVERIFICATIONService setDebug:NO];
        
    }
    return self;
}
-(void)loginWithVc:(UIViewController *)vc isRegister:(BOOL)isRegister loginSuccessBlock:(LoginSuccessBlock)successBlock  loginFailBlock:(LoginFailBlock)failBlock loginChangeBlock:(LoginChangeBlock)changeBlock authorizationBlock:(AuthorizationBlock)authorizationBlock {
    [self customUI];
    _viewController = vc;
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    self.changeBlock = changeBlock;
    self.authorizationBlock = authorizationBlock;
    _isChangeLogin = NO;
    _isAuthorization = NO;
    _isRegister = isRegister;
    if(![JVERIFICATIONService checkVerifyEnable]) {
           NSLog(@"当前网络环境不支持认证！");
        !_failBlock ?:_failBlock();

           return;
    }
    [JVERIFICATIONService preLogin:5000 completion:^(NSDictionary *result) {
        NSLog(@"登录预取号 result:%@", result);
    }];
    [JVERIFICATIONService getAuthorizationWithController:vc hide:YES animated:YES timeout:5*1000 completion:^(NSDictionary *result) {
          NSLog(@"一键登录 result:%@", result);
            dispatch_async(dispatch_get_main_queue(), ^{
                   [self showResult:result];
               });
      } actionBlock:^(NSInteger type, NSString *content) {
          NSLog(@"一键登录 actionBlock :%ld %@", (long)type , content);
      }];
//    [JVERIFICATIONService getAuthorizationWithController:vc hide:YES completion:^(NSDictionary *result) {
//        NSLog(@"一键登录 result:%@", result);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self showResult:result];
//        });
//    }];
    
}
- (void)customUI{
    /*移动*/
    JVMobileUIConfig *mobileUIConfig = [[JVMobileUIConfig alloc] init];
    mobileUIConfig.privacyState = YES;
    mobileUIConfig.logoImg = [UIImage imageNamed:@"icon_register"];
    mobileUIConfig.navColor = [UIColor whiteColor];
    mobileUIConfig.barStyle = 0;
    mobileUIConfig.navText = [[NSAttributedString alloc] initWithString:@"免密登录"];
    mobileUIConfig.navReturnImg = [UIImage imageNamed:@"model_close"];
    mobileUIConfig.logoHidden = NO;
    mobileUIConfig.logBtnText = @"";
    mobileUIConfig.logBtnImgs = @[[UIImage imageNamed:@"yijian"],[UIImage imageNamed:@"yijian"],[UIImage imageNamed:@"yijian"]];
    mobileUIConfig.logBtnTextColor = [UIColor whiteColor];
    mobileUIConfig.numberColor = hexColor(333333);
    mobileUIConfig.appPrivacyOne = @[@"蚂蚁女王服务协议",@"https://51ruiheng.com/webview/registeRagreement/"];
    mobileUIConfig.appPrivacyTwo = @[@"隐私政策",@"https://www.51ruiheng.com/webview/privacyAgreement/"];
    mobileUIConfig.appPrivacyColor = @[hexColor(999999), hexColor(FF4940)];
    
    [JVERIFICATIONService customUIWithConfig:mobileUIConfig customViews:^(UIView *customAreaView) {
        if (!self->_isRegister) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"切换账号" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:hexColor(FF773A) forState:UIControlStateNormal];
            button.frame = CGRectMake(SCREEN_W - 28 - 65, 326, 65, 21);
            [button addTarget:self action:@selector(changeLoginType) forControlEvents:UIControlEventTouchUpInside];
            [customAreaView addSubview:button];
        }
    }];
    
    /*联通*/
    JVUnicomUIConfig *unicomUIConfig = [[JVUnicomUIConfig alloc] init];
    unicomUIConfig.privacyState = YES;

    unicomUIConfig.logoImg = [UIImage imageNamed:@"icon_register"];
    unicomUIConfig.navColor = [UIColor whiteColor];
    unicomUIConfig.barStyle = 0;
    unicomUIConfig.navText = [[NSAttributedString alloc] initWithString:@"免密登录"];
    unicomUIConfig.navReturnImg = [UIImage imageNamed:@"model_close"];
    unicomUIConfig.logoHidden = NO;
    unicomUIConfig.logBtnText = @"";
    unicomUIConfig.logBtnImgs = @[[UIImage imageNamed:@"yijian"],[UIImage imageNamed:@"yijian"],[UIImage imageNamed:@"yijian"]];
    unicomUIConfig.logBtnTextColor = [UIColor whiteColor];
    unicomUIConfig.numberColor = hexColor(333333);
    unicomUIConfig.appPrivacyOne = @[@"蚂蚁女王服务协议",@"https://51ruiheng.com/webview/registeRagreement/"];
    unicomUIConfig.appPrivacyTwo = @[@"隐私政策",@"https://www.51ruiheng.com/webview/privacyAgreement/"];
    unicomUIConfig.appPrivacyColor = @[hexColor(999999), hexColor(FF4940)];

    
    [JVERIFICATIONService customUIWithConfig:unicomUIConfig customViews:^(UIView *customAreaView) {
        if (!self->_isRegister) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"切换账号" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:hexColor(FF773A) forState:UIControlStateNormal];
            button.frame = CGRectMake(SCREEN_W - 28 - 65, 326, 65, 21);
            [button addTarget:self action:@selector(changeLoginType) forControlEvents:UIControlEventTouchUpInside];
            [customAreaView addSubview:button];
        }
    }];
    
    /*电信*/
    JVTelecomUIConfig *telecomUIConfig = [[JVTelecomUIConfig alloc] init];
    telecomUIConfig.privacyState = YES;

    telecomUIConfig.logoImg = [UIImage imageNamed:@"icon_register"];
    telecomUIConfig.navColor = [UIColor whiteColor];
    telecomUIConfig.barStyle = 0;
    telecomUIConfig.navText = [[NSAttributedString alloc] initWithString:@"免密登录"];
    telecomUIConfig.navReturnImg = [UIImage imageNamed:@"model_close"];
    telecomUIConfig.logoHidden = NO;
    telecomUIConfig.logBtnText = @"";
    telecomUIConfig.logBtnImgs = @[[UIImage imageNamed:@"yijian"],[UIImage imageNamed:@"yijian"],[UIImage imageNamed:@"yijian"]];
    telecomUIConfig.logBtnTextColor = [UIColor whiteColor];
    telecomUIConfig.numberColor = hexColor(333333);
    telecomUIConfig.appPrivacyOne = @[@"蚂蚁女王服务协议",@"https://51ruiheng.com/webview/registeRagreement/"];
     telecomUIConfig.appPrivacyTwo = @[@"隐私政策",@"https://www.51ruiheng.com/webview/privacyAgreement/"];
    telecomUIConfig.appPrivacyColor = @[hexColor(999999), hexColor(FF4940)];

    
    [JVERIFICATIONService customUIWithConfig:telecomUIConfig customViews:^(UIView *customAreaView) {
        if (!self->_isRegister) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"切换账号" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:hexColor(FF773A) forState:UIControlStateNormal];
            button.frame = CGRectMake(SCREEN_W - 28 - 65, 326, 65, 21);
            [button addTarget:self action:@selector(changeLoginType) forControlEvents:UIControlEventTouchUpInside];
            [customAreaView addSubview:button];
        }
        
        
    }];
    
    
}
-(void)changeLoginType{
    _isChangeLogin = YES;
    [MobClick event:MIANMIDENGLU_QIEHUAN];
    [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
           //授权页隐藏完成
       }];
    !_changeBlock ?:_changeBlock();
}
-(void)showResult:(NSDictionary *)dic{
    NSLog(@"showResult %@",dic);
    NSString *operator = [dic my_stringForKey:@"operator"];
    NSString *loginToken = [dic my_stringForKey:@"loginToken"];
    int code = [dic my_intForKey:@"code"];
    
    if ([operator isNotEmpty] && [loginToken isNotEmpty] && code == 6000) {
        [MobClick event:MIANMIDENGLU_DENGLU];
        if (_isAuthorization) {
            _isAuthorization = NO;
        }else{
            !_successBlock ?:_successBlock(operator,loginToken);
        }
       
    }else if (code == 6004){//正在登录中，稍候再试
        //!_authorizationBlock ?:_authorizationBlock();
        _isAuthorization = YES;
        !_failBlock ?:_failBlock();
    }else{

        if (!_isAuthorization) {
            if (!_isChangeLogin && code != 6002) {
                !_failBlock ?:_failBlock();
            }
        }else{
            _isAuthorization = NO;
        }
       
    }
  //  [JVERIFICATIONService clearPreLoginCache];

}
@end
