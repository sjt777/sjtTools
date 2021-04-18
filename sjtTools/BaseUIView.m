//
//  BaseView.m
//  testDemo
//
//  Created by sjt on 2021/4/18.
//  Copyright © 2021 sjt. All rights reserved.
//

#import "BaseUIView.h"
#import <objc/runtime.h>
@implementation BaseUIView

-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end

@implementation BaseCornerView

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}

@end
@implementation BaseUIImageView
-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
static NSString *imMasksToBoundsKey = @"masksToBounds";
-(void)setMasksToBounds:(BOOL)masksToBounds{
    objc_setAssociatedObject(self, &imMasksToBoundsKey, @(masksToBounds), OBJC_ASSOCIATION_COPY);
}
static NSString *imShadowRadiusKey = @"shadowRadius";
- (void)setShadowRadius:(CGFloat)shadowRadius{
    objc_setAssociatedObject(self, &imShadowRadiusKey, @(shadowRadius), OBJC_ASSOCIATION_COPY);
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return [objc_getAssociatedObject(self, &imMasksToBoundsKey) boolValue];
}
- (CGFloat)shadowRadius{
    return [objc_getAssociatedObject(self, &imShadowRadiusKey) boolValue];;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end

@implementation BaseCornerImageView

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end
@implementation BaseUILabel
 -(void)setCornerRadius:(CGFloat)cornerRadius{
     self.layer.cornerRadius = cornerRadius;
 }
 -(void)setBorderColor:(UIColor *)borderColor{
     self.layer.borderColor = borderColor.CGColor;
 }
 -(void)setBorderWidth:(CGFloat)borderWidth{
     self.layer.borderWidth = borderWidth;
 }
 -(void)setMasksToBounds:(BOOL)masksToBounds{
     self.layer.masksToBounds = masksToBounds;
 }
 - (void)setShadowRadius:(CGFloat)shadowRadius{
     self.layer.shadowRadius = shadowRadius;
 }
 - (void)setShadowOpacity:(float)shadowOpacity{
     self.layer.shadowOpacity = shadowOpacity;
 }
 - (void)setShadowOffset:(CGSize)shadowOffset{
     self.layer.shadowOffset = shadowOffset;
 }
 - (void)setShadowColor:(UIColor *)shadowColor{
     self.layer.shadowColor = shadowColor.CGColor;
 }
 /*get*/
 - (CGFloat)cornerRadius{
     return self.layer.cornerRadius;
 }
 - (CGFloat)borderWidth{
     return self.layer.borderWidth;
 }
 - (UIColor *)borderColor{
     return [UIColor colorWithCGColor:self.layer.borderColor];
 }
 -(BOOL)masksToBounds{
     return self.layer.masksToBounds;
 }
 - (CGFloat)shadowRadius{
     return self.layer.shadowRadius;
 }
 - (float)shadowOpacity{
     return self.layer.shadowOpacity;
 }
 - (CGSize)shadowOffset{
     return  self.layer.shadowOffset;
 }
 - (UIColor *)shadowColor{
     return [UIColor colorWithCGColor:self.layer.shadowColor];
 }

- (void)setPadding:(UIEdgeInsets)padding {
    self.top_padding = padding.top;
    self.left_padding = padding.left;
    self.right_padding = padding.right;
    self.bottom_padding = padding.bottom;
}
- (UIEdgeInsets)padding {
    return UIEdgeInsetsMake(self.top_padding, self.left_padding, self.bottom_padding, self.right_padding);
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.padding)];
}

- (CGSize)intrinsicContentSize {
    CGSize superContentSize = [super intrinsicContentSize];
    CGFloat width = superContentSize.width + self.left_padding + self.right_padding;
    CGFloat height = superContentSize.height + self.top_padding + self.bottom_padding;
    return CGSizeMake(width, height);
}

@end
@implementation BaseCornerLabel

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end


/*
 BaseUIButton
 **/
@implementation BaseUIButton
-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end

@implementation BaseCornerButton

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end

/*
BaseUIButton
**/
@implementation BaseUITextField

- (void)setAttPlaceholder:(NSDictionary *)attPlaceholder {
    if (self.placeholder.length > 0) {
    NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:attPlaceholder];
    self.attributedPlaceholder = arrStr;
    }
}
-(void)attPlaceholderFont:(UIFont *)font placeholderColor:(UIColor *)color{
    if (self.placeholder.length > 0) {
    NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:    @{NSForegroundColorAttributeName :color,NSFontAttributeName:font}];
      self.attributedPlaceholder = arrStr;
    }
}
-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
- (void)setPlaceholderFont:(float)placeholderFont{
    if (placeholderFont > 0 ) {
        if (self.placeholder.length > 0) {
            NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:placeholderFont]}];
            self.attributedPlaceholder = arrStr;

        }
    }
}
- (float)placeholderFont{
    return self.placeholderFont;
}
- (void)setPlaceholderColor:(NSString *)placeholderColor{
    if (placeholderColor) {
        if (self.placeholder.length > 0) {
            NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : hexColor(placeholderColor)}];
            self.attributedPlaceholder = arrStr;

        }
    }
}
- (NSString *)placeholderColor{
    return self.placeholderColor;
}
@end
@implementation BaseCornerTextField

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end

/**
 BaseUITextView
 */
@implementation BaseUITextView

-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end
@implementation BaseCornerTextView

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end

@implementation BaseUIScrollView
- (instancetype)init
{
    if (self = [super init]) {
        if (@available(iOS 11.0, *)) {
              self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          }
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    if (@available(iOS 11.0, *)) {
          self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
      }
}

-(void)endRefresh{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end
@implementation BaseCornerScrollView

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end
@implementation BaseUICollectionView

-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end

@implementation BaseCornerCollectionView

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end
@implementation BaseUITableView : UITableView

- (instancetype)init
{
    if (self = [super init]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
              self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          }else {
             // self.automaticallyAdjustsScrollIndicatorInsets = NO;
          }
        self.page = 1;

    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
          self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
      }else {
         // self.automaticallyAdjustsScrollViewInsets = NO;
      }
    self.page = 1;

}
- (void)initRefresh{
    [self initHeaderRefresh];
    [self initFooterRefresh];
}
-(void)beginRefreshing{
    [self.mj_header beginRefreshing];
}
- (void)initHeaderRefresh
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self.baseViewController  requestList];
    }];
}
- (void)initFooterRefresh
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
      self.page ++;
      [self.baseViewController  requestList];

    }];
  
}
-(void)endRefresh{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}
-(void)setCornerRadius:(CGFloat)cornerRadius{
    //self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
/*get*/
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (CGSize)shadowOffset{
    return  self.layer.shadowOffset;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
@end
@implementation BaseCornerTableView

- (void)setTop_left:(BOOL)top_left{
    _top_left = top_left;
    _corners |= UIRectCornerTopLeft;
}
- (void)setTop_right:(BOOL)top_right{
    _top_right = top_right;
    _corners |= UIRectCornerTopRight;
}
- (void)setBottom_left:(BOOL)bottom_left{
    _bottom_left = bottom_left;
    _corners |= UIRectCornerBottomLeft;
}
- (void)setBottom_right:(BOOL)bottom_right{
    _bottom_right = bottom_right;
    _corners |= UIRectCornerBottomRight;
}
- (void)setCornerAll:(BOOL)cornerAll{
    _cornerAll = cornerAll;
    _corners = UIRectCornerAllCorners;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_corners && self.cornerRadius ) {
         UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.frame = self.bounds;
           maskLayer.path = maskPath.CGPath;
           self.layer.mask = maskLayer;
    }
   
}
@end

@implementation BaseGestureTableView
- (instancetype)init
{
    if (self = [super init]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
              self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          }else {
             // self.automaticallyAdjustsScrollIndicatorInsets = NO;
          }
        self.page = 1;

    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
          self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
      }else {
         // self.automaticallyAdjustsScrollViewInsets = NO;
      }
    self.page = 1;

}
/*
* 是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播
*/
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //return YES;
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];

}
//是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO，上层对象识别后则不再继续传播；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行。

@end
@implementation BaseUITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    
    //static NSString *rid = @"BaseUITableViewCell";
    BaseUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   
    return cell;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    //static NSString *rid = @"BaseUITableViewCell";
    NSString *responseClass = NSStringFromClass([self class]);

    BaseUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[NSClassFromString(responseClass) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:responseClass];
    }
    
    return cell;
}
+ (NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    
    return self;
}
-(void)setup{
    
}
+ (instancetype)xibCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    BaseUITableViewCell *cell= [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][0];
       return cell;
}
 + (instancetype)xibCellWithTableView:(UITableView *)tableView{
     
     //static NSString *cellId = @"BaseUITableViewCell";
     BaseUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
     if (!cell) {
         cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][0];
     }
     return cell;
 }
+ (instancetype)xibCellWithTableView:(UITableView *)tableView index:(NSInteger)index{
    
    //static NSString *cellId = @"BaseUITableViewCell";
    BaseUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][index];
    }
    return cell;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
@end
@implementation BaseUICollectionViewCell

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
@end
