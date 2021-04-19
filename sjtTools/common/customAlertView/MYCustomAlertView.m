//
//  MYCustomAlertView.m
//  antQueen
//
//  Created by 寇广超 on 2019/7/29.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYCustomAlertView.h"

@implementation MYCustomAlertView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MYCustomAlertView" owner:nil options:nil] objectAtIndex:0];
        [self setFrame: frame];
        self.titleLb.text = title;
        self.contentLb.text = content;
        [self show];
    }
    return self;
    
}
+(id)showAlertWithTitle:(NSString *)title content:(NSString *)content superView:(UIView *)view {
    MYCustomAlertView *alertView = [[self alloc]initWithFrame:view.bounds  title:title content:content];
    [view addSubview: alertView];
    return  alertView;
    
}
- (void)show {
    
    _centerView.alpha = 0.0;
    _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    _cancelButton.transform = CGAffineTransformMakeScale(0.7, 0.7);

    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerView.alpha = 1.0;
        _centerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _cancelButton.transform = CGAffineTransformMakeScale(1.0, 1.0);

    } completion:^(BOOL finished) {
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self hide];
        //});
    }];
    
}


- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _cancelButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _centerView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
- (IBAction)cancelClick:(id)sender {
     [self hide];
}

@end
@implementation MYSyAlertView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content explainContent:(NSAttributedString *)explainContent tapIndexBlock:(void(^)(NSInteger tag))tapBlock{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MYCustomAlertView" owner:nil options:nil] objectAtIndex:1];
        [self setFrame: frame];
        self.titleLb.text = title;
        self.contentLb.text = content;
        self.explainLb.attributedText = explainContent;
        self.tapBlock = tapBlock;
        [self show];
    }
    return self;
    
}
+(id)showAlertWithTitle:(NSString *)title content:(NSString *)content explainContent:(NSAttributedString *)explainContent superView:(UIView *)view tapIndexBlock:(void(^)(NSInteger tag))tapBlock{
    MYSyAlertView *alertView = [[self alloc]initWithFrame:view.bounds  title:title content:content explainContent:explainContent tapIndexBlock:tapBlock];
    [view addSubview: alertView];
    return  alertView;
    
}
- (void)show {
    
    _centerView.alpha = 0.0;
    _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    _cancelButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerView.alpha = 1.0;
        _centerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _cancelButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self hide];
        //});
    }];
    
}

- (IBAction)confirmClick:(id)sender {
    !_tapBlock ? : _tapBlock(1);
    [self hide];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _cancelButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _centerView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
- (IBAction)cancelClick:(id)sender {
    [self hide];
}

@end
