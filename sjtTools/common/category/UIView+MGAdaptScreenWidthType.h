//
//  UIView+MGAdaptScreenWidthType.h
//  papayaCar_app
//
//  Created by 寇广超 on 2019/8/22.
//  Copyright © 2019 ruiheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGAdaptScreenWidthType) {
    AdaptScreenWidthTypeNone = 0,
    MGAdaptScreenWidthTypeConstraint = 1<<0, /**< 对约束的constant等比例 */
    MGAdaptScreenWidthTypeFontSize = 1<<1, /**< 对字体等比例 */
    MGAdaptScreenWidthTypeCornerRadius = 1<<2, /**< 对圆角等比例 */
    MGAdaptScreenWidthTypeAll = 1<<3, /**< 对现有支持的属性等比例 */
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MGAdaptScreenWidthType)
/**
 遍历当前view对象的subviews和constraints，对目标进行等比例换算
 
 @param type 想要和基准屏幕等比例换算的属性类型
 @param exceptViews 需要对哪些类进行例外
 */
- (void)adaptScreenWidthWithType:(MGAdaptScreenWidthType)type
                     exceptViews:(NSArray<Class> *)exceptViews;

@end

NS_ASSUME_NONNULL_END
