//
//  UIButton+MYEventInterval.m
//  antQueen
//
//  Created by 寇广超 on 2018/12/24.
//  Copyright © 2018 yibyi. All rights reserved.
//

#import "UIControl+MYEventInterval.h"
#import <objc/runtime.h>

static char * const my_eventIntervalKey = "my_eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIControl
()

@property (nonatomic, assign) BOOL eventUnavailable;

@end

@implementation UIControl (MYEventInterval)

+ (void)load {
    
//    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method my_method = class_getInstanceMethod(self, @selector(my_sendAction:to:forEvent:));
    
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    Method customMethod = class_getInstanceMethod(self, @selector(my_sendAction:to:forEvent:));
    SEL customSEL = @selector(my_sendAction:to:forEvent:);

    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    
    //如果系统中该方法已经存在了，则替换系统的方法  语法：IMP class_replaceMethod(Class cls, SEL name, IMP imp,const char *types)
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        //method_exchangeImplementations(method, my_method);
        method_exchangeImplementations(systemMethod, customMethod);
        
    }


}


#pragma mark - Action functions

- (void)my_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
//    if (self.eventUnavailable == NO) {
//        self.eventUnavailable = YES;
//        [self my_sendAction:action to:target forEvent:event];
//        [self performSelector:@selector(setEventUnavailable:) withObject:@(NO) afterDelay:self.my_eventInterval];
//    }
    if([self.class isMemberOfClass:[UIButton class]]) {
        if (self.eventUnavailable == NO) {
            self.eventUnavailable = YES;
            [self my_sendAction:action to:target forEvent:event];
            [self performSelector:@selector(setEventUnavailable:) withObject:@(NO) afterDelay:self.my_eventInterval];
        }
    } else {
        [self my_sendAction:action to:target forEvent:event];
    }
}


#pragma mark - Setter & Getter functions

- (NSTimeInterval)my_eventInterval {
    
    return [objc_getAssociatedObject(self, my_eventIntervalKey) doubleValue];
}

- (void)setMy_eventInterval:(NSTimeInterval)my_eventInterval {
    
    objc_setAssociatedObject(self, my_eventIntervalKey, @(my_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


