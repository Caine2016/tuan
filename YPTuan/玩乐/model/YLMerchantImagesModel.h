//
//  YLMerchantImagesModel.h
//  YPTuan
//
//  Created by gd on 2018/12/5.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YLMerchantOrArtificerImageType) {
    ///封面图
    YLMerchantOrArtificerImageTypeCover = 1,
    ///展示图
    YLMerchantOrArtificerImageTypeShow,
    
    
};

@interface YLMerchantImagesModel : NSObject

@property (nonatomic,strong) NSString *merchantId;
@property (nonatomic,strong) NSNumber *type;  //type (integer): 类型，1封面图、2展示图
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *compressionImageUrl;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSNumber *seq;  //序号
@property (nonatomic,strong) NSString *merchantImageId;
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *commentImageId;

@property (nonatomic,assign) YLMerchantOrArtificerImageType imageType;




@property (nonatomic,strong) NSString *artificerId; //技师ID
@property (nonatomic,strong) NSString *artificerImageId; //主键ID



//artificerId (string, optional): 技师ID ,
//artificerImageId (string): 主键ID ,
//compressionImageUrl (string): 原图对应的压缩图URL ,
//createTime (string): 创建时间 ,
//imageUrl (string): 图片URL ,
//merchantId (string, optional): 商家ID ,
//modifyTime (string, optional): 修改时间 ,
//seq (integer, optional): 序号 ,
//type (integer): 类型，1封面图、2展示图


@end
