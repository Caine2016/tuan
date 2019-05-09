//
//  GlobalDefines.h
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/2/12.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 362419100(2群) 459274049（1群已满）
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#ifndef GlobalDefines_h
#define GlobalDefines_h



#define DAY @"day"
#define NIGHT @"night"

#define DefaultImageImage @"default"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define SRate Main_Screen_Width/375.0f




#pragma mark -----------关于评价背景view的初始设置----------
#define DefaultY 6.0f
#define DefaultHeight 115.0f

#pragma mark ------------评价星级----------------

#define StarWidth 35.0f
#define StarHeight 35.0f
#define StarTop  7.50f
//static const CGFloat BBottom = 7.50f;
#define StarBorderDis 50.0f * SRate
#define StarDis ((Main_Screen_Width - StarWidth * 5 - StarBorderDis * 2)/4.0f)

#pragma mark ------------评价标签----------------

//-----------------关于button的初始设置------------------
#define BDis 10.0f
#define BTop 15.0f
#define BFontMargin 10.0f
#define BTopMargin 30.0f
#define BWidth 73.0f
#define BHeight 30.0f

#endif
