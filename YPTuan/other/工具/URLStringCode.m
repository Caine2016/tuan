//
//  URLStringCode.m
//  buddhismYDniu
//
//  Created by gd on 2017/12/27.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "URLStringCode.h"

static URLStringCode *_instance;

@implementation URLStringCode

+ (id)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
        
    }
    return _instance;
}

+ (id)shareURLCode{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[URLStringCode alloc] init];
        }
        
    }
    return _instance;
}

+ (id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
    
}

//urlEncode编码
+(NSString *)urlEncodeStr:(NSString *)input{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    
    return upSign;
}

+(NSString *)urlEncodeNullStr:(NSString *)input{
    NSString *charactersToEscape = @" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return upSign;
}

//urlEncode解码
+ (NSString *)decoderUrlEncodeStr: (NSString *) input{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}


///base64编码
+(NSString *)base64EncodeString:(NSString *)string

{
    
    //1.先把字符串转换为二进制数据
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    
    return [data base64EncodedStringWithOptions:0];
    
}

@end
