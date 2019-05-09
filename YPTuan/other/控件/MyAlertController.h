//
//  MyAlertController.h
//  buddhismYDniu
//
//  Created by gd on 2017/11/7.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyAlertAction : UIAlertAction

@property (nonatomic,strong) UIColor *textColor; /**< 按钮title字体颜色 */

@end

@interface MyAlertController : UIAlertController

@property (nonatomic,strong) UIColor *tintColor; /**< 统一按钮样式 不写系统默认的蓝色 */
@property (nonatomic,strong) UIColor *titleColor; /**< 标题的颜色 */
@property (nonatomic,strong) UIColor *messageColor; /**< 信息的颜色 */




@end
