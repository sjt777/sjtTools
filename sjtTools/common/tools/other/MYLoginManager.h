//
//  MYLoginManager.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/8.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVERIFICATIONService.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginSuccessBlock)(NSString *operatorStr, NSString *loginToken);
typedef void(^LoginFailBlock)();
typedef void(^LoginChangeBlock)();
typedef void(^AuthorizationBlock)();


@interface MYLoginManager : NSObject
@property(nonatomic,copy)LoginSuccessBlock successBlock;
@property(nonatomic,copy)LoginFailBlock failBlock;
@property(nonatomic,copy)LoginChangeBlock changeBlock;
@property(nonatomic,copy)AuthorizationBlock authorizationBlock;

+ (MYLoginManager *)sharedManager;
-(void)loginWithVc:(UIViewController *)vc isRegister:(BOOL)isRegister loginSuccessBlock:(LoginSuccessBlock)successBlock  loginFailBlock:(LoginFailBlock)failBlock loginChangeBlock:(LoginChangeBlock)changeBlock authorizationBlock:(AuthorizationBlock)authorizationBlock;
-(void)showResult:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
