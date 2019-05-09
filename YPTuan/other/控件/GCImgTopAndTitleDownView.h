//
//  GCImgTopAndTitleDownView.h
//  buddhismYDniu
//
//  Created by gd on 2018/11/9.
//  Copyright © 2018 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCImgTopAndTitleDownView : UIButton

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString*)title andSelcetTitle:(NSString*)selectTitle andColor:(UIColor*)titleColor andSelectTitleColor:(UIColor *)selectColor andImg:(NSString*)ImgName andSelectImg:(NSString*)selectImgName;

///3、图片上文字下模式
- (void)layoutButtonWithImageTitleSpace:(CGFloat)space;
///图片下文字上模式
-(void)layoutButtonWithImageDownTitleTopSpace:(CGFloat)space;
///图片右文字左模式
-(void)layoutButtonWithImageRightTitleLeftSpace:(CGFloat)space;

@property (nonatomic,copy) void(^didBtnCLickActionBlock) (UIButton *sender);

@end
