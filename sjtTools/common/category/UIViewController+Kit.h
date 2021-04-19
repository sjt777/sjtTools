//
//  UIViewController+Kit.h
//  papayaCar_app
//
//  Created by 寇广超 on 2019/9/16.
//  Copyright © 2019 ruiheng. All rights reserved.
//


#import <UIKit/UIKit.h>

//#import "User.h"
typedef void(^ completeAction)(void);

typedef void (^PhotoBlock)(NSArray * images);

static BOOL isHeader;

@protocol VcCloseDelegate <NSObject>

- (void)vcClose:(id)value withClass:(Class)c;

@end

typedef NS_ENUM(NSUInteger, SocialPlatform) {
    SocialPlatformSina = 0,
    SocialPlatformWechatTimeline,
    SocialPlatformWechatSession,
    SocialPlatformTencentWeibo,
    SocialPlatformQZone,
    SocialPlatformRenren,
    SocialPlatformSms,
};

@interface UIViewController (Kit) <VcCloseDelegate>


@property (nonatomic, copy) NSString* Token;

@property (nonatomic, strong) NSDictionary* bundle;

@property (nonatomic, weak) id<VcCloseDelegate> closeDelegate;





- (void)backAction;

- (void)dismissVC;


- (void)viewDefaults;

+(instancetype)vcFromStoryboard:(NSString *)storyName;

- (void)notificationTokenInvalid:(NSNotification*)notification;

- (id)pushNextPage:(NSString*)storyName vcName:(NSString*)vcName params:(NSDictionary*)parmas;
- (id)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas animated:(BOOL)animated;

- (void)presentNextPage:(NSString*)storyName vcName:(NSString*)vcName params:(NSDictionary*)parmas;

- (void)postNotification:(NSString*)name object:(id)obj;
- (id)pushNextPage:(NSString *)storyName vcName:(NSString *)vcName params:(NSDictionary *)parmas Nav:(UINavigationController *)nav animated:(BOOL)animated;


@end
