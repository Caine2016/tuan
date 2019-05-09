//
//  YLChagePwdController.m
//  YPTuan
//
//  Created by gd on 2018/11/18.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLChagePwdController.h"

@interface YLChagePwdController ()

@end

@implementation YLChagePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"修改密码";
    [self.submitBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    
    self.bgView.sd_layout.heightIs( fieldW*4+3);
    
    YLLabFieldView* pwdField = [YLLabFieldView new];
    pwdField.didTextFieldDidEndEditing = ^(NSString * _Nonnull text, NSInteger fieldTag) {
        
    };
    pwdField.dataDic = @{
                         @"text" : @"确认密码",
                         @"placeholder" : @"再次输入密码",
                         @"fieldTag" : @(3)
                         };
    
    [self.bgView addSubview:pwdField];
    
    pwdField.sd_layout
    .bottomEqualToView(self.bgView)
    .leftSpaceToView(self.bgView, padding)
    .rightSpaceToView(self.bgView, padding)
    .heightIs(fieldW);
    
    [self.bgView.layer addSublayer: [GDTool solidShapeLayer:kColorTitleLIGHTGRAYNormal andMoveToPoint:CGPointMake(padding,fieldW*3+2) andLineToPoint:CGPointMake(kScreenWidth-padding*2-10, fieldW*3+2)]];
    
    
}


@end
