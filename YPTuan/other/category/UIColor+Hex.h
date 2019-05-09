//
//  UIColor+Hex.h
//  aolei_ydniu
//
//  Created by aolei on 16/2/23.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (Hex)
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
