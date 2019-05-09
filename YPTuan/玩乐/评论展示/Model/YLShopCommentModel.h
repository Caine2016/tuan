//
//  YLShopCommentModel.h
//  YPTuan
//
//  Created by gd on 2018/12/6.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLMerchantImagesModel.h"
@interface YLShopCommentModel : NSObject

@property (nonatomic, copy) NSString *merchantId;
@property (nonatomic, copy) NSString *artificerId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userNickname;
@property (nonatomic, copy) NSString *pointJson;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, copy) NSString *score;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;


@property (nonatomic,strong) NSArray<YLMerchantImagesModel*> *commentImages;

@property (nonatomic,strong) NSNumber *type;


@end
