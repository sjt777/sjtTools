//
//  UIViewController+MYBackButtonHandler.h
//  antQueen
//
//  Created by 寇广超 on 2018/6/7.
//  Copyright © 2018年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
-(BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (MYBackButtonHandler) <BackButtonHandlerProtocol>

@end
