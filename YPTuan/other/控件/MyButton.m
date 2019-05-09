//
//  MyButton.m
//  buddhismYDniu
//
//  Created by gd on 2017/11/2.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "MyButton.h"
@implementation MyButton

+(UIButton*) addDynamicBottomBtnImage:(NSString*)image title:(NSString*)title tag:(NSInteger)tag frame:(CGRect)frame andFont:(CGFloat)font andNormalTitleColor:(UIColor*)color andSelectTitleColor:(UIColor*)selectColor andcontentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment andSelectedImg:(NSString*)selectedImg andTitleEdge:(UIEdgeInsets)insets andImageEdge:(UIEdgeInsets)imgInsets{
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (image) {
        [btn setImage:IMAGENAME(image) forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    if (selectedImg) {
        [btn setImage:IMAGENAME(selectedImg) forState:UIControlStateSelected];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = font(font);
        [btn setTitleColor:selectColor forState:UIControlStateSelected];
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (image && title) {
        [btn setTitleEdgeInsets:insets];
        [btn setImageEdgeInsets:imgInsets];
        
    }
    btn.tag = tag;
    btn.contentHorizontalAlignment = contentHorizontalAlignment;
    //[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}


+(UIButton*) addBtnImage:(NSString*)image title:(NSString*)title tag:(NSInteger)tag frame:(CGRect)frame andFont:(CGFloat)font andNormalTitleColor:(UIColor*)color andSelectTitleColor:(UIColor*)selectColor andcontentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment andSelectedImg:(NSString*)selectedImg{
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (image) {
        [btn setImage:IMAGENAME(image) forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    if (selectedImg) {
        [btn setImage:IMAGENAME(selectedImg) forState:UIControlStateSelected];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
         btn.titleLabel.font = font(font);
        [btn setTitleColor:selectColor forState:UIControlStateSelected];
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (image && title) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,18, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
    }
    btn.tag = tag;
    btn.contentHorizontalAlignment = contentHorizontalAlignment;
    //[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}

-(void)btnClick:(UIButton*)sender{
    
}


+(UIButton*)getImgTopAndTitleBottomBtn:(CGRect)frame img:(UIImage*)image title:(NSString*)title{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];

            ///图标
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn.width, btn.width)];
            imgV.image = image;
            [btn addSubview:imgV];
    //文字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-5, CGRectGetMaxY(imgV.frame)+3 , btn.width+10,btn.height-btn.width-3)];
            label.text = title;
            label.font = font(12.f);
            label.textColor = COLOR_999;
            label.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:label];
    
    
    return btn;
}











@end
