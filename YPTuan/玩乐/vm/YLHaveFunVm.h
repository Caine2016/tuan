//
//  YLHaveFunVm.h
//  YPTuan
//
//  Created by gd on 2018/12/5.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLHaveFunVm : NSObject

SISingletonH(YLHaveFunVm)

///获取商店数据
-(void)getShopDataByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andShopData:(void(^)(NSDictionary*))data;

///获取商店评论
-(void)getShopCommentByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andMerchantId:(NSString*)merchantId andShopData:(void(^)(NSDictionary*))data;

///获取技师评论
-(void)getArtificerCommentByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andArtificerId:(NSString*)artificer andArtificerData:(void(^)(NSArray*,NSInteger))data;


///获取技师数据
-(void)getArrificerByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andMerchantId:(NSString*)merchantId andArrificerData:(void(^)(NSArray*,NSInteger))data;

///收藏
-(void)colloctMerchantOrArtificerId:(NSString*)MoAid userName:(NSString*)userName andType:(NSInteger)type andReturnData:(void (^)(NSDictionary *))data;

///收藏状态
-(void)colloctStatusMerchantOrArtificerId:(NSString *)MoAid userName:(NSString *)userName andType:(NSInteger)type andReturnData:(void (^)(BOOL isCollect))data;

///获取用户收藏
-(void)getMyCollectByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andUsername:(NSString*)Username andType:(YLMerchantOrArtificerIdType)type andCollectData:(void(^)(NSArray*,NSInteger))data;


@end
