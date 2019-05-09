//
//  YLMyCollectModel.m
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLMyCollectModel.h"
#import "YLArtificerModel.h"
#import "YPIndexDealsModel.h"
@implementation YLMyCollectModel

-(void)setArtificerDetail:(NSDictionary *)artificerDetail{
    _artificerDetail = artificerDetail;
    self.artificerDetailModel = [YLArtificerModel mj_objectWithKeyValues:artificerDetail];
}

-(void)setMerchantDetail:(NSDictionary *)merchantDetail{
    _merchantDetail = merchantDetail;
    self.merchantDetailModel = [YPIndexDealsModel mj_objectWithKeyValues:merchantDetail];
}

-(void)setType:(NSNumber *)type{
    _type = type;
    self.collectType = [type integerValue];
}

@end
