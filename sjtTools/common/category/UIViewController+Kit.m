////
////  UIViewController+Kit.m
////  papayaCar_app
////
////  Created by 寇广超 on 2019/9/16.
////  Copyright © 2019 ruiheng. All rights reserved.
////
//
//#import "UIViewController+Kit.h"
//#import "UIImage+Color.h"
//#import <objc/runtime.h>
//
//static const char VcBundle_;
//static const char VcCloseDelegate_;
//
//static void *VcPhotoBlock_;
//static void *VcMaxCount_;
//
//
//@interface UIViewController(kit)
//{
//
//}
//
//@end
//
//@implementation UIViewController (Kit)
//
//@dynamic Token, bundle, closeDelegate;
//
//
//
//#pragma mark - proporty
//- (NSString*)Token {
////    return [[NSUserDefaults standardUserDefaults] stringForKey:kUDToken];
//    return @"";
//}
//
//- (void)setToken:(NSString *)Token {
////    if(Token == nil)
////        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUDToken];
////    [[NSUserDefaults standardUserDefaults] setObject:Token forKey:kUDToken];
//}
//
//
//
//- (void)viewDefaults {
//    self.view.backgroundColor = hexColor(ffffff);
//    if (self.navigationController) {
////        if ([self.navigationController.viewControllers count] > 1) {
////            [self addBackBarButton:YES];
////        } else {
////            [self addBackBarButton:NO];
////        }
//
//    }
//    [self setNavBarWhite];
//
//
//}
//- (void)setNavBarWhite {
//
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//    //backItem.title = @"";
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back_arrow"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_arrow"]];
//    self.navigationItem.backBarButtonItem = backItem;
//    //backItem.tintColor=[UIColor colorWithRed:129/255.0 green:129/255.0  blue:129/255.0 alpha:1.0];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    //[[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"nav_line"]];
//    self.navigationController.navigationBar.translucent = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;//状态栏颜色
//
//    self.navigationController.navigationBar.tintColor = hexColor(333333);//返回按钮颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : hexColor(333333),NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];//title字体颜色
//
//    //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//
//
//}
//- (NSDictionary*)bundle {
//    NSDictionary* bundle = objc_getAssociatedObject(self, &VcBundle_);
//    return bundle;
//}
//
//- (void)setBundle:(NSDictionary *)bundle {
//    objc_setAssociatedObject(self, &VcBundle_, bundle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (id<VcCloseDelegate>)closeDelegate {
//    return objc_getAssociatedObject(self, &VcCloseDelegate_);
//}
//
//- (void)setCloseDelegate:(id<VcCloseDelegate>)closeDelegate {
//    objc_setAssociatedObject(self, &VcCloseDelegate_, closeDelegate, OBJC_ASSOCIATION_ASSIGN);
//}
//
//
//
//- (void)setPhotoBlock:(PhotoBlock)photoBlock {
//    objc_setAssociatedObject(self, &VcPhotoBlock_, photoBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (PhotoBlock)photoBlock {
//    return objc_getAssociatedObject(self, &VcPhotoBlock_);
//}
//
//- (void)setMaxCount:(NSUInteger)maxCount {
//    objc_setAssociatedObject(self, &VcMaxCount_, @(maxCount), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (NSUInteger)maxCount {
//    return [objc_getAssociatedObject(self, &VcMaxCount_) integerValue];
//}
//
//
//
//
///**
// *  清除notification observer
// *
// *  @param notification
// */
//- (void)notificationTokenInvalid:(NSNotification*)notification {
//
//}
//
//- (void)notificationTokenInvalid_:(NSNotification*)notification {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    if([self respondsToSelector:@selector(notificationTokenInvalid:)])
//        [self notificationTokenInvalid:notification];
//}
//
//- (void)postNotification:(NSString *)name object:(id)obj {
//    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
//}
//
//- (void)backAction {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)dismissVC {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//#pragma mark - notification selector
///**
// *  buyer刷新
// *  override
// *  param notification
// */
//- (void)notificationCanRefreshBuyer:(NSNotification*)notification {
//
//}
//
//- (id)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas {
//    return [self pushNextPage:storyName vcName:vcName params:parmas animated:YES];
//}
///**
// *  自动从Storyboard创建视图
// */
//+(instancetype)vcFromStoryboard:(NSString *)storyName {
//    UIStoryboard* story;
//
//    NSString *vcName=NSStringFromClass(self);
//
////    if([storyName length] == 0)
////        story = self->storyboard;
////    else
//    story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//
//    UIViewController* vc;
//
//    if([storyName length] == 0)
//        vc = [story instantiateInitialViewController];
//    else
//        vc = [story instantiateViewControllerWithIdentifier:vcName];
//
//    return vc;
//}
//- (id)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas Nav:(UINavigationController *)nav animated:(BOOL)animated{
//    UIStoryboard* story;
//
//    if([storyName length] == 0)
//        story = self.storyboard;
//    else
//        story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//
//    UIViewController* vc;
//
//    if([vcName length] == 0)
//        vc = [story instantiateInitialViewController];
//    else
//        vc = [story instantiateViewControllerWithIdentifier:vcName];
//
//    vc.bundle = parmas;
//
//    if([self conformsToProtocol:@protocol(VcCloseDelegate)]) {
//        vc.closeDelegate = self;
//    }
//    vc.hidesBottomBarWhenPushed = YES;
//    [nav pushViewController:vc animated:animated];
//
//    /*
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }*/
//
//    return vc;
//}
//- (id)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas animated:(BOOL)animated{
//    UIStoryboard* story;
//
//    if([storyName length] == 0)
//        story = self.storyboard;
//    else
//        story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//
//    UIViewController* vc;
//
//    if([vcName length] == 0)
//        vc = [story instantiateInitialViewController];
//    else
//        vc = [story instantiateViewControllerWithIdentifier:vcName];
//
//    vc.bundle = parmas;
//
//    if([self conformsToProtocol:@protocol(VcCloseDelegate)]) {
//        vc.closeDelegate = self;
//    }
//    // 适配iOS14 A-B-C 从C-A tabbar不显示问题
//    if (self.navigationController.viewControllers.count > 0) {
//        if (self.navigationController.viewControllers.count == 1) {
//            vc.hidesBottomBarWhenPushed = YES;
//        }else{
//            vc.hidesBottomBarWhenPushed = NO;
//        }
//    }else{
//        vc.hidesBottomBarWhenPushed = NO;
//    }
////    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:animated];
//
//    /*
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }*/
//
//    return vc;
//}
//
//- (void)presentNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas {
//    UIStoryboard* story;
//
//    if([storyName length] == 0)
//        story = self.storyboard;
//    else
//        story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//
//    UIViewController* vc;
//
//    if([vcName length] == 0)
//        vc = [story instantiateInitialViewController];
//    else
//        vc = [story instantiateViewControllerWithIdentifier:vcName];
//
//    vc.bundle = parmas;
//
//    if([self conformsToProtocol:@protocol(VcCloseDelegate)]) {
//        vc.closeDelegate = self;
//    }
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
//}
//
//
//#pragma mark - VcCloseDelegate
//- (void)vcClose:(id)value withClass:(Class)c {
//
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}
//
//@end
