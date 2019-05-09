//
//  YLOrderCellView.h
//  YPTuan
//
//  Created by Caine on 2018/11/22.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YLOrderModel.h"

#define OrderCellHeight 160

NS_ASSUME_NONNULL_BEGIN

@interface YLOrderCellView : BaseTableViewCell

@property (nonatomic,strong) YLOrderModel *orderModel;

@end

NS_ASSUME_NONNULL_END
