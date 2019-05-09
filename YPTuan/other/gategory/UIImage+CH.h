//
//  UIImage+CH.h
//  新闻
//
//  Created by Think_lion on 15/5/4.
//  Copyright © 2017年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ImageScale 0.2
#define LogoImageMargin 5

@interface UIImage (CH)
+(UIImage *)resizedImage:(NSString *)name;
+(UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


//截屏方法
+(instancetype)renderView:(UIView *)renderView;
//图片家水印
+(instancetype)waterWithBgName:(NSString *)bg waterLogo:(NSString *)water;
//裁剪图片为园
+(instancetype)clipWithImageName:(NSString*)name bordersW:(CGFloat)bordersW borderColor:(UIColor *)borderColor;

//修改图片大小
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//导圆角
+(void) clipsBoundsForm:(UIImageView*)imageView forcornerRad:(CGSize)size;
@end
