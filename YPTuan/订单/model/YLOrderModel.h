//
//  YLOrderModel.h
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLOrderModel : NSObject


@property (nonatomic,copy) NSString *actualAmount;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *couponId;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *expireTime;
@property (nonatomic,copy) NSString *merchantId;
@property (nonatomic,copy) NSString *merchantName;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,copy) NSString *totalAmount;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *merchantCompressionImageUrl;

@property (nonatomic,strong) NSNumber *state;

@property (nonatomic,assign) ConsumptionCouponsType couponsType;



/*
 
 actualAmount (string): 实际应付金额(单位:分) ,
 content (string, optional): 订单内容，如：50元代金券 ,
 couponId (string, optional): 代金券ID ,
 createTime (string): 创建时间 ,
 expireTime (string): 有效截止时间 ,
 merchantId (string, optional): 商家ID ,
 merchantName (string, optional): 商家名称 ,
 orderId (string): 唯一主键 ,
 orderNo (string): 订单编号 ,
 state (integer): 状态，1待付款、2未消费、3待评价、4已完成、5已失效 ,
 totalAmount (string): 总金额(单位:分) ,
 userId (string): 用户ID ,
 userName (string): 用户账号
 
 */

@end
