//
//  YLArtificerModel.h
//  YPTuan
//
//  Created by Caine on 2018/12/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLMerchantImagesModel.h"
NS_ASSUME_NONNULL_BEGIN

/*
 artificerId (string): 主键ID ,
 artificerName (string, optional): 店铺名称 ,
 artificerNum (string, optional): 技师编号 ,
 attitudeScore (string, optional): 态度评分 ,
 bizMerchantArtificerImages (Array[技师图片], optional): 商家图片 ,
 collectionNum (integer, optional): 收藏数 ,
 createTime (string): 创建时间 ,
 evaluateJson (string, optional): 评价json ,
 evaluateNum (integer, optional): 评价数 ,
 imageScore (string, optional): 形象评分 ,
 merchantId (string): 店铺ID ,
 merchantName (string): 店铺名称 ,
 modifyTime (string): 修改时间 ,
 score (string, optional): 评分 ,
 seq (integer, optional),
 skillScore (string, optional): 手法评分
 
 **/

@interface YLArtificerModel : NSObject

@property (nonatomic,copy) NSString *artificerId;
@property (nonatomic,copy) NSString *artificerName;
@property (nonatomic,copy) NSString *artificerNum;
@property (nonatomic,copy) NSString *attitudeScore;
@property (nonatomic,strong) NSNumber *collectionNum;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *evaluateJson;
@property (nonatomic,copy) NSString *imageScore;
@property (nonatomic,copy) NSString *merchantId;
@property (nonatomic,copy) NSString *modifyTime;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,copy) NSString *skillScore;

@property (nonatomic,copy) NSArray <YLMerchantImagesModel*>*bizMerchantArtificerImages;

@end

NS_ASSUME_NONNULL_END
