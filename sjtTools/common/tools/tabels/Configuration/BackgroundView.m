//
//  BackgroundView.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL value = (CGRectContainsPoint(self.buttonframe, point));
    if (value)  return YES;
    
    if (CGPathIsEmpty(self.path.CGPath) ) {
        return YES;
    } else if (CGPathContainsPoint(self.path.CGPath, nil, point, nil)) {
        return YES;
    } else {
        return NO;
    }
}

@end
