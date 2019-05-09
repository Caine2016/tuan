//
//  YLLabHeaderView.m
//  YPTuan
//
//  Created by gd on 2018/11/20.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLLabHeaderView.h"

@interface YLLabHeaderView ()

@end

@implementation YLLabHeaderView{
    UILabel* _titleLab;
    UILabel* _suTitleLab;
    UILabel* _rightLab;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    !self.didMoreBlock ? :  self.didMoreBlock();
}
- (void)drawRect:(CGRect)rect{
   
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(5, 1)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(rect)-10, 1)];
        path.lineWidth = 1.f;
        [VCBGColor setStroke];
        [path stroke];
   
}

-(instancetype)initWithFrame:(CGRect)frame andTitle:(nonnull NSString*)title andSubTitle:(NSString*)subTitle andRightTitle:(NSString*)rightTitle{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
       
        [self creatView];
        
         _titleLab.text = title;
        if (subTitle) {
            _suTitleLab.text = subTitle;
        }
        if (rightTitle) {
            _rightLab.text = rightTitle;
        }
    }
    
    return self;
}

-(void)creatView{
    
    _titleLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:jsFont(20) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    _suTitleLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:font(16) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    _rightLab = [UILabel labelWithFrame:CGRectZero textColor:COLOR_999 font:font(16) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    
    [self sd_addSubviews:@[_titleLab,_suTitleLab,_rightLab]];
    
    _titleLab.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self, BaseBtnPadding)
    .heightIs(titleLabHeaderH)
    .widthIs(kAdapterWidth(250));
    
    _suTitleLab.sd_layout
    .topSpaceToView(_titleLab, 0)
    .leftEqualToView(_titleLab)
    .heightIs(subLabHeaderTitleH)
    .widthIs(kAdapterWidth(250));
    
    _rightLab.sd_layout
    .topEqualToView(self)
    .rightSpaceToView(self, BaseBtnPadding)
    .leftSpaceToView(_titleLab, BaseBtnPadding)
    .heightIs(titleLabHeaderH);
}



@end
