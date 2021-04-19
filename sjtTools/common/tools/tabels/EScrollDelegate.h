//
//  EScrollDelegate.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EScrollDelegate <NSObject>

- (void)e_scrollViewDidScroll:(UIScrollView *)scrollView;

@end
@protocol MYScrollDelegate <NSObject>

- (void)my_scrollViewDidScroll:(UIScrollView *)scrollView;

@end
