//
//  ShowHUD.h
//  buddhismYDniu
//
//  Created by aolei on 16/6/8.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowHUD : NSObject
///显示
+ (void)show;
///隐藏
+ (void)dismiss;

///显示状态信息
+ (void)showStatus:(NSString*)Status;
///显示成功信息
+ (void)showSuccessStatus:(NSString *)text;
///显示失败信息
+ (void)showErrorStatus:(NSString *)text;
///显示警告
+ (void)showWarn:(NSString *)text;

+(void)showMessage:(NSString*)message;

@end
