//
//  YLMyCollectModel.h
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YLArtificerModel,YPIndexDealsModel;

@interface YLMyCollectModel : NSObject

@property (nonatomic,strong) NSDictionary* artificerDetail;
@property (nonatomic,copy) NSString *artificerId;
@property (nonatomic,copy) NSString *artificerName;
@property (nonatomic,copy) NSString *collectionId; //唯一主键
@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,strong) NSDictionary* merchantDetail;
@property (nonatomic,copy) NSString *merchantId;
@property (nonatomic,copy) NSString *merchantName;
@property (nonatomic,strong)NSNumber  *type;
@property (nonatomic,copy) NSString *userId;


@property (nonatomic,strong) YLArtificerModel *artificerDetailModel;
@property (nonatomic,strong) YPIndexDealsModel *merchantDetailModel;
@property (nonatomic,assign) YLMerchantOrArtificerIdType collectType;


@end

/*
 
 收藏 {
 artificerDetail (技师, optional): 技师详情 ,
 artificerId (string, optional): 技师ID ,
 artificerName (string, optional): 技师名称 ,
 collectionId (string): 唯一主键 ,
 createTime (string): 创建时间 ,
 merchantDetail (店铺, optional): 店铺详情 ,
 merchantId (string, optional): 店铺ID ,
 merchantName (string, optional): 商家名称 ,
 type (integer): 类型，1店铺、2技师、3内容 ,
 userId (string): 用户ID
 }
 */
