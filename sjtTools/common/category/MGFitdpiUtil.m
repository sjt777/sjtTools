//
//  MGFitdpiUtil.m
//  papayaCar_app
//
//  Created by 寇广超 on 2019/8/22.
//  Copyright © 2019 ruiheng. All rights reserved.
//

#import "MGFitdpiUtil.h"

@implementation MGFitdpiUtil

+ (CGFloat)adaptWidthWithValue:(CGFloat)floatV;
{
    return floatV*[[UIScreen mainScreen] bounds].size.width/kRefereWidth;
}

@end
