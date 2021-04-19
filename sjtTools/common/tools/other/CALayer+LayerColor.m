//
//  CALayer+LayerColor.m
//  antQueen
//
//  Created by 寇广超 on 2017/3/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)
- (void)setBorderColorFromUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}
-(void)setShadowColorWithUIColor:(UIColor *)color{
    self.shadowColor = color.CGColor;
}


-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}
 
-(UIColor *)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}
 
-(void)setShadowUIColor:(UIColor*)color
{
    self.shadowColor = color.CGColor;
}
 
-(UIColor *)shadowUIColor
{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
