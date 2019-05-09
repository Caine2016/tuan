//
//  YLBeautyShowView.h
//  YPTuan
//
//  Created by gd on 2018/11/21.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "WaterflowViewCell.h"
#import "YLTechnicianModel.h"
#import "YLArtificerModel.h"
@class WaterflowView;
@interface YLBeautyShowView : WaterflowViewCell

@property (nonatomic,strong) YLTechnicianModel *model;

@property (nonatomic,strong) YLArtificerModel* artificerModel;


+ (instancetype)cellWithWaterflowView:(WaterflowView *)waterflowView;


@end
