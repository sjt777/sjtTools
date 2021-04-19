//
//  MYKeyChainDataManager.h
//  antQueen
//
//  Created by yixiuge on 2017/7/14.
//  Copyright © 2017年 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYKeyChainDataManager : NSObject

/**
 *   存储 IDFV
 *
 *     */
+(NSString *)getIDFV;

/**
 * /Users/kouguangchao/code/TZImagePickerController/TZImagePickerController/TZImagePickerController 读取IDFV *
 *
 */
+(NSString *)readIDFV;

/**
 *    删除数据
 */
+(void)deleteIDFV;


@end
