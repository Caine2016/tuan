//
//  BaseVC.h
//  buddhismYDniu
//
//  Created by aolei on 16/5/13.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController
@property (nonatomic,assign) BOOL backRootViewController;
//自定义导航栏
@property (nonatomic, strong) UIView *myNavBarView;
@property (nonatomic, strong) NSString *customTitle;
@property (nonatomic, strong) NSString *backTitle;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *myTitleLabel;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *bottomLineView;

- (void)myTitle:(NSString *)title;
- (void)backAction;
- (void)createRightButton:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector;

- (void)leftBtClickMethod:(id)sender;
@end
