//
//  UIFont+PingFang.m
//  antQueen
//
//  Created by 寇广超 on 2018/7/3.
//  Copyright © 2018年 yibyi. All rights reserved.
//

#import "UIFont+PingFang.h"

@implementation UIFont (PingFang)

+ (UIFont *)my_pingfangFontName:(NSString *)fontName  withSize:(CGFloat)size{
    if (@available(iOS 9.0, *)) {
        return [UIFont fontWithName:fontName size:size];
    }else {
        return [UIFont systemFontOfSize:size];
    }
}
@end
