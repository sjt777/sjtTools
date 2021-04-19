//
//  TypeOf.h
//  template
//
//  Created by yxj on 15-3-25.
//  Copyright (c) 2015年 yxj. All rights reserved.
//

#import "Error.h"

@interface TypeOf : Error

//判断对象操作是否正确
typedef void (^object)(id object, errorCode code);

//判断返回的结果是否正确
typedef void (^returnDic)(NSDictionary *returnDic, NSString *error);
typedef void (^returnStr)(NSString *returnStr, NSString *error);

@end
