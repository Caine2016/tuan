//
//  GDSearchView.m
//  buddhismYDniu
//
//  Created by gd on 2018/6/13.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDSearchView.h"
#import "GDTextFieldPlaceholderView.h"
@interface GDSearchView ()<UITextFieldDelegate>

///搜索视图
@property (nonatomic, strong) UIView           *searchView;


@end

@implementation GDSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorLogin;
        self.userInteractionEnabled = YES;
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    [self addSubview:self.searchView];
    
    [self.searchView addSubview:self.searchText];
    
     if (!self.searchText.isFirstResponder) [self.searchText becomeFirstResponder];
}


#pragma mark -@get/set
- (UIView*)searchView
{
    if (!_searchView)
    {
        _searchView                     = [[UIView alloc] initWithFrame:CGRectMake(10,27, kScreenWidth - 65, 30)];
        _searchView.layer.masksToBounds = YES;
        _searchView.layer.cornerRadius  = 12.f;
        _searchView.backgroundColor     = RGBCOLOR(232, 232, 232);
        UIImageView *imageView          = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
        imageView.image                 = [UIImage imageNamed:@"search_y"];
        [_searchView addSubview:imageView];
        
    }
    return _searchView;
}

- (GDTextFieldPlaceholderView*)searchText
{
    if (!_searchText)
    {
        _searchText                       = [[GDTextFieldPlaceholderView alloc] initWithFrame:CGRectMake(30, 1, _searchView.width - 33, 30)];
        _searchText.textColor             = RGBCOLOR(158, 158, 158);
        _searchText.font                  = [UIFont systemFontOfSize:17.f];
        _searchText.returnKeyType         = UIReturnKeySearch;
        _searchText.delegate              = self;
        _searchText.clearButtonMode       = UITextFieldViewModeWhileEditing;
        _searchText.tintColor             = kColorLogin;
        [_searchText addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
       _searchText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入要搜索的内容" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBCOLOR(178, 178, 178)}];
        
    }
    return _searchText;
}

-(void)setText:(NSString *)text{
    self.searchText.text = text;
}
#pragma mark -@protocol UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        !self.searchViewBlock ? : self.searchViewBlock(textField.text);
      
    }else{
        [ShowHUD showWarn: @"请输入要搜索的关键词"];
        
    }
    [self.searchText resignFirstResponder];
    return YES;
}


- (void)textChangeAction:(UITextField*)textFiled  //监控文字变化
{
     !self.textChangeActionBlock ? : self.textChangeActionBlock(textFiled.text);
}


@end
