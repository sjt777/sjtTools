//
//  MYBannerWebView.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/10.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYBannerWebViewVc.h"
#import <WebKit/WebKit.h>
#import "QYSDK.h"
#import "ANT_ShareView.h"
#import "ANT_BrandWebViewController.h"
#import "NSString+SCAddition.h"
#import "LoginVC.h"
#import "MYWalletViewController.h"
#import "Ant_CarDetailNativeViewController.h"
#import "ANT_NewCarDealerSureViewController.h"
#import "MYSetView.h"
#import "MYPubWholeCarViewController.h"
#import "MYCarDetectionVC.h"
#import "AppDelegate.h"

@interface MYBannerWebViewVc ()
@property (nonatomic, strong) UIProgressView *myProgressView;
@property (nonatomic, strong) DWKWebView * dwebview;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@end

@implementation MYBannerWebViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title=self.titlelabel;
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUI];
    
}
-(void)initUI{
    
    
    self.dwebview=[[DWKWebView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.frame.size.width, self.view.frame.size.height-SafeAreaTopHeight)];
    [self changeWKWebViewUserAgent];
    [_dwebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_dwebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    //[_dwebview addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_dwebview];
    [self.view addSubview:self.myProgressView];
    self.jsApi = [[MYJsApiRegister alloc] init];
    self.jsApi.vc = self;
    self.user_token = self.loginuser.user_token;
    self.user_id = self.loginuser.uid;
    WeakSelf
    self.jsApi.rechargeMoneyBlock = ^(NSInteger type, NSDictionary * arg) {
        if (type == 1) {
            [weakSelf zhifubao:arg];
        }else{
            [weakSelf payByWeiXin:arg];
        }
    };
    //_dwebview
    self.jsApi.loginuser = self.loginuser;
    [_dwebview addJavascriptObject:self.jsApi namespace:nil];
    _dwebview.navigationDelegate=self;
    _dwebview.allowsBackForwardNavigationGestures = YES;
   
    NSString *loadUrl = _lastpath;
    
    if ([self.user_id isNotEmpty]) {
        NSString *linkStr = @"&";
        if (![loadUrl containsString:@"?"]) {
            linkStr = @"?";
        }
       loadUrl = [NSString stringWithFormat:@"%@%@user_id=%@",loadUrl,linkStr,self.user_id];
    }
    if ([self.user_token isNotEmpty]) {
        if (![loadUrl containsString:@"?user_token="] || ![loadUrl containsString:@"?userToken="]) {
            NSString *linkStr = @"&";
            if (![loadUrl containsString:@"?"]) {
                linkStr = @"?";
            }
            loadUrl = [NSString stringWithFormat:@"%@%@user_token=%@",loadUrl,linkStr,self.user_token];
        }
       
    }
    NSURL * url=[NSURL URLWithString:loadUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [_dwebview loadRequest:request];
 
    /*
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index"
                                                          ofType:@"html"];
    NSString * htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    [_dwebview loadHTMLString:htmlContent baseURL:baseURL];
 */
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeSystem];
    rightbtn.frame=CGRectMake(0, 0, 22, 22);
    [rightbtn setImage:[UIImage imageNamed:@"nav_share_icon"] forState:UIControlStateNormal];
    rightbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    rightbtn.titleLabel.font=[UIFont systemFontOfSize:13];
    rightbtn.tag=1000;
    [rightbtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem=item;
    
    if (!_hideShare) {
        rightbtn.hidden = YES;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess) name:@"registerSucced" object:nil];

}

/** 修改WKWebView的UserAgent */
- (void)changeWKWebViewUserAgent{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    NSString *oldUserAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 获取app版本
    NSString *app_Version = [infoDictionary my_stringForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"%@/device=antQueen/vc=%@",oldUserAgent,app_Version];
    
    [self.dwebview setCustomUserAgent:newUserAgent];
}

#pragma mark - 注册成功
- (void)registerSuccess{
    self.loginuser = [self getLoginUser];
    [_dwebview callHandler:@"newView" arguments:@[@{@"user_token":self.loginuser.user_token}] completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"%@",value);
    }];
}
#pragma mark - 更新h5状态
- (void)updateSuccedState:(BOOL)state{
    [_dwebview callHandler:@"updateState" arguments:@[@{@"state":@(1)}] completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"updateSuccedState%@",value);
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.loginuser = [self getLoginUser];
    if (self.jsApi) {
        self.jsApi.loginuser = self.loginuser;
    }
    [self setNavBarTransparent:NO];
    if ([self.UMLogPageStr isNotEmpty]) {
        [MobClick beginLogPageView:self.UMLogPageStr];

    }else{
        [MobClick beginLogPageView:ANT_BANNER];

    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.UMLogPageStr isNotEmpty]) {
        [MobClick endLogPageView:self.UMLogPageStr];
        
    }else{
        [MobClick endLogPageView:ANT_BANNER];
        
    }
}
-(BOOL)navigationShouldPopOnBackButton{
    if ([_dwebview canGoBack]) {
        [_dwebview goBack];
        return NO;
    }
    return YES;
}
- (void)dealloc
{
    [self.dwebview removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.dwebview removeObserver:self forKeyPath:@"title"];
    //[self.dwebview removeObserver:self forKeyPath:@"canGoBack"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registerSucced" object:nil];

}
#pragma mark - Delegate
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //[self checkGoBack];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //[self checkGoBack];
}
-(void)checkGoBack{
    if (self.dwebview.canGoBack){
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    }else{
        self.navigationItem.leftBarButtonItem = self.backItem;
        
    }
}
/// 检查返回（pop/goback）

// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.dwebview && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    }else if (object == self.dwebview && [keyPath isEqualToString:@"title"]){
            self.title = self.dwebview.title;
    }
    /*
    else if (object == self.dwebview && [keyPath isEqualToString:@"canGoBack"]){
        BOOL newPop = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (newPop){
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            
        }
            
          
    }*/
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, [UIScreen mainScreen].bounds.size.width, 0)];
        _myProgressView.tintColor = hexColor(FF773A);
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}


#pragma mark - 右键分享

-(void)shareClick
{
    WeakSelf
     [_dwebview callHandler:@"shareParames" completionHandler:^(NSDictionary * _Nullable value) {
     NSLog(@"%@",value);
         weakSelf.shareDic = value;
         [weakSelf shareWithParames:value];
     }];
    
    
    
}
-(void)zhifubao:(NSDictionary *)arg {
    NSString *money =[arg my_stringForKey:@"total_amount"];
    int payType =[arg my_intForKey:@"payType"];
    NSString *aToken =[arg my_stringForKey:@"aToken"];
    if(![self.util checkStrIsNum:money] && [money floatValue]<=0)
    {
        [self toastText:@"请输入合法的金额" view:self.view];
        return;
    }
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];

    [dataDic setValue:@(payType) forKey:@"payType"];
    [dataDic setValue:aToken forKey:@"aToken"];
    [dataDic setValue:money forKey:@"money"];
    [dataDic setValue:self.loginuser.user_token forKey:@"userToken"];
    if (self.isCombo) {
        [dataDic setValue:@"1" forKey:@"type"];

    }else{
        [dataDic setValue:@"0" forKey:@"type"];

    }

    self.op = [Biz requestAction:ACTION_CREATEORDER_creatOrderFast pragrams:dataDic handler:^(BOOL success, id responseObject) {
        if (success) {
            if (responseObject) {

                if ([responseObject my_intForKey:@"code"] != 200) {
                    [self toastText:[responseObject stringForKey:@"msg"] view:self.view];
                }else{
                    WeakSelf
                    [self showloading];
                    NSString *sign = [responseObject stringForKey:@"data"];
                    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    appDelegate.payType = 1 ;

                    [[MYAlipPayManager sharedManager] aliPayWithVc:self signStr:sign paySuccessBlock:^{
                        [self hideDialog];
                        !self->_rechargeBlock ? : _rechargeBlock(YES);
                        if (self.isCombo) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:self cancelButtonTitle:@"继续购买" otherButtonTitles:@"去查看", nil];
                            alert.tag=10010;
                            [alert show];
                        }else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"充值成功！快去查看吧~" delegate:self cancelButtonTitle:@"立即查看" otherButtonTitles:@"返回", nil];
                            alert.tag=10000;
                            [alert show];
                        }
                        [self updateSuccedState:YES];

                    } payFailBlock:^{
                        [self hideDialog];
                        [weakSelf toastText:@"支付失败，请重新购买" view:self.view ];
                        [self updateSuccedState:NO];

                    }];
                    
                }

            }else {
                [self toastText:@"获取数据失败" view:self.view];
            }
        } else {
            [self toastAlertText:showErrorMsg view:self.view];

        }
    }];
}
#pragma mark 
- (void)payByWeiXin:(NSDictionary *)arg
{
    NSString *money =[arg my_stringForKey:@"total_amount"];
    int payType =[arg my_intForKey:@"payType"];
    NSString *aToken =[arg my_stringForKey:@"aToken"];
    if(![self.util checkStrIsNum:money] && [money floatValue]<=0)
    {
        [self toastText:@"请输入合法的数字" view:self.view];
        return;
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.payType = 2 ;
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    [dataDic setValue:self.loginuser.uid forKey:@"user_id"];
    [dataDic setValue:money forKey:@"money"];
    [dataDic setValue:@(payType) forKey:@"payType"];
    [dataDic setValue:aToken forKey:@"aToken"];
    [dataDic setValue:self.loginuser.user_token forKey:@"userToken"];
    if (self.isCombo) {
        [dataDic setValue:@"1" forKey:@"type"];

    }else{
        [dataDic setValue:@"0" forKey:@"type"];

    }    [self showloading];
    [MYWebService postRequest:ACTION_CREATEORDER_wechatOrderFast parameters:dataDic progress:nil success:^(ErrorCode code, NSString *msg, id data) {
        if (code == 200) {
            [[MYWxPayManager sharedManager] wxPayWithVc:self wechatPayDic:dataDic paySuccessBlock:^{
                !self->_rechargeBlock ? : self->_rechargeBlock(YES);
                if (self.isCombo) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:self cancelButtonTitle:@"继续购买" otherButtonTitles:@"去查看", nil];
                    alert.tag=10010;
                    [alert show];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"充值成功！快去查看吧~" delegate:self cancelButtonTitle:@"立即查看" otherButtonTitles:@"返回", nil];
                    alert.tag=10086;
                    [alert show];
                }
                [self updateSuccedState:YES];
            } payFailBlock:^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 10000;
                [alert show];
                [self updateSuccedState:NO];
            }];
        }else{
            [self toastText:msg view:self.view];
        }
        } failure:^(ErrorCode code, NSString *msg, id data) {
            [self toastAlertText:showErrorMsg view:self.view];

        } finish:^(ErrorCode code, NSString *msg, BOOL success) {
            
        }];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 10010) {    // it's the Error alert
        if (buttonIndex == 1) {     // and they clicked OK.
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if ([alertView tag] == 10086){
        if (buttonIndex == 0) {
            MYWalletViewController *vc = [[MYWalletViewController alloc]init];
            vc.index  = 2;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
}
-(void)shareWithParames:(NSDictionary *)parames{
    NSString  *title = [parames my_stringForKey:@"title"];
    NSString  *content = [parames my_stringForKey:@"content"];
    NSString  *urlApp = [parames my_stringForKey:@"shareUrl"];
    
    
    //创建分享参数
    NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
    [publishContent SSDKSetupShareParamsByText:content
                                        images:@[[UIImage imageNamed:@"icon-180"]]
                                           url:[NSURL URLWithString:urlApp]
                                         title:title
                                          type:SSDKContentTypeAuto];
    NSMutableDictionary *weChatContent = [NSMutableDictionary dictionary];
    [weChatContent SSDKSetupShareParamsByText:content
                                       images:@[[UIImage imageNamed:@"icon-180"]]
                                          url:[NSURL URLWithString:urlApp]
                                        title:title
                                         type:SSDKContentTypeAuto];
    
    WeakSelf
    [ANT_ShareView shareItemWithContent:publishContent Content2:weChatContent Content3:nil withOutAnt:YES handle:^(NSInteger type){
        if (type == 6) {
            [UIPasteboard generalPasteboard].string = urlApp;
            [weakSelf toastMBText:@"复制报告链接成功" view:self.view];
        }
    }];
}
@end
