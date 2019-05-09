//
//  YLArtificerModel.m
//  YPTuan
//
//  Created by Caine on 2018/12/12.
//  Copyright © 2018年 Caine. All rights reserved.
// git lfs track "*.a" git lfs track "*.exe"

#import "YLArtificerModel.h"

@implementation YLArtificerModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"bizMerchantArtificerImages" : [YLMerchantImagesModel class],
             
             };
}
@end
