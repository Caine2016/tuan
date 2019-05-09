//
//  BaseColor.h
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#ifndef BaseColor_h
#define BaseColor_h



#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define COLOR_333               UIColorFromRGB(0x333333) //51
#define COLOR_666               UIColorFromRGB(0x666666) //102
#define COLOR_999               UIColorFromRGB(0x999999) //153
#define COLOR_RED_              UIColorFromRGB(0xff5400) //红色
#define COLOR_GREEN_            UIColorFromRGB(0x31d8ab)//绿色
#define COLOR_YELLOW_           UIColorFromRGB(0xffa200)//黄色
#define COLOR_ededed            UIColorFromRGB(0xededed) //浅灰

#define kColorTitleLIGHTGRAYNormal   [UIColor colorWithHexString:@"#f7f6f2"]
#define kColorTitleTabbarNormal RGBCOLOR(86,86,86)
#define kColorTitleTabbarSelect RGBCOLOR(233,90,84)
#define kColorYELLOW UIColorFromRGB(0xEE6A50)
#define kClearColor [UIColor clearColor]
#define MainBackColor RGBCOLOR(51,52,54) //#525252 RGBCOLOR(51,52,54)
#define VCBGColor  [UIColor colorWithHexString:@"#f7f6f2"] //UIColorFromRGB(0x525252) 247,246,242
#define KVCBGWhiteColor RGBCOLOR(255,255,255)

#define kColorGRAY8B UIColorFromRGB(0x838B8B)
#define kColorGRAY87 UIColorFromRGB(0x878787)
#define kColorLogin RGBCOLOR(221,101,91)


#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define Global_mainBackgroundColor SDColor(248, 248, 248, 1)
#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

#endif /* BaseColor_h */
