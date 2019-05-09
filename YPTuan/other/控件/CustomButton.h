//
//  CustomButton.h
//  buddhismYDniu
//
//  Created by aolei on 16/10/10.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomButtonType) {
    CustomButtonTypeTitleLeft,
    CustomButtonTypeTitleDown
};

@interface CustomButton : UIControl
///图片
@property (nonatomic, strong) UIImageView *imageView;
///图片大小
@property (nonatomic, assign) CGSize imageSize;
///文字视图
@property (nonatomic, strong) UILabel *titleView;
///背景颜色视图
@property (nonatomic, strong) UIImageView *backgroudView;
///点击背景颜色
@property (nonatomic, strong) UIColor *tapBackColor;
///点击是否有背景颜色 默认没有
@property (nonatomic, assign) BOOL isTapColor;
///标签
@property (nonatomic, assign) NSInteger sectionIndex;
///选择事件
@property (nonatomic, copy) void (^selectedBlock)(NSInteger index);

@property (nonatomic,assign) CustomButtonType btnTyPe;

@end
