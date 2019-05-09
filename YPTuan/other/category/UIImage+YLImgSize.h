//
//  UIImage+YLImgSize.h
//  YPTuan
//
//  Created by gd on 2018/12/13.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLImgSize)

///获取网络图片尺寸
+ (CGSize)getImageSizeWithURL:(id)URL;

/**生成固定尺寸的图片*/
- (UIImage *)imageWithSize:(CGSize)size;
///缩放图片
- (UIImage *)scaleToScale:(float)scaleSize;
@end
