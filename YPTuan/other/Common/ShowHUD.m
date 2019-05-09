//
//  ShowHUD.m
//  buddhismYDniu
//
//  Created by aolei on 16/6/8.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import "ShowHUD.h"
#import "SVProgressHUD.h"
@implementation ShowHUD
+ (void)_setState{
    static dispatch_once_t onceTokenss;
    dispatch_once(&onceTokenss, ^{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setMinimumDismissTimeInterval:2.f];
    });
}
+ (void)show{
    [self _setState];
    [SVProgressHUD show];
}


+(void)showMessage:(NSString *)message{
    [self _setState];
    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD showMessage:message];
    
}
///显示成功
+ (void)showSuccessStatus:(NSString *)text{
    [self _setState];
    [SVProgressHUD showSuccessWithStatus:text];
}

+ (void)showErrorStatus:(NSString *)text{
    [self _setState];
  //  [SVProgressHUD setErrorImage:[UIImage imageNamed:@"pleaseBuddha_bg_img"]];
    [SVProgressHUD showErrorWithStatus:text];
}
+ (void)showStatus:(NSString*)Status{
    [self _setState];
    [SVProgressHUD showWithStatus:Status];
}
+ (void)showWarn:(NSString *)text{
    [self _setState];
    [SVProgressHUD showInfoWithStatus:text];
}

///隐藏
+ (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
