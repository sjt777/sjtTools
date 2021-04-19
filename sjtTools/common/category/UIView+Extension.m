//
//  UIView+Extension.m
//  antQueen
//
//  Created by 寇广超 on 17/7/29.
//  Copyright (c) 2015年 yibyi. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/message.h>

@interface UIView ()
@property (nonatomic,copy)void(^clickedAction)(id);
@end
@implementation UIView (Extension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
//kgc
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (BaseVC *)baseViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[BaseVC class]]) {
            return (BaseVC *)nextResponder;
        }
    }
    return nil;
}
-(UIFont *)showFont:(UIFont *)showFont standbyFont:(UIFont*)standbyFont{
    
    if (showFont == nil) {
        return standbyFont;
    }else{
        return showFont;
    }
}
-(void)removeAllSubviews
{
    while ([self.subviews count] > 0) {
        [[self.subviews objectAtIndex:0] removeFromSuperview];
    }
    
}
- (void)acs_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}
- (void)setClickedAction:(void (^)(id))clickedAction{
    objc_setAssociatedObject(self, @"AddClickedEvent", clickedAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))clickedAction{
    return objc_getAssociatedObject(self, @"AddClickedEvent");
}
- (void)addClickedBlock:(void(^)(id obj))clickedAction{
     self.clickedAction = clickedAction;
    // hy:先判断当前是否有交互事件，如果没有的话。。。所有gesture的交互事件都会被添加进gestureRecognizers中
     if (![self gestureRecognizers]) {
         self.userInteractionEnabled = YES;
         // hy:添加单击事件
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
         [self addGestureRecognizer:tap];
    }
}
-(void)removeGesture{
    NSMutableArray *newges = [NSMutableArray arrayWithArray:self.gestureRecognizers];
       for (int i =0; i<[newges count]; i++) {
           [self removeGestureRecognizer:[newges objectAtIndex:i]];
       }
}
- (void)tap{
    if (self.clickedAction) {
        self.clickedAction(self);
    }
}
@end
