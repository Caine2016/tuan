//
//  YLLabLeftImgBackView.m
//  YPTuan
//
//  Created by Caine on 2018/12/1.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLLabLeftImgBackView.h"

@implementation YLLabLeftImgBackView{
    UILabel* _titleLab;
    UIImageView* _imgView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    
    _titleLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:font(16) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    
    _imgView = [UIImageView new];
    _imgView.image = IMAGENAME(@"rightJianTao");
    [self addSubview:_imgView];
    [self addSubview:_titleLab];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    !self.didLabLeftImgBackViewBlock ? : self.didLabLeftImgBackViewBlock();
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLab.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self, BaseBtnPadding)
    .bottomEqualToView(self)
    .widthIs(self.width/2);
    
    _imgView.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self, BaseBtnPadding)
    .heightIs(25)
    .widthEqualToHeight();
}

-(void)setTitle:(NSString *)title{
    _titleLab.text = title;
}

@end
