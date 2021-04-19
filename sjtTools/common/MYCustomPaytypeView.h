//
//  MYCustomPaytypeView.h
//  antQueen
//
//  Created by 寇广超 on 2019/8/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCustomPaytypeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (nonatomic,copy) void(^tapBlock)(NSInteger type);
@property (weak, nonatomic) IBOutlet UIView *centerView;

+(id)showMoney:(NSString *)money withView:(UIView *)view tapIndexBlock:(void(^)(NSInteger type))tapBlock;
@end

NS_ASSUME_NONNULL_END
