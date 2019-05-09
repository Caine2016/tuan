//
//  YLMyCenterCardView.m
//  YPTuan
//
//  Created by Caine on 2018/11/17.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLMyCenterCardView.h"

@implementation YLMyCenterCardView{
    UIButton* _collectShopBtn;
    UIButton* _collectSTechnicianBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KVCBGWhiteColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = BaseCornerRadius;
//       [self hyb_setImage:[XTools imageWithColor:KVCBGWhiteColor] cornerRadius:BaseCornerRadius onCliped:^(UIImage *clipedImage) {
//
//        }];
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    _collectShopBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"店铺收藏" normalColor:MainBackColor higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(btnClcikAction:)];
    _collectShopBtn.tag = YLMerchantOrArtificerIdTypeMerchant;
    _collectShopBtn.titleLabel.font = HNW3Font(18);
    
    
    _collectSTechnicianBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"技师收藏" normalColor:MainBackColor higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(btnClcikAction:)];
    _collectSTechnicianBtn.tag = YLMerchantOrArtificerTypeArtificer;
    _collectSTechnicianBtn.titleLabel.font = HNW3Font(18);

    [self sd_addSubviews:@[_collectShopBtn,_collectSTechnicianBtn]];
    
    _collectShopBtn.sd_layout
    .bottomEqualToView(self)
    .leftEqualToView(self)
    .heightIs(BaseBtnHeight64)
    .widthIs((kScreenWidth-BaseBtnPadding*2)/2);
    
    [self.layer addSublayer:[GDTool solidShapeLayer:kColorTitleTabbarNormal andMoveToPoint:CGPointMake(_collectShopBtn.right, BaseBtnPadding+5) andLineToPoint:CGPointMake(_collectShopBtn.right, BaseBtnHeight64-BaseBtnPadding*2)]];

    
    _collectSTechnicianBtn.sd_layout
    .bottomEqualToView(self)
    .rightEqualToView(self)
    .heightIs(BaseBtnHeight64)
    .widthIs((kScreenWidth-BaseBtnPadding*2)/2);
}

-(void)btnClcikAction:(UIButton*)sender{
    !self.didMyCollectBtnBlock ? : self.didMyCollectBtnBlock(sender.tag);
}


@end
