//
//  MYCoponPageControl.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYCoponPageControl.h"

@implementation MYCoponPageControl


- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算圆点间距
    CGFloat currentMarginX = self.currentImageSize.width + self.magrin;
    CGFloat inactiveMarginX = self.inactiveImageSize.width + self.magrin;

    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 2 ) * currentMarginX + inactiveMarginX;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW + self.currentImageSize.width, self.frame.size.height);
    self.centerX = self.superview.frame.size.width *0.5;

    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * currentMarginX, dot.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height)];
        }else {
            [dot setFrame:CGRectMake(i * inactiveMarginX, dot.frame.origin.y, self.inactiveImageSize.width, self.inactiveImageSize.height)];
        }
    }
}


- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}

- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            dot.image = self.currentImage;
            dot.size = self.currentImageSize;
            if (self.currentRadius) {
                dot.layer.cornerRadius = self.currentRadius;
                dot.layer.masksToBounds = YES;
            }
        }else{
            dot.image = self.inactiveImage;
            dot.size = self.inactiveImageSize;
            if (self.inactiveRadius) {
                dot.layer.cornerRadius = self.inactiveRadius;
                dot.layer.masksToBounds = YES;

            }
        }
    }
}

- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        view.backgroundColor = UIColor.clearColor;
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}



@end
