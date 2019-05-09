//
//  HGTabButton.m
//  HiGo
//
//  Created by caine on 2017/9/19.
//  Copyright © 2017年 Think_lion. All rights reserved.
//

#import "HGTabButton.h"

@implementation HGTabButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{}


-(void)setItem:(UITabBarItem *)item
{
    _item=item;
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
   // [self setTitle:item.title forState:UIControlStateNormal];
    
}




@end
