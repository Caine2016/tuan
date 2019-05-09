//
//  GDFeedbackImageAndDelView.m
//  buddhismYDniu
//
//  Created by gd on 2018/4/19.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDFeedbackImageAndDelView.h"

@implementation GDFeedbackImageAndDelView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
}
//fy_close_img

-(void)creatView{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.width, self.height)];
    //不拉伸
    self.imageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imageView.clipsToBounds  = YES;
    
     [self addSubview:self.imageView];
    
   UIButton* addBtn = [MyButton addBtnImage:@"bookDel" title:nil tag:0 frame:CGRectMake(self.width - 30, 0, 30, 30) andFont:0 andNormalTitleColor:nil andSelectTitleColor:nil andcontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter andSelectedImg:nil];
 
    [self addSubview:addBtn];
    
    [addBtn addTarget:self action:@selector(delImage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)delImage{
    
    !self.delViewBlock ? : self.delViewBlock();
    
}

@end
