//
//  YLLabFieldView.h
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLLabFieldView : UIView<UITextFieldDelegate>

@property (nonatomic,strong) NSDictionary* dataDic;
@property (nonatomic,strong)  UITextField *textField;

@property (nonatomic,copy) void(^didTextChangeActionBlock) (NSString* textChange,NSInteger fieldTag);

@property (nonatomic,copy) void (^didTextFieldDidEndEditing)(NSString* text,NSInteger fieldTag);


@end

NS_ASSUME_NONNULL_END
