//
//  GDImageLabelLeftRightView.m
//  buddhismYDniu
//
//  Created by gd on 2018/7/4.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDImageLabelLeftRightView.h"

@implementation GDImageLabelLeftRightView

{
    UIImageView *_iconView;
    UILabel *_nameLable;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
}

-(void)setContentDic:(NSDictionary *)contentDic{
    _contentDic     = contentDic;
    _iconView.image = IMAGENAME(contentDic[@"Image"]);
    _nameLable.text = contentDic[@"text"];
    CGFloat fontText= [contentDic[@"font"] floatValue];
    _nameLable.font = font(fontText);
}

-(void)creatView{
    
    _iconView                = [UIImageView new];
    
    _nameLable               = [UILabel new];
    _nameLable.numberOfLines = 0;
    _nameLable.textColor     = MainBackColor;

    [self sd_addSubviews:@[_iconView,_nameLable]];
    
 
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 5;
    _iconView.sd_layout
    .leftSpaceToView(self, 0)
    .centerYEqualToView(self)
    .widthIs(30)
    .heightIs(30);
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    !self.didImageLabelLeftRightViewTouchBlock ? : self.didImageLabelLeftRightViewTouchBlock();
}

@end
