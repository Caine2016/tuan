//
//  YLPreferentialCell.m
//  YPTuan
//
//  Created by gd on 2018/11/29.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLPreferentialCell.h"

@implementation YLPreferentialCell{
    YYLabel* _contentLab;
    NSMutableAttributedString *_attri;
    
    UILabel* _rightLab;
}

-(void)drawRect:(CGRect)rect{
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(BaseBtnPadding, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect)-2*BaseBtnPadding, 0)];
    path.lineWidth = .8;
    [kColorTitleTabbarNormal setStroke];
    [path stroke];
    
}


-(void)createSubViews{
    _contentLab = [[YYLabel alloc] initWithFrame:CGRectMake(BaseBtnPadding, 5, (kScreenWidth-BaseBtnPadding*2)/2, PreferentialCellHeight)];
    [self.contentView addSubview:_contentLab];

    //设置多行
    _contentLab.numberOfLines = 0;
    //这个属性必须设置，多行才有效
    _contentLab.preferredMaxLayoutWidth = (kScreenWidth-BaseBtnPadding*2)/2;
    
    _attri = [[NSMutableAttributedString alloc] init];
    YYAnimatedImageView *imageView1= [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"coupon"]];
    imageView1.frame = CGRectMake(0, 0, 16, 16);
    NSMutableAttributedString *attachText1= [NSMutableAttributedString attachmentStringWithContent:imageView1 contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView1.frame.size alignToFont:[UIFont systemFontOfSize:24] alignment:YYTextVerticalAlignmentCenter];
    //插入到开头
    [_attri insertAttributedString:attachText1 atIndex:0];
    //用label的attributedText属性来使用富文本
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"  50元代金券\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:MainBackColor}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"        ¥2.00代50元" attributes:@{NSFontAttributeName: otherFont(@"MarkerFelt-Wide", 15), NSForegroundColorAttributeName: kColorLogin}];
    [_attri appendAttributedString:str1];
    [_attri appendAttributedString:str2];
   
    _contentLab.attributedText = _attri;
    
    
    _rightLab = [UILabel labelWithFrame:CGRectMake(_contentLab.right, 0, _contentLab.width-15, PreferentialCellHeight) textColor:MainBackColor font:font(14) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    
    [self.contentView addSubview:_rightLab];
    
    _rightLab.text = @"销量 1000";
  
    

}




@end
