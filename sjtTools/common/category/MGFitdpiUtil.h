//
//  MGFitdpiUtil.h
//  papayaCar_app
//
//  Created by 寇广超 on 2019/8/22.
//  Copyright © 2019 ruiheng. All rights reserved.
//
#import <UIkit/UIKit.h>

#import <Foundation/Foundation.h>
#define kRefereWidth 375.0 // 参考宽度
#define kRefereHeight 667.0 // 参考高度

#define AdaptW(floatValue) [MGFitdpiUtil adaptWidthWithValue:floatValue]

NS_ASSUME_NONNULL_BEGIN

@interface MGFitdpiUtil : NSObject
+(CGFloat)adaptWidthWithValue:(CGFloat)floatV;

@end

NS_ASSUME_NONNULL_END
