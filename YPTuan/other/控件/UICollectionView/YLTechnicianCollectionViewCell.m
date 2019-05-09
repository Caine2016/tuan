//
//  YLTechnicianCollectionViewCell.m
//  YPTuan
//
//  Created by Caine on 2018/11/29.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLTechnicianCollectionViewCell.h"
#import "YLImgLeftLabRightView.h"
@implementation YLTechnicianCollectionViewCell{
    UIImageView* _imageView;
    UILabel* _nameLab;
    YLImgLeftLabRightView* _likelab;
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
    
    _imageView = [UIImageView new];
    
    _nameLab = [UILabel labelWithFrame:CGRectZero textColor:MainBackColor font:font(17) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
    
    _likelab = [YLImgLeftLabRightView new];
    _likelab.backgroundColor = KVCBGWhiteColor;
    _likelab.labView.textColor = MainBackColor;
    [self.contentView addSubview:_nameLab];
    [self.contentView addSubview:_likelab];
    [self.contentView addSubview:_imageView];
    _imageView.sd_layout
    .leftSpaceToView(self.contentView, BaseBtnHeight0)
    .topSpaceToView(self.contentView, BaseBtnPadding)
    .heightIs(TechnicianCellHeight)
    .widthEqualToHeight();
    
    _nameLab.sd_layout
    .leftSpaceToView(_imageView, BaseBtnPadding)
    .rightSpaceToView(self.contentView, 5)
    .topEqualToView(_imageView)
    .heightIs(30);
    
    _likelab.sd_layout
    .leftEqualToView(_nameLab)
    .topSpaceToView(_nameLab, BaseBtnHeight0)
    .rightEqualToView(_nameLab)
    .heightIs(30);
    
    
    //_imageView.image = IMAGENAME(@"meinv");
    
}

-(void)setArtificerModel:(YLArtificerModel *)artificerModel{
    _artificerModel = artificerModel;
    
    _likelab.imgName = @"like";
    _likelab.title = artificerModel.collectionNum;
    
    NSNumberFormatter *tempNum = [[NSNumberFormatter alloc] init];
    [tempNum setNumberStyle:NSNumberFormatterDecimalStyle];
  //  _likelab.title = [tempNum numberFromString:artificerModel.score];
    

    
    _nameLab.text = artificerModel.artificerName;
    
    [artificerModel.bizMerchantArtificerImages enumerateObjectsUsingBlock:^(YLMerchantImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //obj.compressionImageUrl
        if (obj.imageType == YLMerchantOrArtificerImageTypeCover) {
            [_imageView hg_setImageIconWithUrlString:obj.compressionImageUrl placeholder:nil];
             *stop = YES;
        }
        
    }];
    
   

    

    
    
    
}

@end
