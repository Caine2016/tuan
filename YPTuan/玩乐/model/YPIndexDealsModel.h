//
//  YPIndexDealsModel.h
//  YPTuan
//
//  Created by Caine on 2018/7/14.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLMerchantImagesModel.h"
@class YPCommentcashCouponModel;
@interface YPIndexDealsModel : NSObject

@property (nonatomic,strong) NSString *merchantName;
@property (nonatomic,strong) NSString *catagory;
@property (nonatomic,strong) NSString *cityCode;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *districtCode;
@property (nonatomic,strong) NSString *districtName;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *perCapitaAmount; //人均消费金额
@property (nonatomic,strong) NSString *phoneNum;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *modifyTime;
@property (nonatomic,copy)   NSString *merchantId;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *scoreImage;

@property (nonatomic,strong) NSArray<YLMerchantImagesModel*> *merchantImages;
@property (nonatomic,strong) NSDictionary *cashCoupon;
@property (nonatomic,strong) YPCommentcashCouponModel *cashCouponModel;


@end

///发送评论model
@interface YPCommentsMerchantPushModel : NSObject

@property (nonatomic,copy)   NSString *merchantId;
@property (nonatomic,copy)   NSString *artificerId;
@property (nonatomic,copy)   NSString *userId;
@property (nonatomic,copy)   NSString *userName;
@property (nonatomic,copy)   NSString *userNickname;
@property (nonatomic,strong) NSNumber *type; //评论类型，1商家、2技师

@property (nonatomic,copy) NSString *pointJson;//评分json
@property (nonatomic,copy) NSString *content; ///评论内容
@property (nonatomic,copy) NSString *score; //评分

@end

///消费券

@interface YPCommentcashCouponModel : NSObject
/*
 amount (string): 代金券金额(单位：分) ,
 applicableItems (string): 适用项目[{"itemId":"x","itemName":"xxx","time":"90分钟","price":"39800"},{"itemId":"xx","itemName":"xxxxx","time":"80分钟","price":"38800"}] ,
 cashCouponId (string): 唯一主键 ,
 couponName (string): 券名 ,
 createTime (string): 创建时间 ,
 deductionAmount (string): 抵扣金额(单位：分) ,
 everAmount (string, optional): 曾售金额(单位：分) ,
 merchantId (string): 商家ID ,
 merchantName (string): 商家名称 ,
 modifyTime (string, optional): 修改时间 ,
 purchaseInstructions (string, optional): 购买须知 ,
 remarks (string, optional): 备注 ,
 soldNum (integer, optional): 已售数量 ,
 surplusNum (integer, optional): 剩余数量
 **/
@property (nonatomic,strong) NSString *merchantId;
@property (nonatomic,strong) NSString *merchantName;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSString *deductionAmount;
@property (nonatomic,strong) NSString *everAmount;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,copy)   NSString *applicableItems;
@property (nonatomic,strong) NSString *soldNum;
@property (nonatomic,strong) NSString *surplusNum;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,copy)   NSString *purchaseInstructions;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *modifyTime;
@property (nonatomic,strong) NSString *cashCouponId;
@end


