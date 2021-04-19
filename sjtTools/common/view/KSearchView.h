//
//  KSearchView.h
//  antQueen
//
//  Created by 王明星 on 15/7/29.
//  Copyright (c) 2015年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSearchView;

@protocol KSearchViewDelegate<NSObject>
@optional
- (void)searchViewDidDismiss:(KSearchView *)SearchView;
- (void)searchViewDidShow:(KSearchView *)SearchView;

@end

@interface KSearchView : UIView

@property (nonatomic,weak) id<KSearchViewDelegate> delegate;

+ (instancetype)searchView;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;


/**
 *  销毁
 */
- (void)dismiss;


@end
