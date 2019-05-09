//
//  YLOrderCellView.m
//  YPTuan
//
//  Created by Caine on 2018/11/22.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLOrderCellView.h"

@implementation YLOrderCellView{
    UIView* _bgView;
    UILabel* _serialNumberLab;
    UILabel* _stateLab;
    UIImageView* _iconImgView;
    UILabel* _storeAndVouchersLab;
    UILabel* _priceLab;
    
    
    UIButton* _cancelBtn;
    UIButton* _moreBtn;

    
}

- (void)createSubViews{
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(BaseBtnPadding, BaseBtnPadding/2,kScreenWidth -BaseBtnPadding*2,OrderCellHeight-BaseBtnPadding)];
    _bgView.backgroundColor = KVCBGWhiteColor;
    [_bgView hyb_addCornerRadius:BaseCornerRadius];
    [self.contentView addSubview:_bgView];
    
    _serialNumberLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:BaseFont16 numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    _serialNumberLab.text = @"订单编号:24355";
    _stateLab = [UILabel labelWithFrame:CGRectZero textColor:kColorLogin font:BaseFont16 numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    _stateLab.text = @"待付款";
    
    
    _iconImgView = [UIImageView new];
    _iconImgView.contentMode = UIViewAutoresizingFlexibleHeight;
    _iconImgView.image = IMAGENAME(@"two");
    
    _storeAndVouchersLab = [UILabel new];
    _storeAndVouchersLab.numberOfLines = 0;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"阿曼尼\n" attributes:@{NSFontAttributeName:otherFont(@"AppleSDGothicNeo-Bold", 16), NSForegroundColorAttributeName:MainBackColor}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"70元代金券" attributes:@{NSFontAttributeName:otherFont(@"MarkerFelt-Wide", 18), NSForegroundColorAttributeName: [UIColor redColor]}];
    [attrString appendAttributedString:str1];
    [attrString appendAttributedString:str2];
    _storeAndVouchersLab.attributedText = attrString;
    
    _priceLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:jsFont(14) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    _priceLab.text = @"应付:￥2.00元";
    
    
    
    [_bgView sd_addSubviews:@[_serialNumberLab,_stateLab,_iconImgView,_storeAndVouchersLab,_priceLab]];
    
    _serialNumberLab.sd_layout
    .topEqualToView(_bgView)
    .leftSpaceToView(_bgView, BaseBtnPadding)
    .heightIs(30)
    .widthIs(_bgView.width/2);
    _stateLab.sd_layout
    .topEqualToView(_bgView)
    .rightSpaceToView(_bgView, BaseBtnPadding)
    .heightIs(30)
    .widthIs(_bgView.width/2);
    
    [_bgView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding, _serialNumberLab.bottom) andLineToPoint:CGPointMake(_bgView.width-2*BaseBtnPadding, _serialNumberLab.bottom)]];
    
    _iconImgView.sd_layout
    .topSpaceToView(_serialNumberLab, 8)
    .leftSpaceToView(_bgView, BaseBtnPadding)
    .heightIs(60)
    .widthEqualToHeight();
    _storeAndVouchersLab.sd_layout
    .topEqualToView(_iconImgView)
    .leftSpaceToView(_iconImgView, BaseBtnPadding)
    .rightSpaceToView(_bgView, BaseBtnPadding)
    .heightIs(60);
    
      [_bgView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding,106) andLineToPoint:CGPointMake(_bgView.width-2*BaseBtnPadding,106)]];
    
    _priceLab.sd_layout
    .bottomEqualToView(_bgView)
    .leftEqualToView(_iconImgView)
    .widthIs(100)
    .heightIs(44);
    
    CGFloat btnW = 75;
    CGFloat btnH = 32;
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(_bgView.width-btnW-BaseBtnPadding, _bgView.height - btnH - 7 , btnW, btnH);
    _moreBtn.backgroundColor = KVCBGWhiteColor;
    _moreBtn.tag = 0;
    _moreBtn.titleLabel.font = font(16);
    [_moreBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:KVCBGWhiteColor forState:UIControlStateNormal];
    [_moreBtn hyb_setBackgroundImage:[XTools imageWithColor:kColorLogin] forState:UIControlStateNormal cornerRadius:BaseCornerRadius isEqualScale:YES];
    [_moreBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_moreBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(_bgView.width-2*btnW-2*BaseBtnPadding,  _bgView.height - btnH - 7, btnW, btnH);
    _cancelBtn.backgroundColor = KVCBGWhiteColor;
    _cancelBtn.tag = 1;
    _cancelBtn.titleLabel.font = font(16);
    [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:KVCBGWhiteColor forState:UIControlStateNormal];
    [_cancelBtn hyb_setBackgroundImage:[XTools imageWithColor:kColorLogin] forState:UIControlStateNormal cornerRadius:BaseCornerRadius isEqualScale:YES];
    [_cancelBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_cancelBtn];
    

}

-(void)setOrderModel:(YLOrderModel *)orderModel{
    _orderModel = orderModel;
    [_iconImgView hg_setImageIconWithUrlString:orderModel.merchantCompressionImageUrl placeholder:nil];
    _serialNumberLab.text = [NSString stringWithFormat:@"订单编号%@",orderModel.orderNo];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",orderModel.merchantName] attributes:@{NSFontAttributeName:otherFont(@"AppleSDGothicNeo-Bold", 16), NSForegroundColorAttributeName:MainBackColor}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:orderModel.content attributes:@{NSFontAttributeName:otherFont(@"MarkerFelt-Wide", 18), NSForegroundColorAttributeName: [UIColor redColor]}];
    [attrString appendAttributedString:str1];
    [attrString appendAttributedString:str2];
    _storeAndVouchersLab.attributedText = attrString;
    float price = [orderModel.actualAmount floatValue] / 100;
    switch (orderModel.couponsType) {
        case ConsumptionCouponsTypeConsumption:{///代销费
            _stateLab.text = @"待消费";
            _priceLab.text = [NSString stringWithFormat:@"已付:¥%.2f元",price];


        }
            
            break;
        case ConsumptionCouponsTypePayment:{///待付款
            _stateLab.text = @"待付款";
            
            _priceLab.text = [NSString stringWithFormat:@"应付:¥%.2f元",price];


        }
            
            break;
        case ConsumptionCouponsTypeEvaluate:{//待评价
            _stateLab.text = @"待评价";
            _priceLab.text = [NSString stringWithFormat:@"已付:¥%.2f元",price];


        }
            
            break;
        case ConsumptionCouponsTypeFailure:{//失效
            _stateLab.text = @"已失效";
            _priceLab.text = [NSString stringWithFormat:@"未付:¥%.2f元",price];


        }
            
            break;
        case ConsumptionCouponsTypeCompleted:{//完成
            _stateLab.text = @"已完成";
            _priceLab.text = [NSString stringWithFormat:@"已付:¥%.2f元",price];


        }
            
            break;
            
        default:
            break;
    }
    
}


-(void)btnClickAction:(UIButton*)sender{
    
}
@end
