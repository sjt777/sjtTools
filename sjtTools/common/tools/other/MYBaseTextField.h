//
//  MYBaseTextField.h
//  antQueen
//
//  Created by yixiuge on 2017/7/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface MYBaseTextField : UITextField<UITextFieldDelegate>

@property (nonatomic, strong) IBInspectable UIFont *placeholderFont;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end
