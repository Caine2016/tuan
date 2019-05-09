//
//  YLOrderDealsVM.h
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLOrderDealsVM : NSObject

SISingletonH(YLOrderDealsVM)

///获取点单
-(void)getUserOderByPageindex:(NSInteger)pageindex andPagesize:(NSInteger)pagesize andUsename:(NSString*)userName andType:(ConsumptionCouponsType)type andArtificerData:(void(^)(NSArray*,NSInteger))data;


@end
