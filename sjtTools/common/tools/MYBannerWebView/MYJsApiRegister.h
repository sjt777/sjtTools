//
//  MYJsApiRegister.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/10.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYJsApiRegister : NSObject
@property (nonatomic, weak) BaseVC *vc;
@property (nonatomic, strong) User *loginuser;
@property (nonatomic,copy) void(^rechargeMoneyBlock)(NSInteger type, NSDictionary *arg);

@end

NS_ASSUME_NONNULL_END
