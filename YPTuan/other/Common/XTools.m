//
//  XTools.m
//  buddhismYDniu
//
//  Created by aolei on 16/5/13.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import "XTools.h"
#import "NSDate+TimeAgo.h"
#import <CommonCrypto/CommonDigest.h>
#import "SSKeychain.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"


#define SHOW_WINDOW [[UIApplication sharedApplication].windows firstObject]
@implementation XTools

+(NSString *)reducedCapacityUnit:(float)unit{
    NSString* speedString;
    if (unit <1024) {
        speedString = [NSString stringWithFormat:@"%@B",[NSNumber numberWithFloat:unit]];
    }else if (unit >1024 && unit < 1024*1024)
    {
        speedString = [NSString stringWithFormat:@"%.1fKB",unit/1024];
    }else if (unit > 1024 * 1024)
    {
        speedString = [NSString stringWithFormat:@"%.2fMB",unit/1024/1024];
    }
    
    return speedString;
}
+(NSString*) returnIntWan:(float)number{
    
//    if (number >= 10000) {
//
//        float reNumber =  (float)number / 10000;
//
//        return [NSString stringWithFormat:@"%.2f万",reNumber];
//    }else{
//
//        return [NSString stringWithFormat:@"%.f",number];;
//    }
    
    if (number <= 9999) return [NSString stringWithFormat:@"%.f", number];
    if (number <= 9999999) return [NSString stringWithFormat:@"%.2f万", (number / 10000)];
    return [NSString stringWithFormat:@"%.2f千万", (number / 10000000)];
    
    
}

#pragma mark -时间类处理
///通过时间获取星期
+ (NSString*)weekdayStringFromDate:(NSString*)inputDateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:inputDateString];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}
+(NSString*)getStringByTime:(NSDate*)date{
    
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设置格式
    NSString * curTime = [formater stringFromDate:date];
    return curTime;
}
///获取本地时间字符串
+(NSString *)SystemNowTimeString{
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = [NSDate date];//获取当前日期
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设置格式
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}

//获取当地时间 -> type如:yyyy-MM-dd yyyy/MM/dd或者为nill
+(NSString *)SystemNowTimeFormatString:(NSString*)type{
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = [NSDate date];//获取当前日期
    //设置格式
    if (type == nil) {
        [formater setDateFormat:@"yyyy-MM-dd"];
    }else{
        [formater setDateFormat:type];
    }
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}
///根据字符串来获取时间
+(NSDate *) getTimeByString:(NSString *) timeString{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate  * myDate=[dateformatter dateFromString:timeString];
    return myDate;
}

///比较两个时间的大小
+(NSInteger)compareTime:(NSString *)time time1:(NSString*)time1{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate  * Date=[dateformatter dateFromString:time];
    NSDate *Date1=[dateformatter dateFromString:time1];
    return (int)[Date timeIntervalSinceDate:Date1];
}

///获取与当前时间的差值
+(NSInteger)compareWithNowTime:(NSString *)time{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSDate  * oldDate=[dateformatter dateFromString:timeString];
    //此处为什么要加0000呢
    NSDate  * oldDate=[dateformatter dateFromString:time];
    //    [dateformatter release];
    return abs((int)[oldDate timeIntervalSinceNow]);
}

///将/Date(1366563109000+0800)/时间格式进行转换
+ (NSString *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        //实例化一个NSDateFormatter对象
        //     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        //      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //用[NSDate date]可以获取系统当前时间
        // NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
        //    NSMutableString* sting = [[NSMutableString alloc]init];
        NSMutableString* sting = [NSMutableString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSince1970:seconds]
                                  ];
        NSString *data =  [sting substringToIndex:20];
        //   [sting release];
        //   [dateFormatter release];
        
        
        return data;
    }
    return nil;
}

+ (NSString *)getHHmmss{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatTime = [[NSDateFormatter alloc] init];
    formatTime.dateFormat = @"HHmmss";
    NSString *timeStr = [formatTime stringFromDate:now];
    
    return timeStr;
}

+ (NSString *)get1970timeString{
    return [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970] * 1000];
}

+ (int)getAgeByNowTime:(NSString*)time{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:time];
    NSTimeInterval dateDiff = [birthDay timeIntervalSinceNow];
    int age= trunc(dateDiff/(60*60*24))/365;
    return abs(age);
}

/*
 *处理时间，显示为。。。小时之后
 */
+ (NSString *)timeAgo:(NSString*)dateTime {
    /*
     2015-10-30 15:12:04
     */
    //处理时间
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [inputFormatter dateFromString:dateTime];
    [inputFormatter setDateFormat:@"MM-dd HH:mm"];  //05-31 17:46
    return [date timeAgoWithLimit:1000*60*60 dateFormatter:inputFormatter];
}

+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    //    CNSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    //    NSString *sen=@"";
    //
    //    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //    //        min = [min substringToIndex:min.length-7];
    //    //    秒
    //    sen=[NSString stringWithFormat:@"%@", sen];
    
    
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
    
    timeString=[NSString stringWithFormat:@"%@小时%@分钟",house,min];
    
    return timeString;
}




+ (NSString*)getCurrentTimeString:(NSInteger)time{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
//    NSDateComponents *comps = nil;
//    
//    comps = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setHour:time/60];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];  // 格式化时间NSDate
    
    NSString*stringFromDate = [formatter stringFromDate:newdate];
    return stringFromDate;
    
}
+ (NSString*)getCurrentTimeString1:(NSInteger)i
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSDateComponents *comps = nil;
//    
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:i-6];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"yyyy-MM-dd"];  // 格式化时间NSDate
    
    
    
    NSString*stringFromDate = [formatter stringFromDate:newdate];
    return stringFromDate;
    
}

///计算Text Size
+ (CGSize)getWidthByString:(NSString*)string withFont:(UIFont*)stringFont withStringSize:(CGSize)stringSize{
    NSDictionary *attribute = @{NSFontAttributeName: stringFont};
    CGSize size = [string boundingRectWithSize:stringSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    //CNSLog(@"withd:%f,height:%f",size.width,size.height);
    return size;
}

#pragma mark-正则表达式
///验证数字
+ (BOOL)checkNum:(NSString *)str{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

///邮箱验证
+ (BOOL) validateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    

}

///手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

///用户名验证
+ (BOOL) validateUserName:(NSString *)name{
    //    NSString *userNameRegex = @"^[A-Za-z0-9]{4,20}+$";
    NSString *userNameRegex = @"^[A-Za-z0-9_]{6,20}$";
    
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

///密码验证
+ (BOOL) validatePassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[A-Za-z0-9_$#@*￥%!]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

///昵称验证
+ (BOOL) validateNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"([\u4e00-\u9fa5]{2,5})(&middot;[\u4e00-\u9fa5]{2,5})*";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

///身份证号验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

///银行卡验证
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber{
    BOOL flag;
    if (bankCardNumber.length != 4) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{4})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode{
    BOOL flag;
    if (cvnCode.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{3})";
    NSPredicate *cvnCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [cvnCodePredicate evaluateWithObject:cvnCode];
}

//month
+ (BOOL) validateMonth: (NSString *)month{
    BOOL flag;
    if (month.length != 2) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"(^(0)([0-9])$)|(^(1)([0-2])$)";
    NSPredicate *monthPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [monthPredicate evaluateWithObject:month];
}

//year
+ (BOOL) validateYear: (NSString *)year{
    BOOL flag;
    if (year.length != 2) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^([1-3])([0-9])$";
    NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [yearPredicate evaluateWithObject:year];
}

//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode
{
    BOOL flag;
    if (verifyCode.length != 6) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{6})";
    NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [verifyCodePredicate evaluateWithObject:verifyCode];
}

#pragma mark -图片颜色处理

+(void)getImageByUrl:(NSString*)urlString andBlock:(void(^)(UIImage* image))backImg
{
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlString] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%f",1.0 * receivedSize / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        backImg(image);
    }];
}

///颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.f, 1.f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

///压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}

//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

/**
 *  剪切图片为正方形
 *
 *  @param image   原始图片比如size大小为(400x200)pixels
 *  @param newSize 正方形的size比如400pixels
 *
 *  @return 返回正方形图片(400x400)pixels
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

///缩放图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize{
    if ([[UIScreen mainScreen] scale] == 2.0) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize), NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize), NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    }
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return scaledImage;
}
//导圆角
+(void) clipsBoundsForm:(UIImageView*)imageView forcornerRad:(CGSize)size{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;

}

/*
 *MD5校验
 */
///MD5校验
+ (NSString *)myMd5:(NSString *) str{
    NSMutableString *str1=[[NSMutableString alloc] init];
    [str1 appendString:str];
    [str1 appendString:@"5D7B5F98E89E07D5750F383509C92F13"];
    const char *cStr = [str1 UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *stringMd5 = [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]
                            ] uppercaseString];
    return stringMd5;
}
//MD5加密
+ (NSString *) md5:(NSString *) input {
    
    const char *cStr = [input UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [output appendFormat:@"%02X", digest[i]];
    
    }
    
    return  output;
    
}
///获取UUID
+ (NSString *)getUUID{
    NSError *error = nil;
    NSString *tmpIdentifier = [SSKeychain passwordForService: @"BUDDHA_UUID_HERD.com.ydniu.com.buddha.AppIdentify" account:@"Buddha_MyUUID" error:&error];
    if (tmpIdentifier.length<=0) {
        NSString *identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:identifier forService:@"BUDDHA_UUID_HERD.com.ydniu.com.buddha.AppIdentify" account:@"Buddha_MyUUID" error:&error];
        tmpIdentifier = identifier;
    }
    return tmpIdentifier;
}

//检查错误
+ (NSString *)getErrorInfo:(NSError*)error withBackstageInfo:(id)info{
    if (error != nil) {///
        NSString *errorString = nil;
        switch (error.code) {
            case -1001:
                errorString =  NSLocalizedString(@"ServerLongTime", nil);
                break;
            case -1005:
                errorString = NSLocalizedString(@"InternetError", nil);
                break;
            case -1009:
                errorString = NSLocalizedString(@"DisconnectNetwork", nil);
                break;
            case 7777:
                errorString = error.domain;
                break;
            default:
                errorString =  NSLocalizedString(@"AbnormalRequest", nil);
                break;
        }
        return errorString;
    }else{
        NSDictionary *tmpDic = info;
        NSString *tmpString = tmpDic[@"Error"];
        if (![info isEqual:[NSNull null]] && tmpString.length > 0) {
            if ([tmpString isEqualToString:@"该记录已存在"]) {
                return NSLocalizedString(@"The_song_already_exists", nil);
            }
            return tmpString;
        }else{
            if ([tmpDic[@"Result"] isEqual:[NSNull null]]) {
                return NSLocalizedString(@"No_data_requested", nil);
            }else{
                return @"";
            }
            
        }//end else
        
    }//end else
}

/*
 *json字符串
 */
//List转字符串
+ (NSString*)poi_JSONStringFromArray:(NSArray*)array{
//    CNSLog(@"---> %@",array);
    if (array == nil) {
        array = [[NSArray alloc] init];
    }
    NSMutableString *stringM = @"".mutableCopy;
    [stringM appendString:@"["];
    for (int i = 0; i < array.count; i++) {
        if ([array[i] isKindOfClass:[NSString class]]) {
            [stringM appendString:@"\""];
//            NSString *tmpStr = [array[i]stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
            NSString *tmpStr = array[i];
            if (i > 2) {
                [stringM appendFormat:@"%@",[tmpStr stringByURLEncode]];
//                CNSLog(@"%@",[tmpStr stringByURLDecode]);
            }else{
                [stringM appendString:tmpStr];
            }
            
            [stringM appendString:@"\""];
        }else{
            [stringM appendFormat:@"%@",array[i]];
        }
        [stringM appendString:@","];
    }
    
    [stringM deleteCharactersInRange:NSMakeRange(stringM.length - 1, 1)];
    [stringM appendString:@"]"];
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    CNSLog(@"------>>> %@",stringM);
    return stringM;
}

+ (NSString*)poi_JSONStringFromArray2:(NSArray*)array{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSString*)poi_JSONStringFromDictionary:(NSDictionary*)dictionary{
    if (dictionary == nil) {
        dictionary = [[NSDictionary alloc] init];
    }
//    NSMutableString *stringM = @"".mutableCopy;
//    [stringM appendString:@"{"];
//    NSArray *keyList = [dictionary allKeys];
//    for (id key in keyList) {
//        [stringM appendString:[NSString stringWithFormat:@"%@",key]];
//        [stringM appendString:@":"];
//        [stringM appendString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]];
//    }
//    [stringM appendString:@"}"];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    CNSLog(@"===> %@",stringM);
    return jsonString;
}


+ (AFNetworkReachabilityStatus)getCurrentNetworkStatusForLocal{
    
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    
}

+ (Byte*)getByteByData:(NSData*)data{
    NSUInteger lenDD = [data length];
    Byte *dataByte = (Byte*)malloc(lenDD);
    memcpy(dataByte, [data bytes], lenDD);
    return dataByte;
}




+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
+ (CGFloat)setWidth:(CGFloat)width{
    return kScreenWidth /375.0f * width;
}
+ (CGFloat)setHeight:(CGFloat)height{
    return kScreenHeight / 667.0f * height;
}


@end
