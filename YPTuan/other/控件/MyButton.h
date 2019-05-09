//
//  MyButton.h
//  buddhismYDniu
//
//  Created by gd on 2017/11/2.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyButton : UIView




+(UIButton*)getImgTopAndTitleBottomBtn:(CGRect)frame img:(UIImage*)image title:(NSString*)title;



+(UIButton*) addBtnImage:(NSString*)image title:(NSString*)title tag:(NSInteger)tag frame:(CGRect)frame andFont:(CGFloat)font andNormalTitleColor:(UIColor*)color andSelectTitleColor:(UIColor*)selectColor andcontentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment andSelectedImg:(NSString*)selectedImg;


+(UIButton*) addDynamicBottomBtnImage:(NSString*)image title:(NSString*)title tag:(NSInteger)tag frame:(CGRect)frame andFont:(CGFloat)font andNormalTitleColor:(UIColor*)color andSelectTitleColor:(UIColor*)selectColor andcontentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment andSelectedImg:(NSString*)selectedImg andTitleEdge:(UIEdgeInsets)insets andImageEdge:(UIEdgeInsets)imgInsets;


@end
