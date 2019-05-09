//
//  GDGalleryBuddhaViewCell.m
//  buddhismYDniu
//
//  Created by gd on 2018/8/21.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDGalleryBuddhaViewCell.h"

@implementation GDGalleryBuddhaViewCell{
    
    UIImageView* imageView;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        //初始化创建UIImageView
        imageView =[[UIImageView alloc]initWithFrame:self.contentView.bounds];
        
        //设置默认图片
       
        [self.contentView addSubview:imageView];
        
    }
    return self;
}
//hyb_clipToSize:(CGSize)targetSize
//cornerRadius:(CGFloat)cornerRadius
//backgroundColor:(UIColor *)backgroundColor
//isEqualScale:(BOOL)isEqualScale
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    UIImage* image = [UIImage imageNamed:imageName];
    
     imageView.image = [image hyb_clipToSize: imageView.size cornerRadius:BaseCornerRadius corners:UIRectCornerAllCorners];
}

@end
