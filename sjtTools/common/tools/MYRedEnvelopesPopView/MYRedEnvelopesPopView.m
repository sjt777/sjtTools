//
//  MYRedEnvelopesPopView.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/24.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYRedEnvelopesPopView.h"

@implementation MYRedEnvelopesPopView

- (id)initWithFrame:(CGRect)frame withImage:(NSString *)imageurl tapIndexBlock:(void(^)())tapBlock {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MYRedEnvelopesPopView" owner:nil options:nil] objectAtIndex:0];
        [self setFrame: frame];
        self.tapBlock = tapBlock;
        [self.popImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage: [UIImage imageNamed:@"fenxiang"]];
        [self show];
    }
    return self;
    
}
+(id)showImage:(NSString *)imageurl withView:(UIView *)view tapIndexBlock:(void(^)())tapBlock{
    MYRedEnvelopesPopView *alertView = [[self alloc]initWithFrame:view.bounds withImage:imageurl tapIndexBlock:tapBlock];
    [view addSubview: alertView];
    return  alertView;
    
}
- (IBAction)hideTap:(id)sender {
    [self hide];
}
- (IBAction)imageTap:(id)sender {
    [self hide];
    if (self.tapBlock) {
        self.tapBlock();
    }
}
- (void)show {
    
    _centerView.alpha = 0.0;
    _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerView.alpha = 1.0;
        _centerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self hide];
        //});
    }];
    
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self hide];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _centerView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

@end
