//
//  YLImgLeftLabRightView.m
//  YPTuan
//
//  Created by gd on 2018/11/21.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLImgLeftLabRightView.h"

@implementation YLImgLeftLabRightView{
    UIImageView* _imgView;
  
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    _imgView = [UIImageView new];
    
    _labView = [UILabel labelWithFrame:CGRectZero textColor:KVCBGWhiteColor font:otherFont(@"ChalkboardSE-Light", 14) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    
    [self sd_addSubviews:@[_imgView,_labView]];
    
 
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat padding = 5;
    
    
    
    _imgView.sd_layout
    .leftSpaceToView(self, padding)
    .centerYEqualToView(self)
    .heightIs(20)
    .widthEqualToHeight();
    
    _labView.sd_layout
    .leftSpaceToView(_imgView, padding)
    .rightSpaceToView(self, padding)
    .topEqualToView(self)
    .bottomEqualToView(self);
}

- (void)setTitle:(NSNumber *)title{
    _labView.text = [XTools returnIntWan:[title floatValue]];

}

-(void)setImgName:(NSString *)imgName{
    _imgView.image = IMAGENAME(imgName);
}


@end
