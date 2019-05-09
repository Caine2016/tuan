//
//  GDSearchView.h
//  buddhismYDniu
//
//  Created by gd on 2018/6/13.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDTextFieldPlaceholderView;
@interface GDSearchView : UIView

@property (nonatomic,copy) void (^searchViewBlock)(NSString* textFiledText);

@property (nonatomic,copy) void(^textChangeActionBlock)(NSString* textFiledText) ;

@property (nonatomic, strong) GDTextFieldPlaceholderView      *searchText;

@property (nonatomic,copy) NSString *text;


@end
