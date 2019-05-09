//
//  FanyiSeachView.m
//  buddhismYDniu
//
//  Created by gd on 2017/12/22.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "FanyiSeachView.h"


@interface FanyiSeachView ()



@end


@implementation FanyiSeachView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = kColorLogin.CGColor;
        self.layer.borderWidth = 1;
        
        [self initSuview];
    }
    
    
    return self;
}


-(void) initSuview{
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,(self.height-30)/2, 25, 25)];
    imageView.image = IMAGENAME(@"search_y");
    [self addSubview:imageView];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+5, 0, self.width, self.height)];
    label.text = @"搜索店铺/技师/分类";
    label.textColor = kColorLogin;
    label.font = font(14);
    
    [self addSubview:label];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    !self.block ? : self.block();
    
}

@end
