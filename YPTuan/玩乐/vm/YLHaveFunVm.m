//
//  YLHaveFunVm.m
//  YPTuan
//
//  Created by gd on 2018/12/5.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLHaveFunVm.h"
#import "YLArtificerModel.h"
#import "YLShopCommentModel.h"
#import "YPIndexDealsModel.h"
#import "YLMyCollectModel.h"
@implementation YLHaveFunVm

SISingletonM(YLHaveFunVm)

-(void)getShopDataByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andShopData:(void(^)(NSDictionary*))data{
    NSDictionary* dicParams = @{
        @"current" : @(pageindex),
        @"size"    : @(pagesize)
    };
  
    [BaseDataServiceSISingle getUrl:GetAllShopInfo andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
       // CNSLog(@"GetAllShopInfo %@-",responseData.returnData);
        data(responseData.returnData);
    }];
}

-(void)getShopCommentByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andMerchantId:(NSString *)merchantId andShopData:(void (^)(NSDictionary *))data{
    NSDictionary* dicParams = @{
                                @"current" : @(pageindex),
                                @"size"    : @(pagesize),
                                };
    NSString* url = [GetAllShopCommentUrl stringByAppendingString:merchantId];
    [BaseDataServiceSISingle getUrl:url andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"GetAllShopCommentUrl %@-",responseData.returnData);
        data(responseData.returnData);
    }];
    
}

///获取技师评论
-(void)getArtificerCommentByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andArtificerId:(NSString*)artificer andArtificerData:(void(^)(NSArray*,NSInteger))data{
    
    NSDictionary* dicParams = @{
                                @"current" : @(pageindex),
                                @"size"    : @(pagesize),
                                };
    NSString* url = [GetAllArtificerCommentUrl stringByAppendingString:artificer];
    [BaseDataServiceSISingle getUrl:url andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        
        CNSLog(@"GetAllShopCommentUrl %@-",responseData.returnData);
        NSInteger size = [responseData.returnData[@"total"] integerValue];
        NSArray* commentModelArr = [YLShopCommentModel mj_objectArrayWithKeyValuesArray:responseData.returnData[@"records"]];
        
        data(commentModelArr,size);
    }];
    
    
}

-(void)getArrificerByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andMerchantId:(NSString*)merchantId andArrificerData:(void(^)(NSArray*,NSInteger))data{
    
    NSDictionary* dicParams = @{
                                @"current" : @(pageindex),
                                @"size"    : @(pagesize),
                                };
    NSString* url = [GetRtificersMerchantURL stringByAppendingString:merchantId];
    
    [BaseDataServiceSISingle getUrl:url andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"Arrificer %@-",responseData.returnData);
        NSInteger size = [responseData.returnData[@"total"] integerValue];
        NSArray* result =  [YLArtificerModel mj_objectArrayWithKeyValuesArray:responseData.returnData[@"records"]];
        
        data(result,size);
        
        
    }];
}
#pragma mark --收藏处理--
-(void)colloctMerchantOrArtificerId:(NSString*)MoAid userName:(NSString*)userName andType:(NSInteger)type andReturnData:(void (^)(NSDictionary *))data{
    
    NSString* tmpKey = type == YLMerchantOrArtificerIdTypeMerchant ? @"merchantId" : @"artificerId";
    
    NSDictionary* dicParams = @{
                                @"userName" : userName,
                                @"type"    : @(type),
                                tmpKey : MoAid,
                                };
 //   NSString* url = [ColloctMerchantArtificerUrl stringByAppendingString:merchantId];

    [BaseDataServiceSISingle postUrlJoiningTogether:ColloctMerchantArtificerUrl andParams:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"ColloctMerchantArtificerUrl %@-",responseData);
        data(responseData.returnData);
    }];
    
    
}

-(void)colloctStatusMerchantOrArtificerId:(NSString *)MoAid userName:(NSString *)userName andType:(NSInteger)type andReturnData:(void (^)(BOOL isCollect))data{
    NSString* tmpKey = type == YLMerchantOrArtificerIdTypeMerchant ? @"merchantId" : @"artificerId";
    
    NSDictionary* dicParams = @{
                                @"type"    : @(type),
                                tmpKey : MoAid,
                                };
    NSString* url = [ColloctMerchantArtificerUrl stringByAppendingString:userName];
    
    [BaseDataServiceSISingle getUrl:url andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"评论桩体 %@-",responseData.returnData);
    //    NSArray* result =  [YLArtificerModel mj_objectArrayWithKeyValuesArray:responseData.returnData];
        BOOL collect = [responseData.returnData boolValue];
        data(collect);
        
        
    }];
    
}

-(void)getMyCollectByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andUsername:(NSString *)Username andType:(YLMerchantOrArtificerIdType)type andCollectData:(void (^)(NSArray *, NSInteger))data{
    
    NSDictionary* dicParams = @{
                                @"userName" : Username,
                                @"type"    : @(type),
                                @"current" : @(pageindex),
                                @"size" : @(pagesize)
                                };
    
    
    [BaseDataServiceSISingle getUrl:ColloctMerchantArtificerUrl andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"收藏数据 %@-",responseData.returnData);
        
        NSInteger size = [responseData.returnData[@"total"] integerValue];
        
        NSArray<YLMyCollectModel*>* collectModelArr = [YLMyCollectModel mj_objectArrayWithKeyValuesArray:responseData.returnData[@"records"]];
        
        NSMutableArray* tmpModelArr = [NSMutableArray array];
        
        [collectModelArr enumerateObjectsUsingBlock:^(YLMyCollectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (type == YLMerchantOrArtificerTypeArtificer) {
                [tmpModelArr addObject:obj.artificerDetailModel];
            }else{
                [tmpModelArr addObject:obj.merchantDetailModel];
            }
        }];
        
//        NSArray* result ;
//        if (type == YLMerchantOrArtificerTypeArtificer) {
//            result =  [YLArtificerModel mj_objectArrayWithKeyValuesArray:responseData.returnData[@"records"]];
//        }else{
//            result =  [YPIndexDealsModel mj_objectArrayWithKeyValuesArray:responseData.returnData[@"records"]];
//        }
        
        data(tmpModelArr,size);
        
        
    }];

    
}

@end
