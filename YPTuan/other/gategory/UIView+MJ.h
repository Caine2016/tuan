//
//  UIView+MJ.h
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MJ)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign,nonatomic) CGFloat centerX;
@property (assign,nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize  size;
@property (assign, nonatomic) CGPoint origin;
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.

@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@end
