//
//  Error.h
//  template
//
//  Created by yxj on 15-3-25.
//  Copyright (c) 2015年 yxj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSObject

typedef enum : NSUInteger {
    code_correct = 0 ,
    
    code_dictionary             = 1 ,//字典为空
    code_dictionary_key         = 2 ,//字典键为空
    code_dictionary_value       = 3 ,//字典值为空
    
    code_array                  = 4 ,//数组为空
    code_array_beyond           = 5 ,//数组越界异常
} errorCode;

@end
