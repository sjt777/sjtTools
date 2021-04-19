//
//  MYBaseTextField.m
//  antQueen
//
//  Created by yixiuge on 2017/7/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "MYBaseTextField.h"
@implementation MYBaseTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
                
    }
    return self;
}
//控制清除按钮的位置
//- (void)setPlaceholderFont:(UIFont *)placeholderFont{
//    self.placeholderFont = placeholderFont;
//}
//-(UIFont *)placeholderFont{
//    return self.placeholderFont;
//}
//- (UIColor *)placeholderColor{
//    return self.placeholderColor;
//}
//- (void)setPlaceholderColor:(UIColor *)placeholderColor{
//    self.placeholderColor = placeholderColor;
//}
-(CGRect)clearButtonRectForBounds:(CGRect)bounds

{
    CGFloat x = CGRectGetMaxX(bounds) - 15 - 10;
    //    CGFloat y =  CGRectGetMidY(bounds) - 15/2;
    
    CGFloat y =   CGRectGetHeight(bounds)/2 - 15/2;
    CGFloat w = 15;
    CGFloat h = 15;
    return CGRectMake(x, y, w, h);
//    return CGRectMake(bounds.origin.x + bounds.size.width - 25, bounds.origin.y + bounds.size.height -20, 15, 15);
    
}
//控制placeHolder的颜色、字体
-(void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:
                              @{NSFontAttributeName : self.placeholderFont ? self.placeholderFont : self.font}];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = self.textAlignment;//对齐方式
    [self.placeholder drawInRect:CGRectMake(0, (rect.size.height - placeholderSize.height)/2, rect.size.width, rect.size.height) withAttributes:
     @{NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName : self.placeholderColor?self.placeholderColor:hexColor(999999),
       NSFontAttributeName : self.placeholderFont ? self.placeholderFont : self.font}];
}
/*

//控制placeHolder的位置，左右缩20

-(CGRect)placeholderRectForBounds:(CGRect)bounds

{
    
    
    //return CGRectInset(bounds, 20, 0);
    
    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    
    return inset;
    
}

//控制显示文本的位置

-(CGRect)textRectForBounds:(CGRect)bounds

{
 
    return CGRectInset(bounds, 50, 0);
 
    CGRect inset = CGRectMake(bounds.origin.x+190, bounds.origin.y, bounds.size.width -10, bounds.size.height);更好理解些
 
 
    return inset;
 
 
}

//控制编辑文本的位置

-(CGRect)editingRectForBounds:(CGRect)bounds

{
    
    //return CGRectInset( bounds, 10 , 0 );
    
    
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    
    return inset;
    
}

//控制左视图位置

- (CGRect)leftViewRectForBounds:(CGRect)bounds

{
    
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
    
    return inset;
    
    //return CGRectInset(bounds,50,0);
    
}


*/
@end
