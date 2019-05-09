//
//  HGSetUpSelectCell.h
//  buddhismYDniu
//
//  Created by longchenghua on 2017/9/25.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YLCenterModel.h"
@interface HGSetUpSelectCell : BaseTableViewCell
@property (nonatomic,strong) YLCenterModel *model;
@property (nonatomic,assign) BOOL                 isHiddenIconImageView;


@end
