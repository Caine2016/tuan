//
//  YLRegisteredController.m
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLRegisteredController.h"
#import "WLDecimalKeyboard.h"

@interface YLRegisteredController ()<APIManagerParamSourceDelegate,APIManagerApiCallBackDelegate>

@property (nonatomic,strong) UIButton *getCodeButton;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@property (nonatomic,strong) NSString *iphoneStr;
@property (nonatomic,strong) NSString *pwdStr;
@property (nonatomic,strong) NSString *codeStr;

@property(nonatomic,strong) LoginRequest *registereRequest;

@end

@implementation YLRegisteredController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"注册";
    self.view.backgroundColor = kColorTitleLIGHTGRAYNormal;
    
    [self addView];
    
}


-(void)addView{
  
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(padding, kBaseTopHeight+15, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UIView* bgView = [UIView new];
    bgView.backgroundColor = KVCBGWhiteColor;
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = BaseCornerRadius;
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
 
    bgView.sd_layout
    .topSpaceToView(label, 5)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .heightIs(fieldW*3+2);
    
    // text  placeholder  fieldTag
    
    YLLabFieldView* iphoneField = [YLLabFieldView new];
    iphoneField.didTextChangeActionBlock = ^(NSString * _Nonnull textChange, NSInteger fieldTag) {
        //self.iphoneStr = textChange;
       
        if (  textChange.length >= 8 && textChange.length<=15) {
            self.getCodeButton.enabled = YES;
        }else{
            self.getCodeButton.enabled = NO;
        }
        
    };
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
    WLDecimalKeyboard *inputView = [[WLDecimalKeyboard alloc] init];
    iphoneField.textField.inputView = inputView;
    [iphoneField.textField reloadInputViews];
    
    YLLabFieldView* codeField = [YLLabFieldView new];
    codeField.didTextFieldDidEndEditing = ^(NSString * _Nonnull text, NSInteger fieldTag) {
        self.codeStr = text;
    };
    codeField.dataDic = @{
                            @"text" : @"验证码",
                            @"placeholder" : @"6位验证码",
                            @"fieldTag" : @(1)
                            };
    codeField.textField.inputView = inputView;
    [codeField.textField reloadInputViews];

    YLLabFieldView* pwdField = [YLLabFieldView new];
 
    pwdField.didTextFieldDidEndEditing = ^(NSString * _Nonnull text, NSInteger fieldTag) {
        self.pwdStr = text;
    };
    pwdField.dataDic = @{
                          @"text" : @"密码",
                          @"placeholder" : @"至少6位密码",
                          @"fieldTag" : @(2)
                          };
    
    [bgView addSubview:iphoneField];
    [bgView addSubview:pwdField];
    [bgView addSubview:codeField];
    
   
    iphoneField.sd_layout
    .topEqualToView(bgView)
    .leftSpaceToView(bgView, padding)
    .rightSpaceToView(bgView, padding)
    .heightIs(fieldW);
    
    [bgView.layer addSublayer: [GDTool solidShapeLayer:kColorTitleLIGHTGRAYNormal andMoveToPoint:CGPointMake(padding, iphoneField.bottom) andLineToPoint:CGPointMake(kScreenWidth-padding*2-10, iphoneField.bottom)]];
    
    codeField.sd_layout
    .topSpaceToView(iphoneField, 1)
    .leftSpaceToView(bgView, padding)
    .rightSpaceToView(bgView, padding+100)
    .heightIs(fieldW);
    
    [bgView.layer addSublayer: [GDTool solidShapeLayer:kColorTitleLIGHTGRAYNormal andMoveToPoint:CGPointMake(padding,101) andLineToPoint:CGPointMake(kScreenWidth-padding*2-10, 101)]];
    
    pwdField.sd_layout
    .topSpaceToView(codeField, 1)
    .leftSpaceToView(bgView, padding)
    .rightSpaceToView(bgView, padding)
    .heightIs(fieldW);
    
    UIButton* submitBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"提交" normalColor:KVCBGWhiteColor higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(submitAction)];
    submitBtn.backgroundColor = kColorLogin;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = BaseBtnHeight49/2;
    self.submitBtn = submitBtn;
    [self.view addSubview:submitBtn];
    
    submitBtn.sd_layout
    .topSpaceToView(bgView, 50)
    .leftSpaceToView(self.view, padding)
    .rightSpaceToView(self.view, padding)
    .heightIs(BaseBtnHeight49);
    
    self.getCodeButton=[[UIButton alloc]initWithFrame:CGRectZero];
    [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeButton setTitleColor:COLOR_999 forState:UIControlStateNormal];
    [self.getCodeButton setTitleColor:kColorTitleLIGHTGRAYNormal forState:UIControlStateDisabled];
    self.getCodeButton.enabled = NO;
    self.getCodeButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.getCodeButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:self.getCodeButton];
    
    self.getCodeButton.sd_layout
    .topSpaceToView(iphoneField, 0)
    .rightSpaceToView(bgView, padding)
    .bottomEqualToView(codeField)
    .widthIs(100);
     
}

#pragma mark -- action --
-(void)getValidCode:(UIButton*)sender{
    
    sender.userInteractionEnabled = NO;
    self.timeCount = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
}
- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.getCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.getCodeButton setTitleColor:kColorTitleLIGHTGRAYNormal forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getCodeButton.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%ld秒后重新获取", (long)self.timeCount];
        [self.getCodeButton setTitle:str forState:UIControlStateNormal];
        self.getCodeButton.userInteractionEnabled = NO;
        
    }
}
-(void)submitAction{
    [self.view endEditing:YES];
    if (self.codeStr.length <= 0) {
        [ShowHUD showErrorStatus:@"请输入正确的认证码"];
        return;
    }
  //  [self.registereRequest loadDataWithHUDOnView:self.view];
    
     [[EGOCache globalCache] setString:self.iphoneStr forKey:SaveIphoneLocality withTimeoutInterval:365*60*60*24];
    
     NSString* pwdMd5 = [XTools md5:self.pwdStr];
    NSDictionary* dic =  @{
                           @"userName":self.iphoneStr,
                           @"password":pwdMd5
                           };
    
    
    [BaseDataServiceSISingle postUrlJoiningTogether:UserLoginUrl andParams:dic andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        
        CNSLog(@"responseData2018--%@",responseData);
        
        [BaseDataServiceSISingle getUrl:RegisterUserUrl andParamstr:self.iphoneStr andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
            CNSLog(@"%@--returnData",responseData.returnData);
            
            [YLUserModel mj_objectWithKeyValues:responseData.returnData];
            [GDNotificationCenter postNotificationName:LoginOrLogOutNotification object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (LoginRequest *)registereRequest {
    if (!_registereRequest) {
        /**
         注意：这里并不是简单的init初始化，你是需要遵守三个协议方法的，所以这里有两个self,因为文章开头我就讲了，忘了的同学请上翻⬆️*/
        _registereRequest = [[LoginRequest alloc] initWithDelegate:self paramSource:self];
        _registereRequest.urlPath = RegisterUserUrl;
    }
    return _registereRequest;
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request {
    /** 如果请求的接口需要传参，那么在此return。 */
    NSString* pwdMd5 = [XTools md5:self.pwdStr];
    if (request == self.registereRequest) {
        return @{@"userName":self.iphoneStr,
                 @"password":pwdMd5};
    }
    /** 文章中已经提到，如果该请求接口没有参数，直接返回nil即可。 */
    return nil;
}

/** 请求之后的，成功、失败的回调。 */
#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
    
    if (request == self.registereRequest) {
        /**
         此处就是赋值操作，将请求下来的数据源，
         赋值给tableView的数据源，然后刷新表格即可。
         */
        
        
        [BaseDataServiceSISingle getUrl:GetUserInfoUrl  andParamstr:self.iphoneStr andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
            CNSLog(@"%@--returnData",responseData.returnData);
            
            [YLUserModel mj_objectWithKeyValues:responseData.returnData];
            [GDNotificationCenter postNotificationName:LoginOrLogOutNotification object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        CNSLog(@"responseData2018--%@",request.responseData );
        return;
    }
  
}
/** 失败，可以不写什么，因为返回的是return，根据需求自行处理吧。 */
- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
     CNSLog(@"Failed2018--%@",[request.responseData valueForKey:@"returnMsg"]);
    
    [ShowHUD showErrorStatus:[request.responseData valueForKey:@"returnMsg"]];
    
}



@end
