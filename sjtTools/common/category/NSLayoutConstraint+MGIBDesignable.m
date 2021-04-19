//
//  NSLayoutConstraint+MGIBDesignable.m
//  papayaCar_app
//
//  Created by 寇广超 on 2019/8/22.
//  Copyright © 2019 ruiheng. All rights reserved.
//

#import "NSLayoutConstraint+MGIBDesignable.h"
#import <objc/runtime.h>

// 基准屏幕宽度
#define kRefereWidth 375.0
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/kRefereWidth)


@implementation  NSLayoutConstraint (MGIBDesignable)

//定义常量 必须是C语言字符串
static char *AdapterScreenKey = "AdapterScreenKey";

- (BOOL)adapterScreen{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
    return number.boolValue;
}

- (void)setAdapterScreen:(BOOL)adapterScreen {
    
    NSNumber *number = @(adapterScreen);
    objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapterScreen){
        self.constant = AdaptW(self.constant);
    }
}

@end

@implementation UILabel (FixFont)

- (void)setFixFont:(float)fixFont{
    
    if (fixFont > 0 ) {
        self.font = [UIFont systemFontOfSize:AdaptW(fixFont)];
    }else{
        self.font = self.font;
    }
}
- (float )fixFont{
    return self.fixFont;
}

@end
@implementation UIButton (FixFont)

- (void)setFixFont:(float)fixFont{
    
    if (fixFont > 0 ) {
        self.titleLabel.font = [UIFont systemFontOfSize:AdaptW(fixFont)];
    }else{
        self.titleLabel.font = self.titleLabel.font;
    }
}

- (float )fixFont{
    return self.fixFont;
}

@end
@implementation UITextField (FixFont)

- (void)setFixFont:(float)fixFont{
    
    if (fixFont > 0 ) {
        self.font = [UIFont systemFontOfSize:AdaptW(fixFont)];
    }else{
        self.font = self.font;
    }
}

- (float )fixFont{
    return self.fixFont;
}

@end
@implementation UITextView (FixFont)

- (void)setFixFont:(float)fixFont{
    
    if (fixFont > 0 ) {
        self.font = [UIFont systemFontOfSize:AdaptW(fixFont)];
    }else{
        self.font = self.font;
    }
}

- (float )fixFont{
    return self.fixFont;
}

@end
