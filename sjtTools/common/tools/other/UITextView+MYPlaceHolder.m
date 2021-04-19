//
//  UITextView+MYPlaceHolder.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/26.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "UITextView+MYPlaceHolder.h"
#import <objc/runtime.h>
static const void *my_placeHolderKey;

@interface UITextView ()
@property (nonatomic, readonly) UILabel *my_placeHolderLabel;
@end
@implementation UITextView (MYPlaceHolder)
+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(myPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(myPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(myPlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)myPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self myPlaceHolder_swizzled_dealloc];
}
- (void)myPlaceHolder_swizzling_layoutSubviews {
    if (self.my_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.my_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.my_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self myPlaceHolder_swizzling_layoutSubviews];
}
- (void)myPlaceHolder_swizzled_setText:(NSString *)text{
    [self myPlaceHolder_swizzled_setText:text];
    if (self.my_placeHolder) {
        [self updatePlaceHolder];
    }
}
#pragma mark - associated
-(NSString *)my_placeHolder{
    return objc_getAssociatedObject(self, &my_placeHolderKey);
}
-(void)setMy_placeHolder:(NSString *)my_placeHolder{
    objc_setAssociatedObject(self, &my_placeHolderKey, my_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
-(UIColor *)my_placeHolderColor{
    return self.my_placeHolderLabel.textColor;
}
-(void)setMy_placeHolderColor:(UIColor *)my_placeHolderColor{
    self.my_placeHolderLabel.textColor = my_placeHolderColor;
}
-(NSString *)placeholder{
    return self.my_placeHolder;
}
-(void)setPlaceholder:(NSString *)placeholder{
    self.my_placeHolder = placeholder;
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.my_placeHolderLabel removeFromSuperview];
        return;
    }
    self.my_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.my_placeHolderLabel.textAlignment = self.textAlignment;
    self.my_placeHolderLabel.text = self.my_placeHolder;
    [self insertSubview:self.my_placeHolderLabel atIndex:0];
}
#pragma mark - lazzing
-(UILabel *)my_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(my_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(my_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
