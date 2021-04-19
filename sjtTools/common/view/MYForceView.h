//
//  MYForceView.h
//  antQueen
//
//  Created by yixiuge on 17/5/25.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYForceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *lbContentTitle;
@property (nonatomic,copy)void(^PushBlock)();
@property(nonatomic,assign) BOOL isHide;
- (id)initWithFrame:(CGRect)frame andPersonTitle:(NSArray<NSString * >*)title;
@end
