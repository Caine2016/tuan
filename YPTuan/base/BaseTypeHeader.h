//
//  BaseTypeHeader.h
//  YPTuan
//
//  Created by Caine on 2018/12/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#ifndef BaseTypeHeader_h
#define BaseTypeHeader_h

typedef NS_ENUM(NSInteger, YLMerchantOrArtificerIdType) {
    ///商店
    YLMerchantOrArtificerIdTypeMerchant = 1,
    ///技师
    YLMerchantOrArtificerTypeArtificer = 2,

};

///订单类型
typedef NS_ENUM(NSInteger, ConsumptionCouponsType) {
    ///待付款
    ConsumptionCouponsTypePayment = 1,
     ///代销费
    ConsumptionCouponsTypeConsumption ,
    ///待评价
    ConsumptionCouponsTypeEvaluate,
    ///已完成
    ConsumptionCouponsTypeCompleted,
    ///已失效
    ConsumptionCouponsTypeFailure
};

#endif /* BaseTypeHeader_h */
