//
//  MYAppGradeManager.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/29.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYAppGradeManager.h"
@implementation MYAppGradeManager
static NSString * const wAPPID = @"1396313134";
+ (void)itunesWriteReview{
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", wAPPID];
    [self applicationOpenURL:[NSURL URLWithString:urlString]];
}
+ (void)displayAppReview:(UIViewController*)vc {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"喜欢APP吗?\n给个五星好评吧，亲!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    /// 跳转APPStore中应用的撰写评价页面
    UIAlertAction *review = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self itunesWriteReview];;
    }];
    
    UIAlertAction *noReview = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController removeFromParentViewController];
    }];
    
    [alertController addAction:review];
    [alertController addAction:noReview];
    
    /// 是否添加五星好评入口
    if (@available(iOS 10.3, *)) {
        if ([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
            //            UIAlertAction *fiveStar = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                [[UIApplication sharedApplication].keyWindow endEditing:YES];
            //                [SKStoreReviewController requestReview];
            //            }];
            //            [alertController addAction:fiveStar];
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
        }
    }else{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"喜欢APP吗?\n给个五星好评吧，亲!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        /// 跳转APPStore中应用的撰写评价页面
        UIAlertAction *review = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self itunesWriteReview];;
        }];
        
        UIAlertAction *noReview = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertController removeFromParentViewController];
        }];
        [alertController addAction:review];
        [alertController addAction:noReview];
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc presentViewController:alertController animated:YES completion:^{ }];
        });
    }
    
    
}

+(void)applicationOpenURL:(NSURL *)url {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
        if (canOpen) {
            if (@available(iOS 10.0, *)) {
                NSDictionary *options = @{};
                [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {}];
            }
            else {
                [[UIApplication sharedApplication] openURL:url];
            };
        }
    });
}
@end
