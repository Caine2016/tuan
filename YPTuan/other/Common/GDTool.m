//
//  GDTool.m
//  buddhismYDniu
//
//  Created by gd on 2017/11/23.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "GDTool.h"

@implementation GDTool





+(void) guideRoundedCorners:(UIView*)myView byCorners:(UIRectCorner)corners bySize:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:myView.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = myView.bounds;
    maskLayer.path = maskPath.CGPath;
    myView.layer.mask = maskLayer;
}

+(CAShapeLayer*)solidShapeLayer:(UIColor *)color andMoveToPoint:(CGPoint)point andLineToPoint:(CGPoint)endPoint{
    
    /*
     *画实线
     */
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[color CGColor]];
    solidShapeLayer.lineWidth = .8f ;
    CGPathMoveToPoint(solidShapePath, NULL, point.x, point.y);
    CGPathAddLineToPoint(solidShapePath, NULL, endPoint.x,endPoint.y);
  //  CGPathAddLineToPoint(solidShapePath, NULL, 300,50);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
   // [self.view.layer addSublayer:solidShapeLayer];
    
    return solidShapeLayer;
    
}

+(CAShapeLayer *)dotteShapeLayer:(UIColor *)color andMoveToPoint:(CGPoint)point andLineToPoint:(CGPoint)endPoint{
    
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    [dotteShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [dotteShapeLayer setStrokeColor:[color CGColor]];
    dotteShapeLayer.lineWidth = 1.0f ;
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, point.x,point.y);
    CGPathAddLineToPoint(dotteShapePath, NULL, endPoint.x, endPoint.y);
   // CGPathAddLineToPoint(dotteShapePath, NULL, 300,285);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
   
    return dotteShapeLayer;
    
    
}

+(CAShapeLayer *)solidLine:(UIColor *)color andFrame:(CGRect)frame{
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 1.0f ;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, frame);
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    
    return solidLine;
    
    
}
+(CAShapeLayer *)solidFillLine:(UIColor *)color andFrame:(CGRect)frame{
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 1.0f ;
    solidLine.strokeColor = [UIColor clearColor].CGColor;
    solidLine.fillColor = color.CGColor;
    CGPathAddEllipseInRect(solidPath, nil, frame);
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    
    return solidLine;
}

+(CAShapeLayer *)dotteLine:(UIColor *)color andFrame:(CGRect)frame{
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 1.0f ;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, frame);
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    
    return solidLine;
    
    
}

+(NSString*) setTimeBySeconds:(NSInteger) seconds{
    NSString* time ;
    if (seconds <= 60) {
        time = [NSString stringWithFormat:@"%ld秒",(long)seconds];
    }else if (seconds <= 3600){
        time = [NSString stringWithFormat:@"%ld分%ld秒",(long)seconds/60,(long)seconds%60];
    }else if(seconds < 3600*24){
        time = [NSString stringWithFormat:@"%ld时%ld分%ld秒",(long)seconds/3600,((long)seconds%3600)/60,((long)seconds%3600)%60];
    }else if(seconds < 3600*24*365){
        time = [NSString stringWithFormat:@"%ld天",(long)seconds/(3600*24)];
    }else{
        time = [NSString stringWithFormat:@"%ld年%ld天",(long)seconds/(3600*24*365),((long)seconds%(3600*24*365))/(3600*24)];
    }
    
    return time;
}


+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}
@end
