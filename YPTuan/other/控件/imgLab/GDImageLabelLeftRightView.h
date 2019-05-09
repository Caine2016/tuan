//
//  GDImageLabelLeftRightView.h
//  buddhismYDniu
//
//  Created by gd on 2018/7/4.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GDImageLabelLeftRightView : UIView

@property (nonatomic,copy) NSDictionary *contentDic;

@property (nonatomic,assign) CGFloat textFont;

@property (nonatomic,copy) dispatch_block_t didImageLabelLeftRightViewTouchBlock;

@end
