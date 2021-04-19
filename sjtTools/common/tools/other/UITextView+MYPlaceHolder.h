//
//  UITextView+MYPlaceHolder.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/26.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (MYPlaceHolder)
@property (nonatomic, copy) NSString *my_placeHolder;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UIColor *my_placeHolderColor;
@end

NS_ASSUME_NONNULL_END
