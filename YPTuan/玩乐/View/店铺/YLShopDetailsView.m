//
//  YLShopDetailsView.m
//  YPTuan
//
//  Created by gd on 2018/11/26.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLShopDetailsView.h"
#import "GCImgTopAndTitleDownView.h"
#import "YPVouchersView.h"
#import "GDImageLabelLeftRightView.h"

#define AddressAndCallMarght 80
#define FacilitiexHeight 30
@implementation YLShopDetailsView{
    UILabel* _shopNameLab;
    GDImageLabelLeftRightView* _addressBtn;
    UIButton* _callBtn;
    
    UILabel* _timeLab;
    UILabel* _facilitiexLab; //设备
    YPVouchersView* _facilitiexView;
    UIImageView* _starImg;
    UILabel* _starLab;
    UILabel* _priceLab;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
}

-(void)creatView{
    
    _shopNameLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:HNW6Font(20) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];

    _addressBtn = [GDImageLabelLeftRightView new];
    _addressBtn.didImageLabelLeftRightViewTouchBlock = ^{
        
    };

    _callBtn = [UIButton buttonWithFrame:CGRectZero normalImage:IMAGENAME(@"call") target:self action:@selector(btnClickAction:)];
    
    _timeLab = [UILabel labelWithFrame:CGRectZero textColor:kColorTitleTabbarNormal font:font(16) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    _facilitiexLab = [UILabel labelWithFrame:CGRectZero textColor:kColorTitleTabbarNormal font:font(17) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    _starLab = [UILabel labelWithFrame:CGRectZero textColor:kColorTitleTabbarNormal font:font(17) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    _starImg  = [UIImageView new];
    
    _priceLab = [UILabel labelWithFrame:CGRectZero textColor:kColorLogin font:otherFont(@"MarkerFelt-Wide", 20)  numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
    
 
    
    
    [self sd_addSubviews:@[_shopNameLab,_addressBtn,_callBtn,_timeLab,_facilitiexLab,_starLab,_priceLab,_starImg]];
    

    _shopNameLab.sd_layout
    .leftSpaceToView(self, BaseBtnPadding)
    .rightSpaceToView(self, BaseBtnPadding)
    .topEqualToView(self)
    .heightIs(BaseBtnHeight44);
    
    _addressBtn.sd_layout
    .topSpaceToView(_shopNameLab, BaseBtnHeight0)
    .leftEqualToView(_shopNameLab)
    .rightSpaceToView(self, AddressAndCallMarght)
    .heightIs(BaseBtnHeight64);
    [self.layer addSublayer:[GDTool solidShapeLayer:MainBackColor andMoveToPoint:CGPointMake(kScreenWidth-AddressAndCallMarght, BaseBtnHeight44) andLineToPoint:CGPointMake(kScreenWidth-AddressAndCallMarght, BaseBtnHeight44+BaseBtnHeight64)]];
    _callBtn.sd_layout
    .topEqualToView(_addressBtn)
    .rightSpaceToView(self, BaseBtnPadding)
    .leftSpaceToView(_addressBtn, BaseBtnPadding)
    .heightIs(BaseBtnHeight64);
    
    _timeLab.sd_layout
    .topSpaceToView(_addressBtn, BaseBtnHeight0)
    .leftEqualToView(_shopNameLab)
    .rightEqualToView(_shopNameLab)
    .heightIs(25);
    
    _facilitiexLab.sd_layout
    .topSpaceToView(_timeLab, BaseBtnHeight0)
    .leftEqualToView(_shopNameLab)
    .heightIs(FacilitiexHeight)
    .widthIs(72);
    
    _starLab.sd_layout
    .topSpaceToView(_facilitiexLab, BaseBtnHeight0)
    .leftEqualToView(_shopNameLab)
    .rightEqualToView(_facilitiexLab)
    .heightIs(FacilitiexHeight);
    _starImg.sd_layout
    .topEqualToView(_starLab)
    .leftSpaceToView(_starLab, BaseBtnPadding)
    .heightIs(FacilitiexHeight)
    .widthEqualToHeight();
    
    _priceLab.sd_layout
    .topEqualToView(_facilitiexLab)
    .bottomEqualToView(_starLab)
    .rightEqualToView(_shopNameLab)
    .widthIs(120);
    
    CGFloat height = 26;
    _facilitiexView = [[YPVouchersView alloc] initWithFrame:CGRectMake(BaseBtnPadding+72+BaseBtnPadding, BaseBtnHeight44+BaseBtnHeight64+25, height*4+2*5, height) andItemSize:CGSizeMake(height, height) andFlowInset:UIEdgeInsetsMake(2, 2,2, 2) andType:VouchersViewTypefacilitiex andInteritemSpacing:0 andlineSpacing:0];
    [self addSubview:_facilitiexView];
    

}

-(void)setModel:(YPIndexDealsModel *)model{
    _model = model;
    _shopNameLab.text = model.merchantName;
    _addressBtn.contentDic = @{
                               @"text"  : model.address,
                               @"Image" : @"addressImg",
                               @"font"  : @(18.f),
                               };
    _timeLab.text = @"营业时间: 9:00~24:00";
    _facilitiexLab.text = @"配套设施:";
    _starLab.text = @"星级:";
    _priceLab.text = @"人均: ¥88";
    _starImg.image = IMAGENAME(@"eva_low_s");
    _facilitiexView.data = @[@"WIFI",@"shower",@"parking",@"eat"];
    
}

-(void)btnClickAction:(UIButton*)sender{
    
}
@end
