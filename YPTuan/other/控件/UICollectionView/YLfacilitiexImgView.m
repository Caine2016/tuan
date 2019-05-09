//
//  YLfacilitiexImgView.m
//  YPTuan
//
//  Created by gd on 2018/11/27.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLfacilitiexImgView.h"

@implementation YLfacilitiexImgView{
    UIImageView* _imageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KVCBGWhiteColor;
        [self creatView];
    }
    
    return self;
}
-(void)creatView{
    _imageView = [UIImageView new];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:_imageView];
    
    _imageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
}

-(void)setImgName:(NSString *)imgName{
    _imgName = imgName;
    _imageView.image = IMAGENAME(imgName);
}
@end
