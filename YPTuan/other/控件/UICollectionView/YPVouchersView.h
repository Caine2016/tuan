//
//  YPVouchersView.h
//  YPTuan
//
//  Created by Caine on 2018/7/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VouchersViewType) {
    ///商品详情里的配套设备
    VouchersViewTypefacilitiex = 0,
    ///商品详情里的技师详情
    VouchersViewTypeTechnician,

};


@interface YPVouchersView : UIView

@property (nonatomic,strong) NSArray *data;

-(instancetype)initWithFrame:(CGRect)frame andItemSize:(CGSize)itemSizeLayout andFlowInset:(UIEdgeInsets)flowInset andType:(VouchersViewType)type andInteritemSpacing:(CGFloat)interitemSpacing
              andlineSpacing:(CGFloat)lineSpacing;

@end
