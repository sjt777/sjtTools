//
//  MYCustomAlertView.h
//  antQueen
//
//  Created by 寇广超 on 2019/7/29.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCustomAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
+(id)showAlertWithTitle:(NSString *)title content:(NSString *)content superView:(UIView *)view;
@end
@interface MYSyAlertView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *explainLb;
@property (nonatomic,copy) void(^tapBlock)(NSInteger tag);

+(id)showAlertWithTitle:(NSString *)title content:(NSString *)content explainContent:(NSAttributedString *)explainContent superView:(UIView *)view tapIndexBlock:(void(^)(NSInteger tag))tapBlock;

@end


NS_ASSUME_NONNULL_END
