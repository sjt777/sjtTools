//
//  CALayer+LayerColor.h
//  antQueen
//
//  Created by 寇广超 on 2017/3/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/**
  在xib和storyboard里修改外框颜色
 
 */
@interface CALayer (LayerColor)
- (void)setBorderColorFromUIColor:(UIColor *)color;
-(void)setShadowColorWithUIColor:(UIColor *)color;

@property(nonatomic, assign) UIColor *borderUIColor;
@property(nonatomic, assign) UIColor *shadowUIColor;

@end
