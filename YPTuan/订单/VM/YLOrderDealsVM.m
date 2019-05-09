//
//  YLOrderDealsVM.m
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLOrderDealsVM.h"
#import "YLOrderModel.h"

@implementation YLOrderDealsVM

SISingletonM(YLOrderDealsVM)

-(void)getUserOderByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andUsename:(NSString *)userName andType:(ConsumptionCouponsType)type andArtificerData:(void (^)(NSArray *, NSInteger))data{
    NSDictionary* dicParams = @{
                                @"state"   : @(type),
                                @"current" : @(pageindex),
                                @"size"    : @(pagesize),
                                };
    NSString* url = [GetUserOrderUrl stringByAppendingString:userName];
    
    [BaseDataServiceSISingle getUrl:url andParamsDic:dicParams andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"Arrificer %@-",responseData.returnData);
        NSInteger size = [responseData.returnData[@"total"] integerValue];
        NSArray* result =  [YLOrderModel mj_objectArrayWithKeyValuesArray:responseData.returnData[@"records"]];
        data(result,size);
    }];
}

@end
