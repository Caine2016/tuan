//
//  KMTag.m
//  KMTag
//
//  Created by chavez on 2017/7/13.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "KMTag.h"

@implementation KMTag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setupWithText:(NSString*)text {
    
    self.text = text;
    self.textColor = COLOR_999;
    self.font = [UIFont systemFontOfSize:16];
    UIFont* font = self.font;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    CGRect frame = self.frame;
    frame.size = CGSizeMake(size.width + 20, size.height + 10);
    
    self.frame = frame;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = BaseCornerRadius;
    self.layer.borderColor = self.textColor.CGColor;
    self.layer.borderWidth = 1;
    
//    self.hyb_borderWidth = 1.0;
//    self.hyb_borderColor = self.textColor;
//    [self hyb_addCornerRadius:5];
    

    
}



@end
