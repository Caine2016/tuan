//
//  YLBeautyShowView.m
//  YPTuan
//
//  Created by gd on 2018/11/21.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLBeautyShowView.h"
#import "WaterflowView.h"
#import "YLImgLeftLabRightView.h"
@interface YLBeautyShowView()

@property (weak, nonatomic) UIImageView *imageView;
@property (nonatomic,weak) YLImgLeftLabRightView *likelab;
@property (nonatomic,weak) YLImgLeftLabRightView *commentslab;

@end

@implementation YLBeautyShowView

+ (instancetype)cellWithWaterflowView:(WaterflowView *)waterflowView
{
    static NSString *ID = @"SHOP";
    YLBeautyShowView *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YLBeautyShowView alloc] init];
        cell.identifier = ID;
    }
    return cell;
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
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    YLImgLeftLabRightView* likelab = [YLImgLeftLabRightView new];
    likelab.backgroundColor = RGBACOLOR(0, 0, 0, .3);
     [self addSubview:likelab];
    self.likelab = likelab;
    
    YLImgLeftLabRightView* commentslab = [YLImgLeftLabRightView new];
    commentslab.backgroundColor = RGBACOLOR(0, 0, 0, .3);
    [self addSubview:commentslab];
    self.commentslab = commentslab;
    
    
}

-(void)setModel:(YLTechnicianModel *)model{
    _model = model;
//    [self.imageView setImageWithURL:[NSURL URLWithString:model.imgName] placeholder:IMAGENAME(@"meinv")];
    self.imageView.image = IMAGENAME(@"meinv");
    self.likelab.title = model.likeCount;
    self.likelab.imgName = @"like";
    self.commentslab.title = model.commentCount;
    self.commentslab.imgName = @"comment";
    
}

-(void)setArtificerModel:(YLArtificerModel *)artificerModel{
    _artificerModel = artificerModel;
    
     self.likelab.imgName = @"like";
    self.commentslab.imgName = @"comment";
    NSNumberFormatter *tempNum = [[NSNumberFormatter alloc] init];
    [tempNum setNumberStyle:NSNumberFormatterDecimalStyle];
     self.commentslab.title = [tempNum numberFromString:artificerModel.score];
    self.likelab.title = artificerModel.collectionNum;

    [artificerModel.bizMerchantArtificerImages enumerateObjectsUsingBlock:^(YLMerchantImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.imageType == YLMerchantOrArtificerImageTypeCover) {

            [self.imageView hg_setImageIconWithUrlString:obj.compressionImageUrl placeholder:nil];
            
             *stop = YES;
        }
        
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
    CGFloat priceX = 0;
    CGFloat priceH = 30;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width/2;
    
    self.likelab.frame = CGRectMake(priceX, priceY, priceW, priceH);
    self.commentslab.frame = CGRectMake(priceW, priceY, priceW, priceH);
    

    
    
}



@end
