//
//  YLLoginController.m
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLLoginController.h"
#import "YLRegisteredController.h"
#import "YLLabFieldView.h"
#import "WLDecimalKeyboard.h"
#import "YLUserModel.h"
@interface YLLoginController ()

@property (nonatomic,strong) NSString *iphoneStr;
@property (nonatomic,strong) NSString *pwdStr;
@property (nonatomic,strong) UIView* bgView;

@property (nonatomic,strong) LOTAnimationView *lottieLogo;

@end

@implementation YLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorTitleLIGHTGRAYNormal;
    self.myNavBarView.hidden = YES;
    [self createRightButton:@"注册" imageName:nil selector:@selector(registeredAction)];
    
    [self addView];
    [self loadNotificationCell];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
}
-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"biking_is_cool"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

-(void)addView{
    [self.view addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(250);
    
    UIButton* backBtn = [UIButton buttonWithFrame:CGRectMake(8, kStatusBarHeight+10, 24, 24) normalImage:IMAGENAME(@"blackBack") target:self action:@selector(backAction)];
    [self.view addSubview:backBtn];
    

    self.bgView = [UIView new];
    self.bgView.backgroundColor = KVCBGWhiteColor;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = BaseCornerRadius;
    [self.view addSubview:self.bgView];
    
    UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeybord)];
    // 设置轻拍次数
    aTapGR.numberOfTapsRequired = 1;
    // 添加手势
    [ self.bgView addGestureRecognizer:aTapGR];
    
    
    CGFloat fieldW = 50;
    self.bgView.sd_layout
    .topSpaceToView(self.lottieLogo, -15)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .heightIs(fieldW*2+2+BaseBtnHeight49+30+50);
    
    // text  placeholder  fieldTag
    
    YLLabFieldView* iphoneField = [YLLabFieldView new];
    NSString* iphone = [[EGOCache globalCache] stringForKey:SaveIphoneLocality ];
    
    if (iphone.length > 0 ) {
        iphoneField.textField.text = iphone;
        self.iphoneStr = iphone;
    }
    WLDecimalKeyboard *inputView = [[WLDecimalKeyboard alloc] init];
    iphoneField.textField.inputView = inputView;
    [iphoneField.textField reloadInputViews];
    iphoneField.didTextFieldDidEndEditing = ^(NSString * _Nonnull text, NSInteger fieldTag) {
        if  (![XTools validateMobile:text]) {
            [ShowHUD showWarn:@"请输入正确的手机号码"];
        }
        self.iphoneStr = text;
    };
    
    iphoneField.dataDic = @{
                            @"text" : @"手机号",
                            @"placeholder" : @"11位手机号",
                            @"fieldTag" : @(0)
                            };
    
    
    YLLabFieldView* pwdField = [YLLabFieldView new];
    pwdField.textField.secureTextEntry = YES;
    pwdField.didTextFieldDidEndEditing = ^(NSString * _Nonnull text, NSInteger fieldTag) {
        self.pwdStr = text;
    };
    pwdField.dataDic = @{
                         @"text" : @"密码",
                         @"placeholder" : @"至少6位密码",
                         @"fieldTag" : @(2)
                         };
    
    [self.bgView addSubview:iphoneField];
    [self.bgView addSubview:pwdField];

    
    CGFloat padding = 15;
    iphoneField.sd_layout
    .topEqualToView(self.bgView)
    .leftSpaceToView(self.bgView, padding)
    .rightSpaceToView(self.bgView, padding)
    .heightIs(fieldW);
    
    [self.bgView.layer addSublayer: [GDTool solidShapeLayer:kColorTitleLIGHTGRAYNormal andMoveToPoint:CGPointMake(padding, iphoneField.bottom) andLineToPoint:CGPointMake(kScreenWidth-padding*2-10, iphoneField.bottom)]];
    
    pwdField.sd_layout
    .topSpaceToView(iphoneField, 1)
    .leftSpaceToView(self.bgView, padding)
    .rightSpaceToView(self.bgView, padding)
    .heightIs(fieldW);
    
    [self.bgView.layer addSublayer: [GDTool solidShapeLayer:kColorTitleLIGHTGRAYNormal andMoveToPoint:CGPointMake(padding,101) andLineToPoint:CGPointMake(kScreenWidth-padding*2-10, 101)]];
    
    UIButton* forgetBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"忘记密码" normalColor:COLOR_999 higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(forgetAction)];
    forgetBtn.titleLabel.font = font(16);
    
    [self.bgView addSubview:forgetBtn];
    
    forgetBtn.sd_layout
    .topSpaceToView(pwdField, 10)
    .rightSpaceToView(self.bgView, padding)
    .widthIs(80)
    .heightIs(30);
    
    UIButton* registerBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"立即注册" normalColor:kColorLogin higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(registeredAction)];
    registerBtn.titleLabel.font = HNW3Font(16);
   
    [self.bgView addSubview:registerBtn];
    
    registerBtn.sd_layout
    .topSpaceToView(pwdField, 10)
    .leftSpaceToView(self.bgView, padding)
    .widthIs(80)
    .heightIs(30);
    
    
    UIButton* submitBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"登录" normalColor:KVCBGWhiteColor higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(loginAction)];
    
    submitBtn.layer.masksToBounds = YES;
    submitBtn.backgroundColor = kColorLogin;
    submitBtn.layer.cornerRadius = BaseBtnHeight49/2;
    [self.bgView addSubview:submitBtn];
    
    submitBtn.sd_layout
    .topSpaceToView(registerBtn, 20)
    .leftSpaceToView(self.bgView, padding)
    .rightSpaceToView(self.bgView, padding)
    .heightIs(BaseBtnHeight49);
    
    
}

#define mark - action -
-(void)registeredAction{
    
    YLRegisteredController* registVC = [YLRegisteredController new];
    [self.navigationController pushViewController:registVC animated:YES];
    
}

-(void)loginAction{
    [self.view endEditing:YES];
    if (self.iphoneStr.length <= 0 || self.pwdStr.length <= 0 ) {
        [ShowHUD showErrorStatus:@"账号名和密码不能为空"];
        return;
        
    }
    
    
    [[EGOCache globalCache] setString:self.iphoneStr forKey:SaveIphoneLocality withTimeoutInterval:365*60*60*24];
    
 
    NSDictionary* dic =  @{
                           @"userName":self.iphoneStr,
                           @"password":self.pwdStr
                           };
   
    
    [BaseDataServiceSISingle postUrlJoiningTogether:UserLoginUrl andParams:dic andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        
        if (!succ) {
            [ShowHUD showErrorStatus:responseData.returnMsg];
            return ;
        }
        
        [BaseDataServiceSISingle getUrl:GetUserInfoUrl andParamstr:self.iphoneStr andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
            CNSLog(@"%@--returnData %@",responseData.returnMsg,responseData.returnData);
            
            if (!succ) {
                [ShowHUD showErrorStatus:responseData.returnMsg];
                return ;
            }
       
            [YLUserModel mj_objectWithKeyValues:responseData.returnData];
            [GDNotificationCenter postNotificationName:LoginOrLogOutNotification object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    


}

-(void)forgetAction{
    
}

-(void)hideKeybord{
    [self.view endEditing:YES];
}


-(void)loadNotificationCell
{
    
    [GDNotificationCenter addObserver:self
                             selector:@selector(keyboardWillShow:)
                                 name:UIKeyboardWillShowNotification
                               object:nil];
    
    [GDNotificationCenter addObserver:self
                             selector:@selector(keyboardShow:)
                                 name:UIKeyboardDidShowNotification
                               object:nil];
    
    [GDNotificationCenter addObserver:self
                             selector:@selector(keyboardWillHide:)
                                 name:UIKeyboardWillHideNotification
                               object:nil];
    
    [GDNotificationCenter addObserver:self
                             selector:@selector(keyboardHide:)
                                 name:UIKeyboardDidHideNotification
                               object:nil];
    
}
#pragma mark --键盘通知--
-(void)dealloc{
    [GDNotificationCenter removeObserver:self];
}
- (void)keyboardWillShow:(NSNotification *)notif {
    
    if (self.view.hidden == YES) {
        return;
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    
    self.bgView.top = kBaseTopHeight;
    
    [UIView commitAnimations];
}

- (void)keyboardShow:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    self.bgView.top = self.lottieLogo.bottom - 15;
    
    
    [UIView commitAnimations];
}

- (void)keyboardHide:(NSNotification *)notif {
    if (self.view.hidden == YES) {
        return;
    }
}


@end
