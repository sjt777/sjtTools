//
//  MGShareMenueView.h
//  papayaCar_app
//
//  Created by 寇广超 on 2020/7/24.
//  Copyright © 2020 ruiheng. All rights reserved.
//

#import "BaseUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGShareMenueView : BaseUIView
@property (weak, nonatomic) IBOutlet UIView *wechatBgView;
@property (weak, nonatomic) IBOutlet UIView *friendBgView;
@property (weak, nonatomic) IBOutlet UIView *linkBgView;
@property (nonatomic,copy) void(^tapBlock)(NSInteger tag);
@property (weak, nonatomic) IBOutlet BaseCornerView *centerView;
+(id)showWithView:(UIView *)view tapIndexBlock:(void(^)(NSInteger tag))tapBlock;
@end

NS_ASSUME_NONNULL_END
