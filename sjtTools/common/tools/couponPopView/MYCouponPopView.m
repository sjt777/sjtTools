//
//  MYCouponPopView.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYCouponPopView.h"
#import "MYCouponScrollView.h"

@interface MYCouponPopView ()<MYCouponScrollViewDelegate>
@property (nonatomic, strong) MYCouponScrollView *couponView;
@end
@implementation MYCouponPopView

- (id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray  TapIndexBlock:(void(^)(NSInteger index))indexBlock{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MYCouponPopView" owner:nil options:nil] objectAtIndex:0];
        self.indexBlock = indexBlock;
        [self setFrame: frame];
        self.couponView = [MYCouponScrollView initWithFrame:_centerView.bounds hasTimer:YES interval:3 placeHolder:[UIImage imageNamed:@""]];
        self.couponView.delegate = self;
        [self.couponView setupWithArray:imageArray];
        [_centerView addSubview: self.couponView];
        [self show];
    }
    return self;
    
}
+(id)showImage:(NSArray *)imageArray withView:(UIView *)view TapIndexBlock:(void(^)(NSInteger index))indexBlock{
    MYCouponPopView *alertView = [[self alloc]initWithFrame:view.bounds withImageArray:imageArray TapIndexBlock:indexBlock];
    [view addSubview: alertView];
    return  alertView;
    
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
-(void)carouselTouch:(MYCouponScrollView *)carousel atIndex:(NSUInteger)index{
    [self hide];
    if (self.indexBlock) {
        self.indexBlock(index);
    }
}


@end
