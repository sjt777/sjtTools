//
//  MGShareMenueView.m
//  papayaCar_app
//
//  Created by 寇广超 on 2020/7/24.
//  Copyright © 2020 ruiheng. All rights reserved.
//

#import "MGShareMenueView.h"

@implementation MGShareMenueView

- (void)awakeFromNib{
    [super awakeFromNib];
    WeakSelf
     [self.wechatBgView addClickedBlock:^(id obj) {
         [weakSelf changePayType:0];
     }];
     [self.friendBgView addClickedBlock:^(id obj) {
         [weakSelf changePayType:1];
     }];
    [self.linkBgView addClickedBlock:^(id obj) {
         [weakSelf changePayType:2];
     }];
   

}
- (id)initWithFrame:(CGRect)frame  tapIndexBlock:(void(^)(NSInteger tag))tapBlock {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MGShareMenueView" owner:nil options:nil] objectAtIndex:0];
        [self setFrame: frame];
        self.tapBlock = tapBlock;
        [self show];
    }
    return self;
    
}
+(id)showWithView:(UIView *)view tapIndexBlock:(void(^)(NSInteger tag))tapBlock{
    
    MGShareMenueView *alertView = [[self alloc]initWithFrame:view.bounds  tapIndexBlock:tapBlock];
    [view addSubview: alertView];
    return  alertView;
    
}


- (void)show {
    
    CGAffineTransform tarnsform = CGAffineTransformMakeTranslation(0, -210);
    [UIView animateWithDuration:0.5 animations:^{
        _centerView.transform = tarnsform;
    } completion:^(BOOL finished) {
    }];
    
}
- (void)hide{
    CGAffineTransform tarnsform = CGAffineTransformMakeTranslation(0, 210);
    [UIView animateWithDuration:0.3 animations:^{
        _centerView.transform = tarnsform;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
-(void)changePayType:(NSInteger)type{
   
   if (self.tapBlock) {
        self.tapBlock(type);
    }
    [self hide];

}

- (IBAction)cancelClick:(id)sender {
    [self hide];
}
@end
