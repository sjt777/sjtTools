//
//  MYCustomPaytypeView.m
//  antQueen
//
//  Created by 寇广超 on 2019/8/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYCustomPaytypeView.h"

@implementation MYCustomPaytypeView{
    NSInteger _type;
}

- (id)initWithFrame:(CGRect)frame withMoney:(NSString *)money tapIndexBlock:(void(^)(NSInteger type))tapBlock {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MYCustomPaytypeView" owner:nil options:nil] objectAtIndex:0];
        [self setFrame: frame];
        self.tapBlock = tapBlock;
        self.moneyLb.attributedText = [self attributedStringWithName:money firstStrFont:[UIFont systemFontOfSize:32 weight:UIFontWeightRegular] firstStrColor:hexColor(333333) secondStr:@"元" secondStrFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] secondStrColor:hexColor(333333)];
        [self show];
    }
    return self;
    
}
+(id)showMoney:(NSString *)money withView:(UIView *)view tapIndexBlock:(void(^)(NSInteger type))tapBlock{
    
    MYCustomPaytypeView *alertView = [[self alloc]initWithFrame:view.bounds withMoney:money tapIndexBlock:tapBlock];
    [view addSubview: alertView];
    return  alertView;
    
}



- (void)show {
    
    CGAffineTransform tarnsform = CGAffineTransformMakeTranslation(0, -340);
    [UIView animateWithDuration:0.3 animations:^{
        _centerView.transform = tarnsform;
    } completion:^(BOOL finished) {
    }];
    
}
- (IBAction)cancelClick:(id)sender {
      [self hide];
}
- (IBAction)zhifubaoClick:(UIButton *)sender {
    _type = 1;
    [self.zhifubaoBtn setImage:[UIImage imageNamed:@"pay_press"] forState:UIControlStateNormal];
    [self.weixinBtn setImage:[UIImage imageNamed:@"pay_nor"] forState:UIControlStateNormal];

}

- (IBAction)weixinClick:(id)sender {
    _type = 2;
    [self.zhifubaoBtn setImage:[UIImage imageNamed:@"pay_nor"] forState:UIControlStateNormal];
    [self.weixinBtn setImage:[UIImage imageNamed:@"pay_press"] forState:UIControlStateNormal];
}

- (IBAction)confirmClick:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(_type);
    }
    [self hide];
}
- (void)hide{
    CGAffineTransform tarnsform = CGAffineTransformMakeTranslation(0, 340);
    [UIView animateWithDuration:0.3 animations:^{
        _centerView.transform = tarnsform;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
-(NSAttributedString *)attributedStringWithName:(NSString *)firstStr  firstStrFont:(UIFont*)firstStrFont firstStrColor:(UIColor*)firstStrColor secondStr:(NSString *)secondStr  secondStrFont:(UIFont*)secondStrFont secondStrColor:(UIColor*)secondStrColor{
    NSString *str  = [NSString stringWithFormat:@"%@%@",firstStr,secondStr];
    NSDictionary *firstAttributes = @{
                                      NSFontAttributeName:firstStrFont,
                                      NSForegroundColorAttributeName:firstStrColor
                                      };
    NSDictionary *secondAttributes = @{
                                       NSFontAttributeName:secondStrFont,
                                       NSForegroundColorAttributeName:secondStrColor
                                       };
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:firstAttributes];
    NSRange range = [str rangeOfString:secondStr];
    [attributeStr addAttributes:secondAttributes range:range];
    return attributeStr;
}
@end
