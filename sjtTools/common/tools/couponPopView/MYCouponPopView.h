//
//  MYCouponPopView.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCouponPopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (nonatomic,copy) void(^indexBlock)(NSInteger index);
+(id)showImage:(NSArray *)imageArray withView:(UIView *)view TapIndexBlock:(void(^)(NSInteger index))indexBlock;
@end

NS_ASSUME_NONNULL_END
