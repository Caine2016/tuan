//
//  YLMyCenterCardView.h
//  YPTuan
//
//  Created by Caine on 2018/11/17.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLMyCenterCardView : UIView

@property (nonatomic,copy) void (^didMyCollectBtnBlock)(YLMerchantOrArtificerIdType type);

@end

NS_ASSUME_NONNULL_END
