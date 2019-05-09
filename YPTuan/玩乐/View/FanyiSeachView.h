//
//  FanyiSeachView.h
//  buddhismYDniu
//
//  Created by gd on 2017/12/22.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FanyiSeachViewBlock)(void);

@interface FanyiSeachView : UIView

@property (nonatomic,copy) FanyiSeachViewBlock block;

@end
