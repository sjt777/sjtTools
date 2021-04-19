//
//  MYCoponPageControl.h
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCoponPageControl : UIPageControl

@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *inactiveImage;

@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGSize inactiveImageSize;

@property (nonatomic, assign) NSInteger currentRadius;
@property (nonatomic, assign) NSInteger inactiveRadius;

@property (nonatomic, assign) CGFloat magrin;
@end

NS_ASSUME_NONNULL_END
