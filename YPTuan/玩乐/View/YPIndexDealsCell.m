//
//  YPIndexDealsCell.m
//  YPTuan
//
//  Created by Caine on 2018/7/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YPIndexDealsCell.h"

@implementation YPIndexDealsCell{
    UIImageView* _iconImageView;
    UILabel* _nameLab;
    UIImageView* _evaluationImageView;
    UILabel* _priceLab;
    UILabel* _addressLab;
    UIView* _lineView;
    YYLabel* _vouchersLab;
    UIView* _lineView2;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addView];
    }
    return self;
}


-(void)addView{
    
    _iconImageView = [UIImageView new];
    
    _nameLab = [UILabel new];
    _nameLab.font = [UIFont systemFontOfSize:18.f];
    _nameLab.textColor = [UIColor blackColor];
    
    _priceLab = [UILabel new];
    _priceLab.font = [UIFont systemFontOfSize:15.f];
    _priceLab.textColor = COLOR_999;
    
    _addressLab = [UILabel new];
    _addressLab.font = [UIFont systemFontOfSize:15.f];
    _addressLab.textColor = COLOR_999;
    _addressLab.numberOfLines = 2;
    
    _evaluationImageView = [UIImageView new];
    
    _lineView = [UIView new];
    _lineView.backgroundColor = kColorTitleLIGHTGRAYNormal;
    
    _lineView2 = [UIView new];
    _lineView2.backgroundColor = VCBGColor;
    
    _vouchersLab = [YYLabel new];
                    
    [ self.contentView sd_addSubviews:@[_iconImageView,_nameLab,_priceLab,_addressLab,_evaluationImageView,_lineView,_vouchersLab,_lineView2]];
    
    CGFloat margin = 10;
    UIView* contentView = self.contentView;
    
    
    _iconImageView.sd_layout
    .topSpaceToView(contentView, margin*2)
    .leftSpaceToView(contentView, margin)
    .widthIs(80)
    .heightIs(80);
    
    _nameLab.sd_layout
    .topEqualToView(_iconImageView)
    .leftSpaceToView(_iconImageView, margin)
    .heightIs(30)
    .rightSpaceToView(contentView, margin*2);
    
    _evaluationImageView.sd_layout
    .topSpaceToView(_nameLab, 0)
    .leftEqualToView(_nameLab)
    .widthIs(25)
    .heightIs(25);
    
    _priceLab.sd_layout
    .leftSpaceToView(_evaluationImageView, margin)
    .topEqualToView(_evaluationImageView)
    .rightSpaceToView(contentView, margin*2)
    .heightIs(25);
    
    _addressLab.sd_layout
    .topSpaceToView(_evaluationImageView, 0)
    .leftEqualToView(_nameLab)
    .rightSpaceToView(contentView, margin*2)
    .heightIs(38);
    
    _lineView.sd_layout
    .leftEqualToView(_iconImageView)
    .topSpaceToView(_addressLab, margin)
    .heightIs(1)
    .rightSpaceToView(contentView, margin);
    
    _vouchersLab.sd_layout
    .leftEqualToView(_nameLab)
    .topSpaceToView(_lineView, 0)
    .rightSpaceToView(contentView, margin*2)
    .heightIs(44);
    
    _lineView2.sd_layout
    .leftEqualToView(contentView)
    .topSpaceToView(_vouchersLab, 0)
    .bottomEqualToView(contentView)
    .rightSpaceToView(contentView, 0);
    
}

-(void)setModel:(YPIndexDealsModel *)model{
    _model = model;
    
//    _iconImageView.image  = IMAGENAME(model.iconUrl);
    if (model.scoreImage) {
        _evaluationImageView.image = IMAGENAME(model.scoreImage);//评论
    }else{
        _evaluationImageView.image = IMAGENAME(@"eva_perfect_s");//评论
    }
    
    [model.merchantImages enumerateObjectsUsingBlock:^(YLMerchantImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.imageType == YLMerchantOrArtificerImageTypeCover) {
            
            [_iconImageView hg_setImageIconWithUrlString:obj.compressionImageUrl placeholder:nil];
        }
        
    }];
    
    
    _nameLab.text = model.merchantName;
    
    _addressLab.text = model.address;
    
    if (model.perCapitaAmount.length>0) {
        _priceLab.text = [NSString stringWithFormat:@"人均: $%@",model.perCapitaAmount];

    }
    

    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"tuan"];
                    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
    
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(14, 14) alignToFont:[UIFont systemFontOfSize:14] alignment:YYTextVerticalAlignmentCenter];
    
    [attrString appendAttributedString:attachText];
    
    NSString* couponName ;
    if (model.cashCouponModel.couponName) {
        couponName =  model.cashCouponModel.couponName ;
    }else{
       couponName = @"暂无";
    }
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" $ %.2f",[model.cashCouponModel.amount floatValue]/100] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:kColorLogin}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",couponName] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blackColor]}];
    [attrString appendAttributedString:str1];
    [attrString appendAttributedString:str2];
    _vouchersLab.attributedText = attrString;
    

    
    
}
@end
