//
//  URLStringCode.h
//  buddhismYDniu
//
//  Created by gd on 2017/12/27.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLStringCode : NSObject
+ (id)shareURLCode;

+(NSString *)urlEncodeStr:(NSString *)input;

+(NSString *)decoderUrlEncodeStr: (NSString *) input;

+(NSString *)urlEncodeNullStr:(NSString *)input;
///base64编码
+(NSString *)base64EncodeString:(NSString *)string;
@end
