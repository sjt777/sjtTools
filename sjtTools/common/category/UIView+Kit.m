//
//  UIView+Kit.m
//  antQueen
//
//  Created by 寇广超 on 2017/3/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "UIView+Kit.h"

@implementation UIView (Kit)

//设置全身边框
- (void)addBorderWithBorderWidth:(CGFloat)width borderColor:(UIColor *)color{
    //设置layer
    CALayer *layer=[self layer];
    //设置边框线的宽
    [layer setBorderWidth:width];
    //设置边框线的颜色
    [layer setBorderColor:[color CGColor]];
}

//添加边框
- (void)setBorderToTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    
    if (color == nil) {
        color = hexColor(cccccc);
    }
    
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

- (void)setCornerRadiusWithCornerRadius:(CGFloat)cornerRadius{
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
}

@end
