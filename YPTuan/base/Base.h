//
//  Base.h
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#ifndef Base_h
#define Base_h

#import "UIImage+CH.h"
#import "UIView+MJ.h"
#import "UIView+SDAutoLayout.h"
#import "UIButton+GDExpandArea.h"
#import "NSObject+Additions.h"
#import "UILabel+Extension.h"
#import "UIButton+Extension.h"
#import "UIImage+YLImgSize.h"
#import "UIImageView+YLHelpMe.h"

#import "YYKit.h"
#import "MJRefresh.h"
#import "FMDB.h"
#import "KVOController.h"
#import "AFNetworking.h"
#import "GDTool.h"
#import "XTools.h"
#import "ShowHUD.h"
#import "XXTextView.h"
#import "HYBImageCliped.h"
#import "BaseSizeHeader.h"
#import "YLServerMacroHeader.h"
#import "BaseAPIProxy.h"
#import "YLBaseDataService.h"
#import "MBProgressHUD.h"
#import "AppCommon.h"
#import "UIView+Additions.h"
#import "MBProgressHUD+Additions.h"
#import "LoginRequest.h"
#import "EGOCache.h"
#import "MJExtension.h"
#import <Lottie/Lottie.h>

#import "MyAlertController.h"
#import "MyButton.h"
#import "URLStringCode.h"
#import "BaseFont.h"
#import "BaseVC.h"
#import "AppDefines.h"
#import "BaseTypeHeader.h"
#import "BaseNotificationHeader.h"
#import "WYMacroA.h"
#import "GlobalDefines.h"
#import "YLUserModel.h"

#import "YLLoginController.h"
/*
 *输出语句，只在DEBUG模式下才会输出，方便调试
 */
//调试才打印信息
#ifdef DEBUG
#define CNSLog(FORMAT, ...) fprintf(stderr,"%s LineNum:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define CNSLog(...)
#endif


#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

//weak修饰
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;

///UIImage宏
#define IMAGENAME(name) [UIImage imageNamed:name]
/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}



#define service_host @""
#define kApiURL @""

#endif /* Base_h */
