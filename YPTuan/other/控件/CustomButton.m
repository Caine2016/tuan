//
//  CustomButton.m
//  buddhismYDniu
//
//  Created by aolei on 16/10/10.
//  Copyright © 2016年 aolei. All rights reserved.
//#import "UIView+MJ.h"

#import "CustomButton.h"
#import "UIView+MJ.h"
@implementation CustomButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.backgroudView];
        [self addSubview:self.imageView];
        [self addSubview:self.titleView];
        [self addTarget:self action:@selector(touchDownAction) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(touchCancelAction) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside];
        [self addTarget:self action:@selector(touchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark -@get/set
- (UIImageView*)backgroudView
{
    if (_backgroudView) return _backgroudView;
    _backgroudView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 6, 6)];
    _backgroudView.layer.drawsAsynchronously = YES;
    _backgroudView.layer.masksToBounds = YES;
    _backgroudView.layer.cornerRadius = 2.f;
    _backgroudView.backgroundColor = [UIColor clearColor];
    return _backgroudView;
}

- (UIImageView*)imageView
{
    if (_imageView) return _imageView;
    _imageView = [UIImageView new];
    return _imageView;
}

- (UILabel*)titleView
{
    if (_titleView) return _titleView;
    _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.width,20)];
    _titleView.textAlignment = NSTextAlignmentCenter;
    return _titleView;
}

- (void)setImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
    _imageView.size = _imageSize;
    [self _updatePoint];
}

#pragma mark -@action
- (void)touchDownAction
{
    if (_isTapColor && _tapBackColor)
    self.backgroudView.backgroundColor = _tapBackColor;
}

- (void)touchCancelAction
{
    if (_isTapColor && _tapBackColor)
    self.backgroudView.backgroundColor = [UIColor clearColor];
}

- (void)touchUpInsideAction
{
    self.selectedBlock(_sectionIndex);
    if (_isTapColor && _tapBackColor)
    self.backgroudView.backgroundColor = [UIColor clearColor];
}

#pragma mark -@private
//文字在上
- (void)_updatePoint
{
   
    
    
 
    if (self.btnTyPe == CustomButtonTypeTitleLeft) {
        ///计算边距
        CGFloat marginHeight = (self.height - self.imageView.height - 10)/2;
        self.imageView.top = marginHeight;
        self.imageView.left = 10;
        self.titleView.left = self.imageView.right - 25;
        self.titleView.centerY = self.imageView.centerY;
        
    }else{
        ///计算边距
        CGFloat marginHeight = (self.height - self.imageView.height - 23)/2;
        self.imageView.top = marginHeight;
        self.imageView.centerX = self.width/2;
        self.titleView.left = 0;
      
       self.titleView.top = self.imageView.bottom + 3;
        // self.titleView.centerY = self.imageView.centerY + self.imageView.height/2;
    }
    [self layoutIfNeeded];
}



@end
