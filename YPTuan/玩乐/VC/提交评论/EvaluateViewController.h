//
//  EvaluateViewController.h
//  PhotoSelector
//
//  Created by 洪雯 on 2017/1/12.
//  Copyright © 2017年 洪雯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPublishBaseController.h"
#import "YPIndexDealsModel.h"
#import "YLArtificerModel.h"

//typedef NS_ENUM(NSInteger, CommentForType) {
//    ///商家
//    CommentForTypeMerchant = 1,
//    ///技师
//    CommentForTypeArtificerId,
//
//    
//};

@interface EvaluateViewController : HWPublishBaseController
@property (nonatomic,strong) YPIndexDealsModel *dealsModel;
@property (nonatomic,strong) YLArtificerModel *artificerModel;
@property (nonatomic,assign) YLMerchantOrArtificerIdType type;


@end
