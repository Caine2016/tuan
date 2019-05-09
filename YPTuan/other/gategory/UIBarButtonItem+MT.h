//
//  UIBarButtonItem+MT.h
//  美团
//
//  Created by tarena29 on 15/9/21.
//  Copyright (c) 2015年 tarena29. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MT)
+(UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString*)imageName highImage:(NSString*)highImageName;

+(UIBarButtonItem*)itemWithIcon:(NSString *)icon highIcon:(NSString*)highIcon target:(id)target action:(SEL)action;

@end
