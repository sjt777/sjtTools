//
//  UIView+Extension.h
//  antQueen
//
//  Created by 寇广超 on 17/7/29.
//  Copyright (c) 2015年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@interface UIView (Extension)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;


-(UIFont *)showFont:(UIFont *)showFont standbyFont:(UIFont*)standbyFont;

- (UIViewController *)viewController;

- (BaseVC *)baseViewController;

-(void)removeAllSubviews;

- (void)acs_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

- (void)addClickedBlock:(void(^)(id obj))tapAction;
-(void)removeGesture;
@end
