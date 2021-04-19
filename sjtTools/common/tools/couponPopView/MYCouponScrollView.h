//
//  MYCouponScrollView.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MYCouponScrollView;
@protocol MYCouponScrollViewDelegate <NSObject>

- (void) carouselTouch:(MYCouponScrollView*)carousel atIndex:(NSUInteger)index;

@end
@interface MYCouponScrollView : UIView

@property (nonatomic, copy) void(^bannerTouchBlock)(NSUInteger index);

@property (nonatomic, weak) id<MYCouponScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  轮播图url数组
 *
 */
- (void)setupWithArray:(NSArray *)array;

/**
 *  本地图片数组；
 */
- (void)setupWithLocalArray:(NSArray *)array;

/**
 *  类初始化方法；
 *
 */
+ (instancetype)initWithFrame:(CGRect)frame
                    withArray:(NSArray*)array
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter;

+ (instancetype)initWithFrame:(CGRect)frame
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter
                  placeHolder:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END
