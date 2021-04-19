//
//  MYForceView.m
//  antQueen
//
//  Created by yixiuge on 17/5/25.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import "MYForceView.h"

@implementation MYForceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame andPersonTitle:(NSArray<NSString * >*)title {
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MYForceView" owner:nil options:nil] objectAtIndex:0];
        [self setFrame: frame];
        //self.lbContentTitle.text = title[0];
        self.lbTitle.text = title[0];
        self.lbContentTitle.text = title[1];
        [self.sureButton setTitle:title[2] forState:UIControlStateNormal];
        [self show];
        
    }
    return self;
    
}
- (void)show {
    
    _centerView.alpha = 0.0;
    
    _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerView.alpha = 1.0;
        _backView.alpha = 0.5;
        _centerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
}
- (IBAction)pushVc:(UIButton *)sender {
    !_PushBlock ?: _PushBlock();
    if (self.isHide) {
        [UIView animateWithDuration:0.3 animations:^{
            _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
            _centerView.alpha = 0.0;
            _backView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
    
        }];
    }

    
}

- (IBAction)hide:(UITapGestureRecognizer *)sender {
//    [UIView animateWithDuration:0.3 animations:^{
//        _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
//        _centerView.alpha = 0.0;
//        _backView.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        
//    }];
    
}

@end
