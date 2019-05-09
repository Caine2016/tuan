//
//  GDSearchHeaderView.m
//  buddhismYDniu
//
//  Created by gd on 2018/3/24.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDSearchHeaderView.h"

@interface GDSearchHeaderView ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation GDSearchHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = VCBGColor;
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth, 35)];
    titleLab.textColor = COLOR_999;
    titleLab.font = font(18);
    titleLab.text = @"热词搜索";
    [self addSubview:titleLab];
    self.titleLab = titleLab;
 
    [self.layer addSublayer:
     [GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(8, 38) andLineToPoint:CGPointMake(kScreenWidth-8, 38)]];
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = title;
}


@end
