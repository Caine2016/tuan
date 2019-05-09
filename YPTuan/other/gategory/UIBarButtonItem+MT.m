//
//  UIBarButtonItem+MT.m
//  美团
//
//  Created by tarena29 on 15/9/21.
//  Copyright (c) 2015年 tarena29. All rights reserved.
//

#import "UIBarButtonItem+MT.h"
#import "UIImage+CH.h"
@implementation UIBarButtonItem (MT)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)imageName highImage:(NSString *)highImageName
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    //设置尺寸
    btn.frame=CGRectMake(0, 0, btn.currentImage.size.width, btn.currentImage.size.height);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *btn=[[UIButton alloc]init];
    // 这里需要注意：由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    // 让按钮图片左移15
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [btn setImage:[UIImage resizedImage:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage resizedImage:highIcon] forState:UIControlStateHighlighted];
    btn.frame=CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
