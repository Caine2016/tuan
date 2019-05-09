//
//  UIImage+CH.m
//  新闻
//
//  Created by Think_lion on 15/5/4.
//  Copyright © 2017年 Think_lion. All rights reserved.
//

#import "UIImage+CH.h"
#import <AVFoundation/AVFoundation.h>
@implementation UIImage (CH)


+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+(UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image=[UIImage imageNamed:name];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
    return image;
}

#pragma mark 截屏
+(instancetype)renderView:(UIView *)renderView
{
    //应该给一个延迟的效果
    //获得图片上下文
    UIGraphicsBeginImageContextWithOptions(renderView.frame.size, NO, 0.0);
    //将控制器的view的layer渲染到图层
    [renderView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //去除图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    ///Users/think_lion/Desktop
    //将新图片压缩成二进制文件
    return newImage;
    
}

#pragma mark 裁剪图
+(instancetype)clipWithImageName:(NSString *)name bordersW:(CGFloat)bordersW borderColor:(UIColor *)borderColor
{
    UIImage *oldImage=[UIImage imageNamed:name];
    CGFloat borberW=bordersW;
    CGFloat imageW=oldImage.size.width+borberW*2;
    CGFloat imageH=oldImage.size.height+borberW*2;
    CGSize  imageSize=CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef ref=UIGraphicsGetCurrentContext();
    //画一个大圆
    [borderColor set];
    CGFloat bigRadius=imageW*0.5;
    CGFloat bigX=imageW*0.5;
    CGFloat bigY=imageH*0.5;
    CGContextAddArc(ref, bigX, bigY, bigRadius, 0, M_PI*2, 0);
    //渲染到图层
    CGContextFillPath(ref);
    
    //画一个小圆
    CGFloat smallRadius=bigRadius-borberW;
    CGContextAddArc(ref, bigX, bigY, smallRadius, 0, M_PI*2, 0);
    //裁剪
    CGContextClip(ref);
    //画图
    [oldImage drawInRect:CGRectMake(borberW, borberW, oldImage.size.width, oldImage.size.height)];
    //去除图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}
#pragma mark 图片加水印的方法
+(instancetype)waterWithBgName:(NSString *)bg waterLogo:(NSString *)water
{
    // 获得一张图片
    UIImage *bgName=[UIImage imageNamed:bg];
    //基于上下文 位图(bitmap) 将所有的东西绘制到一张新的图片上面去
    //1.创建一个基于位图的上下文
    //size 新图片的尺寸
    //opaque  YES 表示不透明 NO表示透明
    //运行这行代码后 旧相当于创建了一个新的bitmap  相当于创建了UIImage对象
    UIGraphicsBeginImageContextWithOptions(bgName.size, YES, 0.0);
    //2.话背景
    [bgName drawInRect:CGRectMake(0, 0, bgName.size.width, bgName.size.height)];
    //添加水印logo
    UIImage *logo=[UIImage imageNamed:water];
    CGFloat scale=ImageScale;
    CGFloat margin=LogoImageMargin;
    CGFloat logoW=logo.size.width*scale;;
    CGFloat logoH=logo.size.height*scale;
    CGFloat logoX=bgName.size.width-logoW-margin;
    CGFloat logoY=bgName.size.height-logoH-margin;
    
    [logo drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    //4.从上下文去除获得的新图片对象
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //5.结束上下次文
    UIGraphicsEndImageContext();
    //返回新创建的图片对象
    return newImage;
}

//改变图片大小
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    
    UIGraphicsEndImageContext();
    // Return the new image.
    
    return newImage;
    
}
//导圆角
+(void) clipsBoundsForm:(UIImageView*)imageView forcornerRad:(CGSize)size{
    // UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    // imageView.image = [UIImage imageNamed:@"1"];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath; imageView.layer.mask = maskLayer;
    
    
}
- (UIImage *)clipImage {
    // 01 开启图片上下文 第二个参数 NO 代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 02 获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 03 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    // 04 剪切
    CGContextClip(context);
    // 05 将图片画上去
     [self drawInRect:rect];
    // 06 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 07 关闭上下文
    UIGraphicsEndImageContext();
    // 08 返回图片
    return image;
}
@end