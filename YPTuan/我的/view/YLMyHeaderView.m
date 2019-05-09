//
//  YLMyHeaderView.m
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLMyHeaderView.h"
#import "YLMyCenterCardView.h"
#define IMGHEIGHT 80

@interface YLMyHeaderView ()
@property (nonatomic,strong) YLMyCenterCardView *colectView;


@end

@implementation YLMyHeaderView{
    UIImageView* _iconImgView;
    UILabel* _nameLab;
    UIView* _bgView ;

}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorTitleLIGHTGRAYNormal;
        [self creatView];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    !self.didHeaderViewBlock ? : self.didHeaderViewBlock();
}

-(void)creatView{

    _bgView= [UIView new];
    _bgView.backgroundColor = MainBackColor;
    
    _iconImgView = [UIImageView new];
    _iconImgView.image = IMAGENAME(@"two");
    _iconImgView.layer.masksToBounds = YES;
    _iconImgView.layer.cornerRadius  = IMGHEIGHT/2;
    
    _nameLab = [UILabel labelWithFrame:CGRectZero textColor:kColorLogin font:HNW6Font(18) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    _nameLab.text = @"登录";
//    _nameLab.layer.masksToBounds = YES;
//    _nameLab.layer.borderColor = kColorLogin.CGColor;
//    _nameLab.layer.borderWidth = 1;
//    _nameLab.layer.cornerRadius = BaseCornerRadius;

    
  

    [self sd_addSubviews:@[_bgView,_iconImgView,_nameLab]];
    [self addSubview:self.colectView];
    [self addSubview:self.lottieLogo];
    
   

    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.lottieLogo.sd_layout
    .topSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .heightIs(44)
    .widthIs(44);
    
    _bgView.sd_layout
    .bottomSpaceToView(self, BaseBtnHeight64/2)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self);

    _iconImgView.sd_layout
    .topSpaceToView(self, 50)
    .centerXEqualToView(self)
    .heightIs(IMGHEIGHT)
    .widthEqualToHeight();
    
    _nameLab.sd_layout
    .topSpaceToView(_iconImgView, 10)
    .centerXEqualToView(_iconImgView)
    .heightIs(30)
    .widthIs(kScreenWidth-40);
    
    
    self.colectView.sd_layout
    .bottomEqualToView(self)
    .leftSpaceToView(self, BaseBtnPadding)
    .rightSpaceToView(self, BaseBtnPadding)
    .heightIs(BaseBtnHeight64);
    
}

-(void)updataView{
    if ([UserModelSisingle userId].length > 0) {
        _nameLab.text = [UserModelSisingle userName];
        _nameLab.width = kScreenWidth - 40;
        
      //  _nameLab.sd_layout.widthIs(kScreenWidth);
        
    
    }else{
        _nameLab.text = @"登录";
        _nameLab.width = IMGHEIGHT;
    }
    
    [self layoutSubviews];
    
}


-(void)settingTap{
    !self.didSettingTapBlock  ? : self.didSettingTapBlock();
}

-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"gears"];//
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
        _lottieLogo.userInteractionEnabled = YES;
        UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingTap)];
        // 设置轻拍次数
        aTapGR.numberOfTapsRequired = 1;
        // 添加手势
        [_lottieLogo addGestureRecognizer:aTapGR];
    }
    return _lottieLogo;
}

-(YLMyCenterCardView *)colectView{
    if (!_colectView) {
        _colectView = [YLMyCenterCardView new];
        WS(weakSelf);
        _colectView.didMyCollectBtnBlock = ^(YLMerchantOrArtificerIdType type) {
            !weakSelf.didMyCollectBtnBlock ? : weakSelf.didMyCollectBtnBlock(type);

        };
    }
    return _colectView;
}
@end
