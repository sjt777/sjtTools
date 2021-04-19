//
//  NSLayoutConstraint+MGIBDesignable.h
//  papayaCar_app
//
//  Created by 寇广超 on 2019/8/22.
//  Copyright © 2019 ruiheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSLayoutConstraint (MGIBDesignable)
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

@interface UILabel (FixFont)

@property (nonatomic, assign)IBInspectable float fixFont;

@end
@interface UIButton (FixFont)

@property (nonatomic, assign)IBInspectable float fixFont;

@end@interface UITextField (FixFont)

@property (nonatomic, assign)IBInspectable float fixFont;

@end@interface UITextView (FixFont)

@property (nonatomic, assign)IBInspectable float fixFont;

@end
