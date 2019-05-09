//
//  YPVouchersViewCell.m
//  YPTuan
//
//  Created by Caine on 2018/7/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YPVouchersViewCell.h"

@implementation YPVouchersViewCell{
    UIImageView* _imageView;
    UILabel* _nameLab;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainBackColor;
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    
    _imageView = [UIImageView new];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;;
    
    _nameLab = [UILabel new];
    _nameLab.textColor = [UIColor whiteColor];
    _nameLab.font = [UIFont systemFontOfSize:16];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView sd_addSubviews:@[_imageView,_nameLab]];
    
    UIView* contentView = self.contentView;
    
    _imageView.sd_layout
    .topEqualToView(contentView)
    .leftEqualToView(contentView)
    .rightEqualToView(contentView)
    .bottomSpaceToView(contentView, 30);
    
    _nameLab.sd_layout
    .topSpaceToView(_imageView, 0)
    .leftEqualToView(contentView)
    .rightEqualToView(contentView)
    .bottomEqualToView(contentView);
    
}

-(void)setModel:(YPGlobalModel *)model{
    _model = model;
    _imageView.image = IMAGENAME(model.img);
    _nameLab.text = model.title;
}


@end
