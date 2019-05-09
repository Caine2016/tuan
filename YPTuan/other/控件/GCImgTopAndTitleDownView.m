//
//  GCImgTopAndTitleDownView.m
//  buddhismYDniu
//
//  Created by gd on 2018/11/9.
//  Copyright © 2018 aolei. All rights reserved.
//

#import "GCImgTopAndTitleDownView.h"

@implementation GCImgTopAndTitleDownView

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString*)title andSelcetTitle:(NSString*)selectTitle andColor:(UIColor*)titleColor andSelectTitleColor:(UIColor *)selectColor andImg:(NSString*)ImgName andSelectImg:(NSString*)selectImgName{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        [self setTitle:title forState:UIControlStateNormal];
        if (selectTitle) {
            [self setTitle:title forState:UIControlStateSelected];
        }
        
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        if (selectColor) {
            [self setTitleColor:selectColor forState:UIControlStateSelected];
        }
        
        [self setImage:[UIImage imageNamed:ImgName] forState:UIControlStateNormal];
        if (selectImgName) {
            [self setImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
        }
        
        [self addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLabel.font = font(16);
        
    }
    
    return self;
}



- (void)layoutButtonWithImageTitleSpace:(CGFloat)space {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}

-(void)layoutButtonWithImageDownTitleTopSpace:(CGFloat)space{
    //3、获取控件宽度
    CGFloat imageViewWidth = self.imageView.frame.size.width;
    CGFloat imageViewHeight = self.imageView.frame.size.height;
    
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    CGFloat titleHeight = self.titleLabel.frame.size.height;
    
    //4、设置内边距
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageViewHeight, imageViewWidth, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, titleHeight, titleWidth)];

}

-(void)layoutButtonWithImageRightTitleLeftSpace:(CGFloat)space{
    //3、获取控件宽度
    CGFloat imageViewWidth = self.imageView.frame.size.width;
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    
    //4、设置内边距
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, imageViewWidth, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, titleWidth)];

}

-(void)btnClickAction:(UIButton*)sender{
    !self.didBtnCLickActionBlock ? : self.didBtnCLickActionBlock(sender);
}
@end
