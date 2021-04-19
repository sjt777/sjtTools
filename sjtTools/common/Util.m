//
//  Util.m
//  template
//
//  Created by yxj on 15-3-25.
//  Copyright (c) 2015年 yxj. All rights reserved.
//

#import "Util.h"
#import "UIImageView+WebCache.h"
#import "URL.h"

//#import <CommonCrypto/CommonDigest.h>

@interface Util () {
    
    NSDateFormatter  *dateformatter;
    
}

@end

@implementation Util

#pragma mark setObject
-(void)y_setObject:(NSMutableDictionary *)dic value:(id)value key:(id)key setObject:(object)object
{
    if (dic==nil) {//字典为空
        object(dic,code_dictionary);
        return ;
    }
    if (key==nil) {//键为空
        object(dic,code_dictionary_key);
        return ;
    }
    if (value==nil) {//值为空
        object(dic,code_dictionary_value);
        return ;
    }
    
    [dic setObject:value forKey:key] ;
    object(dic,code_correct);
}
//转化为字典从字符串
-(NSDictionary *)getDicFromStr:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSError *error ;
    NSData *d = [str dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:d options: NSJSONReadingMutableLeaves error: &error];
    if (error){
        return nil ;
    }else{
        if (json && [json isKindOfClass: [NSDictionary class]]){
            return json ;
        }else{
            return nil ;
        }
    }
}

#pragma mark array
-(void)y_objectAtIndex:(NSMutableArray *)arr index:(NSInteger)index objectAtIndex:(object)object
{
    if (arr==nil) {//数组为空
        object(arr,code_array);
        return ;
    }
    if ((arr.count-1)<index) {//索引大于数组长度
        object(arr,code_array_beyond);
        return ;
    }
    
    object([arr objectAtIndex:index],code_correct);
}

#pragma mark 通过三原色获取色值
-(UIColor *)getRGB:(int)r g:(int)g b:(int)b alpha:(int)alpha
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

#pragma mark 字符串
-(BOOL) isNullOrEmpty:(NSString *)string
{
    if(!string){
        return YES;
    }
    
    if (0 == string.length){
        return  YES;
    }
    
    if ([string stringByReplacingOccurrencesOfString:@" " withString: @""].length == 0){
        return YES;
    }
    return NO;
}
//字符串转化为字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark 判断手机号
- (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^(1[0-9])\\d{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}
- (BOOL)checkStrIsNum:(NSString *)str
{
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^[0-9]+(.[0-9]{0,3})?$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}


#pragma mark 年月日
-(NSString *)getCurrentYear
{
    return [self getTime:@"yyyy"];
}
-(NSString *)getCurrentHour
{
    return [self getTime:@"HH"];
}
-(NSString *)getCurrentMinute
{
    return [self getTime:@"mm"];
}

-(NSString *)getTime:(NSString *)formate
{
    NSDate *date=[NSDate date];
    if (!dateformatter) {
        dateformatter=[[NSDateFormatter alloc] init];
    }
    [dateformatter setDateFormat:formate];
    return [dateformatter stringFromDate:date] ;
}

-(NSString *)getTimeFormTimeStamp:(NSString *)timeStamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    if (!dateformatter) {
        dateformatter=[[NSDateFormatter alloc] init];
    }
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateformatter stringFromDate:confromTimesp] ;
}

#pragma mark md5加密
//- (NSString *)toMd5:(NSString *)str
//{
//    if (str > 0)
//    {
//        const char *cstr = [str UTF8String];
//        unsigned char result[16];
//        CC_MD5(cstr, strlen(cstr), result); // This is the md5 call
//        return [NSString stringWithFormat:
//                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//                result[0], result[1], result[2], result[3],
//                result[4], result[5], result[6], result[7],
//                result[8], result[9], result[10], result[11],
//                result[12], result[13], result[14], result[15]];
//    }else{
//        return str;
//    }
//}

#pragma mark 随即获取图片名字
- (NSString *)getPhotoName
{
    NSString *strRmtName = @"";
    NSDate *now = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat: @"HHmmss"];
    
    int i = rand() % 1000000;
    NSString *strRnd = [NSString stringWithFormat:@"%06d", i];
    strRmtName = [NSString stringWithFormat:@"%@%@%@%@", @"p", [format stringFromDate:now], strRnd, @".jpg"];
    return strRmtName;
}

#pragma mark 获取屏幕尺寸
-(CGRect)getScreen
{
    return [UIScreen mainScreen ].bounds;
}
-(UIWindow *)getWindow
{
    return [UIApplication sharedApplication].keyWindow ;
}


- (void)checkBox
{
//    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
//    _check1.frame = CGRectMake(110, 290, 80, 40);
//    [_check1 setTitle:@"苹果" forState:UIControlStateNormal];
//    [_check1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
//    [self.view addSubview:_check1];
//    [_check1 setChecked:YES];
//    
//    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self];
//    _check2.frame = CGRectMake(170, 290, 80, 40);
//    [_check2 setTitle:@"梨子" forState:UIControlStateNormal];
//    [_check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
//    [self.view addSubview:_check2];
//    
//    QCheckBox *_check3 = [[QCheckBox alloc] initWithDelegate:self];
//    _check3.frame = CGRectMake(230, 290, 80, 40);
//    [_check3 setTitle:@"Apple" forState:UIControlStateNormal];
//    [_check3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_check3 setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
//    [_check3 setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    [_check3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
//    [_check3 setImage:[UIImage imageNamed:@"uncheck_icon.png"] forState:UIControlStateNormal];
//    [_check3 setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateSelected];
//    [self.view addSubview:_check3];
//    [_check3 setChecked:YES];
//    
//    QCheckBox *_check4 = [[QCheckBox alloc] initWithDelegate:self];
//    _check4.frame = CGRectMake(290, 290, 80, 40);
//    [_check4 setTitle:@"Banana" forState:UIControlStateNormal];
//    [_check4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_check4 setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
//    [_check4 setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    [_check4.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
//    [_check4 setImage:[UIImage imageNamed:@"uncheck_icon.png"] forState:UIControlStateNormal];
//    [_check4 setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateSelected];
//    [self.view addSubview:_check4];
//    [_check4 setChecked:NO];
}

@end
