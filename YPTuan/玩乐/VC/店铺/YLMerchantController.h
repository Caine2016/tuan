//
//  YLMerchantController.h
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "HGGlobalController.h"

typedef NS_ENUM(NSInteger, MerchantControllerType) {
    MerchantControllerTypeMyCollect,
   
};

@interface YLMerchantController : HGGlobalController

@property (nonatomic,assign) MerchantControllerType type;

@end
