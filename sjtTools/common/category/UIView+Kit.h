//
//  UIView+Kit.h
//  antQueen
//
//  Created by 寇广超 on 2017/3/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Kit)

/*
 添加边框
 默认边框颜色: MF_BORDERCOLOR_DEFAULT
 */
- (void)addBorderWithBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

/*
添加边框
 默认边框颜色: MF_BORDERCOLOR_DEFAULT
 */
- (void)setBorderToTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/**
 *切圆角边缘
 */
- (void)setCornerRadiusWithCornerRadius:(CGFloat)cornerRadius;

@end
