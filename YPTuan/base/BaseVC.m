//
//  BaseVC.m
//  buddhismYDniu
//
//  Created by aolei on 16/5/13.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import "BaseVC.h"
@interface BaseVC ()
@end

@implementation BaseVC
- (void)leftBtClickMethod:(id)sender{
    [self.view endEditing:YES];
    if (_backRootViewController) {
        if (![self.navigationController popToRootViewControllerAnimated:YES]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        if (![self.navigationController popViewControllerAnimated:YES]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
- (instancetype)init{
    if (self = [super init]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myNavBarView];
    self.view.backgroundColor = VCBGColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark -@public
//设置返回按钮
- (void)myTitle:(NSString *)title{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
}

#pragma mark -@get/set
- (void)createRightButton:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector{
    
    [self.rightButton setTitleColor:MainBackColor forState:UIControlStateNormal];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
}
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton new];
    }
    return _rightButton;
}
- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = VCBGColor;
    }
    return _bottomLineView;
}
-(void)setBackTitle:(NSString *)backTitle{
    _backTitle = backTitle;
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0,self.backImageView.width+1,0, 0);
    
    _backButton.titleLabel.font = font(18);
     [self.backButton setTitle:_backTitle forState:UIControlStateNormal];
}
- (UIView*)myNavBarView
{
    if (_myNavBarView) return _myNavBarView;
    //自定义导航栏
    _myNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kBaseTopHeight)];
    _myNavBarView.backgroundColor = KVCBGWhiteColor;//NavigationBarColor;
   
    [_myNavBarView addSubview:self.backButton];
    [_myNavBarView addSubview:self.myTitleLabel];
    [_myNavBarView addSubview:self.rightButton];
    [_myNavBarView addSubview:self.bottomLineView];
    
    self.rightButton.sd_layout
    .rightSpaceToView(_myNavBarView, 10)
    .bottomEqualToView(_myNavBarView)
    .topSpaceToView(_myNavBarView, kStatusBarHeight)
    .widthIs(44);

    self.bottomLineView.sd_layout
    .leftEqualToView(_myNavBarView)
    .rightEqualToView(_myNavBarView)
    .bottomEqualToView(_myNavBarView)
    .heightIs(.8);

  
    return _myNavBarView;
}


- (UIButton*)backButton
{
    if (_backButton) return _backButton;
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, kStatusBarHeight, 80, 44)];
    _backButton.backgroundColor = [UIColor clearColor];
    _backButton.opaque = NO;
    
 
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton addSubview:self.backImageView];
    return _backButton;
}

- (UIImageView*)backImageView
{
    if (_backImageView) return _backImageView;
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 24, 24)];
    _backImageView.image = IMAGENAME(@"blackBack");
    _backImageView.contentMode = UIViewContentModeScaleAspectFit;
    return _backImageView;
}

- (UILabel*)myTitleLabel

{
    if (_myTitleLabel) return _myTitleLabel;
    _myTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 120)/2,kStatusBarHeight+10, 120, 24)];
    _myTitleLabel.font = jsFont(21);
    _myTitleLabel.textAlignment = NSTextAlignmentCenter;
    _myTitleLabel.textColor = MainBackColor;
    return _myTitleLabel;
}

- (void)dealloc{
    CNSLog(@"---->>>>>>> %@销毁了....",NSStringFromClass(self.class));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)backAction{
//    [self.navigationController popViewControllerAnimated:YES];
    [self leftBtClickMethod:nil];
}

- (void)setCustomTitle:(NSString *)customTitle{
    _customTitle = customTitle;
    _myTitleLabel.text = customTitle;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
