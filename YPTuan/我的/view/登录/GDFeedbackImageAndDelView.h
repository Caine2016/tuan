//
//  GDFeedbackImageAndDelView.h
//  buddhismYDniu
//
//  Created by gd on 2018/4/19.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDFeedbackImageAndDelView : UIView

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,copy) void (^delViewBlock)();


@end
