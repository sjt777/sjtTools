//
//  MYJsApiRegister.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/10.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYJsApiRegister.h"
#import "dsbridge.h"

#import "QYSDK.h"
#import "ANT_ShareView.h"
#import "ANT_BrandWebViewController.h"
#import "NSString+SCAddition.h"
#import "LoginVC.h"
#import "MYWalletViewController.h"
#import "Ant_CarDetailNativeViewController.h"
#import "ANT_NewCarDealerSureViewController.h"
#import "MYRechargeNewViewController.h"
#import "MYSetView.h"
#import "MYPubWholeCarViewController.h"
#import "MYCarDetectionVC.h"
#import "MYSetView.h"
#import "RegisterVC.h"
#import "ANT_MainViewController.h"
#import "Ant_CarPublishViewController.h"
#import "MYCustomPaytypeView.h"
#import "AppDelegate.h"
#import "MGShareMenueView.h"
#import "MYInviteAlertView.h"

@interface MYJsApiRegister(){
    NSTimer * timer ;
    void(^hanlder)(id value,BOOL isComplete);
    int value;
}
@end
@implementation MYJsApiRegister
/**
 预估收益
 **/
- (id)estimateEarningsList:(id) arg{
    [self.vc pushNextPage:StoryBoard_MinePage vcName:@"MYMineEarningsVc" params:nil animated:YES];
    return arg;

}
/**
 提现收益
 **/
- (id)withdrawEarningsList:(id) arg{

    [self.vc pushNextPage:StoryBoard_MinePage vcName:@"MYCityPartnerBindCardVc" params:nil animated:YES];
    return arg;

}
/**
 我的客户
 **/
- (id)mineCustomerList:(id) arg{
    [self.vc pushNextPage:StoryBoard_MinePage vcName:@"MYMineCustomerVc" params:nil animated:YES];

    return arg;

}
/**
 客户充值列表
 **/
- (id)customerRechargeList:(id) arg{
    [self.vc pushNextPage:StoryBoard_MinePage vcName:@"MYCustomerRechargeVc" params:nil animated:YES];

    return arg;

}
/**
 qq分享
 **/
- (id)qqShare:(NSDictionary*) arg
{
    NSString  *title = [arg my_stringForKey:@"title"];
    NSString  *content = [arg my_stringForKey:@"content"];
    NSString  *urlApp = [arg my_stringForKey:@"shareUrl"];
    NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
    [publishContent SSDKSetupShareParamsByText:content
                                        images:@[[UIImage imageNamed:@"icon-180"]]
                                           url:[NSURL URLWithString:urlApp]
                                         title:title
                                          type:SSDKContentTypeAuto];
    //进行分享
    [ShareSDK share:SSDKPlatformSubTypeQQFriend //传入分享的平台类型
         parameters:publishContent
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         // 回调处理....}];
     }];
    return arg;
}
/**
 微信分享
 **/
- (id)wxShare:(NSDictionary*) arg
{
    NSString  *title = [arg my_stringForKey:@"title"];
    NSString  *content = [arg my_stringForKey:@"content"];
    NSString  *urlApp = [arg my_stringForKey:@"shareUrl"];
    NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
    [publishContent SSDKSetupShareParamsByText:content
                                        images:@[[UIImage imageNamed:@"icon-180"]]
                                           url:[NSURL URLWithString:urlApp]
                                         title:title
                                          type:SSDKContentTypeAuto];
    //进行分享
    [ShareSDK share:SSDKPlatformSubTypeWechatSession //传入分享的平台类型
         parameters:publishContent
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         // 回调处理....}];
     }];
    return arg;
}
/**
  朋友圈分享
 **/
- (id)pyShare:(NSDictionary*) arg
{
    NSString  *title = [arg my_stringForKey:@"title"];
    NSString  *content = [arg my_stringForKey:@"content"];
    NSString  *urlApp = [arg my_stringForKey:@"shareUrl"];
    NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
    [publishContent SSDKSetupShareParamsByText:content
                                        images:@[[UIImage imageNamed:@"icon-180"]]
                                           url:[NSURL URLWithString:urlApp]
                                         title:title
                                          type:SSDKContentTypeAuto];
    //进行分享
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
         parameters:publishContent
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         // 回调处理....}];
     }];
    return arg;
}

/**
批发车源发布
 **/
- (id)gotoPubWholseCarVc:(id) arg
{
    MYPubWholeCarViewController *vc = [[MYPubWholeCarViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:vc animated:YES];
    
    return arg;
}
/**
 零售车源发布
 **/
- (id)gotoPubRetailCarVc:(id) arg
{
    Ant_CarPublishViewController *vc = [[Ant_CarPublishViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:vc animated:YES];
    
    return arg;
}

/**
 车辆检测
 **/
- (id)gotoCarDetectionVc:(id) arg
{
    MYCarDetectionVC *vc = [[MYCarDetectionVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:vc animated:YES];
    return arg;
}

/**
 蚂蚁券
 **/
- (id)gotoAntCouponVc:(id) arg
{
    MYWalletViewController *vc = [[MYWalletViewController alloc]init];
    vc.index  = 2;
    vc.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:vc animated:YES];
    return arg;
}

/**
 车商认证
 **/
- (id)gotoDealerVc:(id) arg
{
    if ([self.loginuser.cardealer isEqualToString:@"0"]) {

        [self.vc pushNextPage:StoryBoard_Main vcName:@"ANT_NewCarDealerSureViewController" params:nil animated:YES];
        
    } else if ([self.loginuser.cardealer isEqualToString:@"1"]){
        NSArray *titleArray = @[@"车商认证",@"您已是蚂蚁女王认证车商",@"确定"];
        [self attestation:titleArray];
        
    } else if ([self.loginuser.cardealer isEqualToString:@"-1"]){
        NSArray *titleArray = @[@"车商认证",@"您的车商认证信息正在审核中，请耐心等待",@"确定"];
        [self attestation:titleArray];
    } else if ([self.loginuser.cardealer isEqualToString:@"-2"]){

        [self.vc pushNextPage:StoryBoard_Main vcName:@"ANT_NewCarDealerSureViewController" params:nil animated:YES];

        
    }
    return arg;
}
-(id)rechargeWithMoney:(NSDictionary*) arg{

//    NSString *money =[arg my_stringForKey:@"total_amount"];
//    NSString *payType =[arg my_stringForKey:@"payType"];
//    NSString *aToken =[arg my_stringForKey:@"aToken"];

    [MYCustomPaytypeView showMoney:[arg my_stringForKey:@"total_amount"] withView:self.vc.navigationController.view tapIndexBlock:^(NSInteger type) {
     WeakSelf
        if (weakSelf.rechargeMoneyBlock) {
            weakSelf.rechargeMoneyBlock(type, arg);
        }
    }];
    return arg;
}
- (void)attestation:(NSArray *)arr{
    MYSetView *view = [[MYSetView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andPersonTitle:arr];
    view.PushBlock = ^(){
        //nothing;
    };
    [self.vc.navigationController.tabBarController.view addSubview: view];
}
/**
 充值
 **/
-(id)gotoRechargeVc:(id) arg{
    if (![self isSubAccount]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:StoryBoard_MinePage bundle:nil];
        MYRechargeNewViewController *charge = [story instantiateViewControllerWithIdentifier:@"MYRechargeNewViewController"];
        charge.hidesBottomBarWhenPushed = YES;
        [self.vc.navigationController pushViewController:charge animated:YES];
    }
    return arg;
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

/**
 车辆详情
 **/
-(NSString *)gotoCarDetailVc:(NSString *) token{
    Ant_CarDetailNativeViewController *carDetailVC = [[Ant_CarDetailNativeViewController alloc]init];
    carDetailVC.token = token;
    carDetailVC.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:carDetailVC animated:YES];
    return token;
}

/**
注册
 **/
-(id)gotoRegisterVc:(id) arg{
    if (![self.loginuser.user_token isNotEmpty]) {
        //[SVProgressHUD dismiss];
        //[SVProgressHUD showWithStatus:@"登录中 请稍后"];
        [[MYLoginManager sharedManager] loginWithVc:self.vc isRegister:YES loginSuccessBlock:^(NSString *operatorStr,NSString *loginToken) {
            [self.vc jvfLogin:loginToken carrier:operatorStr isRegister:YES];
        } loginFailBlock:^{
            [SVProgressHUD dismiss];

            RegisterVC * vc=nil;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            vc = [storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
            vc.vc = self.vc;
            vc.hidesBottomBarWhenPushed = YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
            
        } loginChangeBlock:^{
            //[self changeLoginType:nav ];
        } authorizationBlock:^{
            [SVProgressHUD showWithStatus:@"登录中 请稍后"];
        }];
       
   }
    return arg;
}

/**
 查维保
 **/

- (id )checkMaintenance:(id *) args
{
    UINavigationController *nav = self.vc.tabBarController.viewControllers[0];
    for (UIViewController *controller in nav.viewControllers) {
        if ([controller isKindOfClass:ANT_MainViewController.class]) {
            ANT_MainViewController *vc = (ANT_MainViewController *)controller;
            vc.idx = 0;
            self.vc.tabBarController.selectedIndex = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.vc.navigationController popViewControllerAnimated:NO];
            });
        }
    }
    
    return  @"SUCCEED";
}

/**
 查碰撞
 **/
- (id )checkInsurance:(id *) args
{
    [self.vc pushNextPage:StoryBoard_Minatenance vcName:@"MYInsTViewController" params:@{@"dVin":@""} animated:YES];
    return  @"SUCCEED";
}

/**
 分享弹窗
 **/

- (NSString *)shareParames:(NSDictionary *) args
{
    NSString  *title = [args my_stringForKey:@"title"];
    NSString  *content = [args my_stringForKey:@"content"];
    NSString  *urlApp = [args my_stringForKey:@"shareUrl"];

    
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
            NSArray *titleArray = @[@"复制链接",@"复制成功",@"确定"];
            [weakSelf attestation:titleArray];
        }
    }];
    return  @"SUCCEED";
}

- (NSString *)shareParames2:(NSDictionary *) args
{
    NSString  *title = [args my_stringForKey:@"title"];
    NSString  *content = [args my_stringForKey:@"content"];
    NSString  *urlApp = [args my_stringForKey:@"shareUrl"];

    
    //创建分享参数
    NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];

    [MGShareMenueView showWithView:self.vc.navigationController.view tapIndexBlock:^(NSInteger tag) {
        if (tag == 2) {
            [UIPasteboard generalPasteboard].string = urlApp;
            NSArray *titleArray = @[@"复制链接",@"复制成功",@"确定"];
            [self attestation:titleArray];
               return;
        }else if(tag == 0){
            [publishContent SSDKSetupShareParamsByText:content
                                                images:@[[UIImage imageNamed:@"icon-180"]]
                                                   url:[NSURL URLWithString:urlApp]
                                                 title:title
                                                  type:SSDKContentTypeAuto];
            //进行分享
            [ShareSDK share:SSDKPlatformSubTypeWechatSession //传入分享的平台类型
                 parameters:publishContent
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                 // 回调处理....}];
             }];
        }else if(tag == 1){
            [MYWebService getRequest:getSharedPosterUrl parameters:@{@"token":self.loginuser.user_token} progress:nil success:^(ErrorCode code, NSString *msg, id data) {
                if (code == 200) {
                    [MYInviteAlertView showAlertWithImageUrl:[data my_stringForKey:@"url"] tapIndexBlock:^(NSInteger tag) {
                        if (tag == 0) {
                            NSMutableDictionary *publishContent = [NSMutableDictionary dictionary];
                            [publishContent SSDKSetupShareParamsByText:content
                                                                images:@[[data my_stringForKey:@"url"]]
                                                                   url:[NSURL URLWithString:urlApp]
                                                                 title:title
                                                                  type:SSDKContentTypeAuto];
                            //进行分享
                            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
                                 parameters:publishContent
                             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                                 // 回调处理....}];
                             }];
                        }else{
                            
                        }
                 
                        
                    }];
                }else{
                    AlertMananger *alert = [[AlertMananger shareManager] creatAlertWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert cancelTitle:@"知道了" otherTitle: nil];
                    [alert showWithViewController:self.vc IndexBlock:^(NSInteger index) {
                    }];
                }

            } failure:^(ErrorCode code, NSString *msg, id data) {
                AlertMananger *alert = [[AlertMananger shareManager] creatAlertWithTitle:@"" message:@"获取海报失败"  preferredStyle:UIAlertControllerStyleAlert cancelTitle:@"知道了" otherTitle: nil];
                [alert showWithViewController:self.vc IndexBlock:^(NSInteger index) {
                }];
            } finish:^(ErrorCode code, NSString *msg, BOOL success) {

            }];
            
        }
       
      }];
    

    return  @"SUCCEED";
}
/**
 返回首页
 **/
-(id)popHomePage:(id)arg{
    [self.vc.navigationController popToRootViewControllerAnimated:YES];
    return arg;
}







- (NSString *) testSyn: (NSString *) msg
{
    return [msg stringByAppendingString:@"[ syn call]"];
}

- (void) testAsyn:(NSString *) msg :(JSCallback) completionHandler
{
    completionHandler([msg stringByAppendingString:@" [ asyn call]"],YES);
}

- (NSString *)testNoArgSyn:(NSDictionary *) args
{
    return  @"testNoArgSyn called [ syn call]";
}

- ( void )testNoArgAsyn:(NSDictionary *) args :(JSCallback)completionHandler
{
    completionHandler(@"testNoArgAsyn called [ asyn call]",YES);
}

- ( void )callProgress:(NSDictionary *) args :(JSCallback)completionHandler
{
    value=10;
    hanlder=completionHandler;
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)onTimer:t{
    if(value!=-1){
        hanlder([NSNumber numberWithInt:value--],NO);
    }else{
        hanlder(0,YES);
        [timer invalidate];
    }
}

/**
 * Note: This method is for Fly.js
 * In browser, Ajax requests are sent by browser, but Fly can
 * redirect requests to native, more about Fly see  https://github.com/wendux/fly
 * @param requestInfo passed by fly.js, more detail reference https://wendux.github.io/dist/#/doc/flyio-en/native
 */
-(void)onAjaxRequest:(NSDictionary *) requestInfo  :(JSCallback)completionHandler{
    
}
@end
