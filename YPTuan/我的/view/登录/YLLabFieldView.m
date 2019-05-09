//
//  YLLabFieldView.m
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLLabFieldView.h"

@implementation YLLabFieldView{
   
    UILabel* _label;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    
    _label = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:font(16) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectZero];
    _textField.font = font(14);
    _textField.textColor = [UIColor grayColor];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
    
    [self sd_addSubviews:@[_label,_textField]];
    _label.sd_layout
    .topEqualToView(self)
    .bottomEqualToView(self)
    .leftSpaceToView(self, 8)
    .widthIs(65);
    
    _textField.sd_layout
    .topEqualToView(self)
    .bottomEqualToView(self)
    .rightEqualToView(self)
    .leftSpaceToView(_label, 8);
    
    
}
// text  placeholder  fieldTag
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _label.text = dataDic[@"text"];
    _textField.placeholder = dataDic[@"placeholder"];
    _textField.tag = [dataDic[@"fieldTag"] integerValue];
}
   
     
-(void)textChangeAction:(UITextField*)textField{
    
   
   !self.didTextChangeActionBlock ? : self.didTextChangeActionBlock(textField.text,textField.tag);
    
}
     
     
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    !self.didTextFieldDidEndEditing ? : self.didTextFieldDidEndEditing(textField.text,textField.tag);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

/// 设置自定义键盘后，delegate 不会被调用？
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@", [textField.text stringByReplacingCharactersInRange:range withString:string]);
    
    return YES;
}

@end
