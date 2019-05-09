//
//  NSString+CCCryptUtil.h
//  aesDemo
//
//  Created by xmw_mac on 16/1/7.
//  Copyright © 2016年 xmw_mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCCryptUtil)

-(NSString*) md5;
//加密
+ (NSData*)AES256Encrypt:(NSString*)strSource withKey:(NSString*)key;
//解密
+ (NSString*)AES256Decrypt:(NSData*)dataSource withKey:(NSString*)key;

@end
