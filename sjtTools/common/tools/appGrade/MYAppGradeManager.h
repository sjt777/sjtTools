//
//  MYAppGradeManager.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/29.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYAppGradeManager : NSObject <SKStoreProductViewControllerDelegate>
+ (void)displayAppReview:(UIViewController*)vc;
+ (void)itunesWriteReview;
@end

NS_ASSUME_NONNULL_END
