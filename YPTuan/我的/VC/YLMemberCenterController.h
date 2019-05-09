//
//  YLMemberCenterController.h
//  YPTuan
//
//  Created by gd on 2018/12/27.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLMemberCenterController : BaseTableViewController

@end

NS_ASSUME_NONNULL_END


@interface YLMemberCenterModel : NSObject

@property (nonatomic,copy) NSString *timeLength;
@property (nonatomic,copy) NSString *oldPrice;
@property (nonatomic,copy) NSString *currentPrice;

@property (nonatomic,assign) BOOL isSelect;

@end
