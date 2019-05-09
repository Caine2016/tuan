//
//  XTools.h
//  buddhismYDniu
//
//  Created by aolei on 16/5/13.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
@interface XTools : NSObject
#pragma mark -图片颜色处理

//字节单位改变  B --> KB
+(NSString*)reducedCapacityUnit:(float)unit;

/// 缩短数量描述，例如 51234 -> 5.12万
+(NSString*) returnIntWan:(float)number;
///颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color;

///压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;

///压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+(void) clipsBoundsForm:(UIImageView*)imageView forcornerRad:(CGSize)size;
///网络下载图片
+(void)getImageByUrl:(NSString*)urlString andBlock:(void(^)(UIImage* image))backImg;

#pragma mark -时间类处理


///通过时间获取星期
+ (NSString*)weekdayStringFromDate:(NSString*)inputDateString;

///获取本地时间字符串
+ (NSString *)SystemNowTimeString;

//获取当地时间 -> type如:yyyy-MM-dd yyyy/MM/dd或者为nill
+ (NSString *)SystemNowTimeFormatString:(NSString*)type;

///根据字符串来获取时间
+ (NSDate *) getTimeByString:(NSString *) timeString;

+(NSString*)getStringByTime:(NSDate*)date;

///比较两个时间的大小
+ (NSInteger)compareTime:(NSString *)time time1:(NSString*)time1;

///获取与当前时间的差值
+ (NSInteger)compareWithNowTime:(NSString *)time;

///根据当前时间计算年龄
+ (int)getAgeByNowTime:(NSString*)time;
///将\/Date(1366563109000+0800)\/时间格式进行转换
+ (NSString *)mfDateFromDotNetJSONString:(NSString *)string;

///获取时分秒
+ (NSString *)getHHmmss;

///获取时间戳
+ (NSString *)get1970timeString;

/*
 *处理时间，显示为。。。小时之后
 */
+ (NSString *)timeAgo:(NSString*)dateTime;

+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
+ (NSString*)getCurrentTimeString:(NSInteger)time;
+ (NSString*)getCurrentTimeString1:(NSInteger)i;

#pragma mark -Text高度计算
///计算Text Size
+ (CGSize)getWidthByString:(NSString*)string withFont:(UIFont*)stringFont withStringSize:(CGSize)stringSize;
//返回城市
+(NSString *)returnCityName:(NSInteger)cityId;
#pragma mark -验证数字
///数字验证
+ (BOOL)checkNum:(NSString *)str;

///验证邮箱验证
+ (BOOL) validateEmail:(NSString *)email;

+ (NSString *) md5:(NSString *) input;
///手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

///用户名验证
+ (BOOL) validateUserName:(NSString *)name;

///密码验证
+ (BOOL) validatePassword:(NSString *)passWord;

///昵称验证
+ (BOOL) validateNickname:(NSString *)nickname;

///身份证号验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

///银行卡验证
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;

//银行卡后四位验证
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;

//CVN验证
+ (BOOL) validateCVNCode: (NSString *)cvnCode;

//month验证
+ (BOOL) validateMonth: (NSString *)month;
//year验证
+ (BOOL) validateYear: (NSString *)year;

//verifyCode验证
+ (BOOL) validateVerifyCode: (NSString *)verifyCode;

+ (NSString *)myMd5:(NSString *) str;
///获取UUID
+ (NSString *)getUUID;

///获取错误信息
+ (NSString *)getErrorInfo:(NSError*)error withBackstageInfo:(id)info;

+ (NSString*)poi_JSONStringFromArray:(NSArray*)array;
+ (NSString*)poi_JSONStringFromArray2:(NSArray*)array;

+ (NSString*)poi_JSONStringFromDictionary:(NSDictionary*)dictionary;

///拼接图片路径 tag 0 1   bit 0 1

/*
 *获取当前网络连接状态
 */
+ (AFNetworkReachabilityStatus)getCurrentNetworkStatusForLocal;

/*
 *NSData--->byte数组
 */
+ (Byte*)getByteByData:(NSData*)data;

+(void)Share:(NSString *)Title contenText:(NSString *)content ContenUrl:(NSString *)contenUrl logoUrl:(NSString *)LogoUrl andItems:(NSArray*)platforms;


/*
 *过滤html标签
 */
+ (NSString *)filterHTML:(NSString *)html;

///高度适配
+ (CGFloat)setHeight:(CGFloat)height;
+ (CGFloat)setWidth:(CGFloat)width;
@end
