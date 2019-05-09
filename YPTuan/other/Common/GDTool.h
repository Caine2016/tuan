//
//  GDTool.h
//  buddhismYDniu
//
//  Created by gd on 2017/11/23.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDTool : NSObject



//让view显示某一侧的边框线
+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
//转秒
+(NSString*) setTimeBySeconds:(NSInteger) seconds;

//* UIRectCornerTopLeft
//* UIRectCornerTopRight
//* UIRectCornerBottomLeft
//* UIRectCornerBottomRight
//* UIRectCornerAllCorners
//导圆角
+(void) guideRoundedCorners:(UIView*)myView byCorners:(UIRectCorner)corners bySize:(CGSize)size;
//画直线
+(CAShapeLayer*)solidShapeLayer:(UIColor*)color andMoveToPoint:(CGPoint)point andLineToPoint:(CGPoint)endPoint;


/*
 *画虚线
 */
+(CAShapeLayer*)dotteShapeLayer:(UIColor*)color andMoveToPoint:(CGPoint)point andLineToPoint:(CGPoint)endPoint;


/*
 *画实线圆 (空心)
 */

+(CAShapeLayer*)solidLine:(UIColor*)color andFrame:(CGRect)frame;

/*
 *画虚线圆
 */
+(CAShapeLayer*)dotteLine:(UIColor*)color andFrame:(CGRect)frame; //传入半径

/*
 *画实心圆
 */
+(CAShapeLayer*)solidFillLine:(UIColor*)color andFrame:(CGRect)frame;
@end
