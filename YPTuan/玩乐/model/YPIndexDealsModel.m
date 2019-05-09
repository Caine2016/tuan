//
//  YPIndexDealsModel.m
//  YPTuan
//
//  Created by Caine on 2018/7/14.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YPIndexDealsModel.h"

@implementation YPIndexDealsModel

//-(void)setMerchantImages:(NSArray<YLMerchantImagesModel *> *)merchantImages{
//
//}



+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"merchantImages" : [YLMerchantImagesModel class],
            
              };
}

-(void)setCashCoupon:(NSDictionary *)cashCoupon{
    _cashCoupon = cashCoupon;
    self.cashCouponModel = [YPCommentcashCouponModel mj_objectWithKeyValues:cashCoupon];
}

-(void)setScore:(NSString *)score{
    _score = score;
    switch ([score integerValue]) {
             case 1:{self.scoreImage = @"eva_bottom_s"; break;}
             case 2:{self.scoreImage = @"eva_low_s"; break;}
             case 3:{self.scoreImage = @"eva_level_s"; break;}
             case 4:{self.scoreImage = @"eva_heigh_s"; break;}
             case 5:{self.scoreImage = @"eva_perfect_s"; break;}
        default:
            self.scoreImage = @"eva_heigh_s"; break;
            break;
    }
}

+(NSArray*) getIndexDeal{
    NSArray* arr = @[
                     @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                      @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                      @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                      @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                      @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                     
                      @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                      @{@"tuanUrl":@"tuan",@"pinUrl":@"pin",@"iconUrl":@"icon",@"name":@"御魂水会",@"address":@"南城区 万江",@"price":@(200),@"priceVouchers1":@(2.34),@"pricevouchers2":@(60)},
                     
                     
                     ];
    
    return arr;
}

@end


//YPCommentsMerchantPushModel YPCommentcashCouponModel


@implementation YPCommentsMerchantPushModel

@end

@implementation YPCommentcashCouponModel

@end
