//
//  GDTextFieldPlaceholderView.m
//  buddhismYDniu
//
//  Created by gd on 2018/7/9.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDTextFieldPlaceholderView.h"

@implementation GDTextFieldPlaceholderView

- (void)drawPlaceholderInRect:(CGRect)rect {
    
    if (@available(iOS 11.0, *)) {
         [super drawPlaceholderInRect:CGRectMake(0, self.bounds.size.height * 0.3 , 0, 0)];
    }else{
         [super drawPlaceholderInRect:CGRectMake(0, self.bounds.size.height * 0.5 - 0.5 , 0, 0)];
    }

   //
    
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
  
    originalRect.size.height = self.font.lineHeight - 4;
    
    originalRect.size.width = 1;
    
    originalRect.origin.y = (self.height - originalRect.size.height)/2 ;
    
    return originalRect;
}

@end
