//
//  Util.h
//  template
//
//  Created by yxj on 15-3-25.
//  Copyright (c) 2015年 yxj. All rights reserved.
//

#import "TypeOf.h"
#import <UIKit/UIKit.h>

@interface Util :TypeOf

#pragma mark 网络

#pragma mark 字典
//字典的添加
-(void)y_setObject:(NSMutableDictionary *)dic value:(id)value key:(id)key setObject:(object)object ;
//转化为字典
-(NSDictionary *)getDicFromStr:(NSString *)str ;

#pragma mark 数组
//获取数组中的对象
-(void)y_objectAtIndex:(NSMutableArray *)arr index:(NSInteger)index objectAtIndex:(object)object;

#pragma mark 色彩
//通过三原色获取色值
-(UIColor *)getRGB:(int)r g:(int)g b:(int)b alpha:(int)alpha;

#pragma mark 判断字符串为空
-(BOOL)isNullOrEmpty:(NSString *)string ;
//字符串转化为字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark 判断手机号
- (BOOL)checkTel:(NSString *)str ;
- (BOOL)checkStrIsNum:(NSString *)str ;

#pragma mark 年月日
-(NSString *)getCurrentYear;
-(NSString *)getCurrentHour;
-(NSString *)getCurrentMinute;
-(NSString *)getTimeFormTimeStamp:(NSString *)timeStamp ;

#pragma mark md5加密
//- (NSString *)toMd5:(NSString *)str ;

#pragma mark 随即获取图片名字
- (NSString *)getPhotoName ;

#pragma mark 获取屏幕尺寸
-(CGRect)getScreen;
-(UIWindow *)getWindow ;

@end
