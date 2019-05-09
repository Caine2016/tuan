//
//  YLMerchantImagesModel.m
//  YPTuan
//
//  Created by gd on 2018/12/5.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLMerchantImagesModel.h"

@implementation YLMerchantImagesModel

-(void)setType:(NSNumber *)type{
    _type = type;
    self.imageType = [type integerValue];
}

@end
