//
//  YLMemberCenterCell.m
//  YPTuan
//
//  Created by gd on 2018/12/27.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLMemberCenterCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation YLMemberCenterCell{
    
}

-(void)drawRect:(CGRect)rect{

    
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
     /*写文字*/
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);//设置填充颜色

    CGFloat bottomW = 0;
    CGFloat timeLengthTop = (BaseBtnHeight64 - 3*BaseBtnPadding - bottomW)/2;
    CGFloat timeLengthW = 80;
    CGFloat oldPriceLeft = BaseBtnPadding*2 + timeLengthW;
    CGFloat currentPriceLeft = oldPriceLeft + timeLengthW;

    [self.centerModel.timeLength drawInRect:CGRectMake(BaseBtnPadding,timeLengthTop, timeLengthW, BaseBtnPadding*3) withAttributes:@{NSFontAttributeName:jsFont(20.f)}];
    [self.centerModel.oldPrice drawInRect:CGRectMake(oldPriceLeft,timeLengthTop, timeLengthW, BaseBtnPadding*3) withAttributes:@{NSFontAttributeName:font(18),NSForegroundColorAttributeName:COLOR_999}];
    [self.centerModel.currentPrice drawInRect:CGRectMake(currentPriceLeft,timeLengthTop, timeLengthW, BaseBtnPadding*3) withAttributes:@{NSFontAttributeName:otherFont(@"MarkerFelt-Wide", 20),NSForegroundColorAttributeName:kColorLogin}];
    
    
    ///画旧价格线
    CGContextSetRGBStrokeColor(context,0,0,0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGPoint aoldPricePoints[2];//坐标点
    aoldPricePoints[0] =CGPointMake(oldPriceLeft, (BaseBtnHeight64-BaseBtnPadding)/2);//坐标1
    aoldPricePoints[1] =CGPointMake(oldPriceLeft+60, (BaseBtnHeight64-bottomW)/2);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aoldPricePoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    ///画底钱
    
//    CGContextSetRGBStrokeColor(context, 247,246,242, 1);//改变画笔颜色
//    CGContextSetLineWidth(context, 5);
//
//    CGPoint aPoints[2];
//    aPoints[0] = CGPointMake(0,  BaseBtnHeight64-bottomW);
//    aPoints[1] = CGPointMake(kScreenWidth,  BaseBtnHeight64-bottomW);
//    CGContextAddLines(context, aPoints, 2);
//    CGContextDrawPath(context, kCGPathStroke);
    
//    //画线
//    CGContextMoveToPoint(context, 0, BaseBtnHeight64-bottomW);
//    CGContextAddLineToPoint(context, self.width, BaseBtnHeight64-bottomW);
//    CGContextStrokePath(context);
    UIImage *image;
    if (self.centerModel.isSelect) {
       image = [UIImage imageNamed:@"ico_check_nomal"];
    }else{
        image = [UIImage imageNamed:@"ico_check_select"];

    }
    [image drawInRect:CGRectMake(kScreenWidth-BaseBtnPadding*3, (BaseBtnHeight64-bottomW-BaseBtnPadding*2)/2, BaseBtnPadding*2, BaseBtnPadding*2)];
    
    
    [super drawRect:rect];
    
}

-(void)createSubViews{
    
  
    
    
}

@end
