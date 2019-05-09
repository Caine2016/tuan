//
//  BaseSizeHeader.h
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#ifndef BaseSizeHeader_h
#define BaseSizeHeader_h


#define kApplicationShared           [UIApplication sharedApplication]
#define WY_KeyWindow                 kApplicationShared.keyWindow
#define WY_SystemVerionFloatValue    [UIDevice currentDevice].systemVersion.floatValue

#define WY_Version_GreaterThanOrEqual_8  (WY_SystemVerionFloatValue >= 8.0)
#define WY_Version_GreaterThanOrEqual_9  (WY_SystemVerionFloatValue >= 9.0)
#define WY_Version_GreaterThanOrEqual_10 (WY_SystemVerionFloatValue >= 10.0)
#define WY_Version_GreaterThanOrEqual_11 (WY_SystemVerionFloatValue >= 11.0)

///判断机型
#define IS_IPHONE4 (IS_IPHONE && kSCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE5 (IS_IPHONE && kSCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE6 (IS_IPHONE && kSCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE6P (IS_IPHONE && kSCREEN_MAX_LENGTH == 736.0)
#define IS_iPhone_X (MAX(kScreenWidth, kScreenHeight) == 812)
#define IS_IPHONE_Xr (MAX(kScreenWidth, kScreenHeight) == 896)
#define IS_IPHONE_Xs (MAX(kScreenWidth, kScreenHeight) == 812)
#define IS_IPHONE_Xs_Max (MAX(kScreenWidth, kScreenHeight) == 896)

#define kAdapterWidth(width) [XTools setWidth:width]
#define kAdapterHeight(height) [XTools setHeight:height]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define kNavbarHeight 44
#define kBaseTopHeight (kStatusBarHeight + kNavbarHeight)


#define kSAFE_BOTTOM                   34
#define kSAFE_BOTTOM_LAYOUT            ((IS_iPhone_X || IS_IPHONE_Xr) ? -(kSAFE_BOTTOM) : 0)
#define kTabBarHeight (49+kSAFE_BOTTOM_LAYOUT)

///可根据项目需求设置高度  分页控制器头部高度
#define ZWMSegmentHeight  54

#define BaseBtnHeight0 0
#define BaseCornerRadius 5
#define BaseBtnHeight44 44
#define BaseBtnHeight49 49
#define BaseBtnHeight64 64
#define BaseBtnPadding 10

///技师cell的高度
#define TechnicianCellHeight 60

///画一像素线
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)


#endif /* BaseSizeHeader_h */
