//
//  MYRedEnvelopesPopView.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/24.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYRedEnvelopesPopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *popImageView;
@property (nonatomic,copy) void(^tapBlock)();
+(id)showImage:(NSString *)imageurl withView:(UIView *)view tapIndexBlock:(void(^)())tapBlock;
@end

NS_ASSUME_NONNULL_END
