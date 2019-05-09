//
//  NSData+CCCryptUtil.h
//  aesDemo
//
//  Created by xmw_mac on 16/1/7.
//  Copyright © 2016年 xmw_mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CCCryptUtil)

//加密函数
- (NSData*)AES256EncryptWithKey:(NSString*)key;

//解密函数
- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end
