//
//  UIButton+ANTAdd.m
//  antQueen
//
//  Created by 寇广超 on 2017/5/8.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "UIButton+ANTAdd.h"

@implementation UIButton (ANTAdd)

-(void)setButtonImageTitleStyle
{
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    float imageW = self.imageView.frame.size.width;
    float imageH = self.imageView.frame.size.height;
    float labelH = 0.0;
    float labelW = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelW = self.titleLabel.intrinsicContentSize.width;
        labelH = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelW = self.titleLabel.frame.size.width;
        labelH = self.titleLabel.frame.size.height;
    }
    imageEdgeInsets = UIEdgeInsetsMake(-labelH-5, 0, 0, -labelW);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageW, -imageH-5, 0);
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
-(void)setButtonImageTitleLeft
{
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    float imageW = self.imageView.frame.size.width;
    float imageH = self.imageView.frame.size.height;
    float labelH = 0.0;
    float labelW = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelW = self.titleLabel.intrinsicContentSize.width;
        labelH = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelW = self.titleLabel.frame.size.width;
        labelH = self.titleLabel.frame.size.height;
    }
    imageEdgeInsets = UIEdgeInsetsMake(-labelH-5, 0, 0, -labelW);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageW, -imageH-5, 0);
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end
