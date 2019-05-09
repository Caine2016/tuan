//
//  UIImage+YLImgSize.m
//  YPTuan
//
//  Created by gd on 2018/12/13.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "UIImage+YLImgSize.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (YLImgSize)

/**生成固定尺寸的图片*/
- (UIImage *)imageWithSize:(CGSize)size{
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else{
        UIGraphicsBeginImageContext(size);        }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
///缩放图片
- (UIImage *)scaleToScale:(float)scaleSize{
    if ([[UIScreen mainScreen] scale] == 2.0) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize), NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize), NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

/*
使用
在拿到需要请求的url数组的时候，就将每个链接的尺寸顺便就给获取出来，然后本地化存储该图片的尺寸，然后再到cell里面根据链接直接在本地取到图片的尺寸，那样在cell里面浏览的时候就不会有卡顿了。
//获取图片尺寸时先检查是否有缓存(有就不用再获取了)
if (![[NSUserDefaults standardUserDefaults] objectForKey:url]) {
    //这里拿到每个图片的尺寸，然后计算出每个cell的高度
    CGSize imageSize = [UIImage getImageSizeWithURL:url];
    CGFloat imgH = 0;
    if (imageSize.height > 0) {
        //这里就把图片根据 固定的需求宽度  计算 出图片的自适应高度
        imgH = imageSize.height * (SCREEN_WIDTH - 2 * _spaceX) / imageSize.width;
    }
    //将最终的自适应的高度 本地化处理
    [[NSUserDefaults standardUserDefaults] setObject:@(imgH) forKey:url];
}

*/

@end
